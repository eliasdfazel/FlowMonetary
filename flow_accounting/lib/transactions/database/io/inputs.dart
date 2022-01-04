import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInputs {

  static const String databaseTableName = "all_transactions";

  static const transactionDatabase = "transactions_database.db";

  Future<void> insertTransactionData(TransactionsData transactionsData, String? tableName) async {

    var tableNameQuery = (tableName != null) ? tableName : DatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), transactionDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'sourceCardNumber TEXT, '
              'targetCardNumber TEXT, '
              'sourceBankName TEXT'
              'targetBankName TEXT'
              'sourceName TEXT'
              'targetName TEXT'
              'amount TEXT'
              'time TEXT'
              ')',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      transactionsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateTransactionData(TransactionsData transactionsData, String? tableName) async {

    final database = openDatabase(
      join(await getDatabasesPath(), transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : DatabaseInputs.databaseTableName;

    await databaseInstance.update(
      tableNameQuery,
      transactionsData.toMap(),
      where: 'id = ?',
      whereArgs: [transactionsData.id],
    );

    if (databaseInstance.isOpen) {

      databaseInstance.close();

    }

  }

  Future<void> deleteFinancialReport(int id, String? tableName) async {

    final database = openDatabase(
      join(await getDatabasesPath(), transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : DatabaseInputs.databaseTableName;

    await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}