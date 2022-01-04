import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInputs {

  static const String databaseTableName = "all_transactions";

  static const transactionDatabase = "transactions_database.db";

  Future<void> insertFinancialReport(TransactionsData financialReports) async {

    final database = openDatabase(
      join(await getDatabasesPath(), transactionDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $databaseTableName(id INTEGER PRIMARY KEY, '
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
      databaseTableName,
      financialReports.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateDog(TransactionsData financialReports) async {

    final database = openDatabase(
      join(await getDatabasesPath(), transactionDatabase),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      databaseTableName,
      financialReports.toMap(),
      where: 'id = ?',
      whereArgs: [financialReports.id],
    );

    if (databaseInstance.isOpen) {

      databaseInstance.close();

    }

  }

  Future<void> deleteFinancialReport(int id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), transactionDatabase),
    );

    final databaseInstance = await database;

    //SELECT * FROM WHERE
    //  Future<int> delete(String table, {String? where, List<Object?>? whereArgs});
    await databaseInstance.delete(
      'financial_reports_database',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}