/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/14/22, 7:28 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionsDatabaseInputs {

  static const String databaseTableName = "all_transactions";

  static const transactionDatabase = "transactions_database.db";

  Future<void> insertTransactionData(TransactionsData transactionsData, String tableName, String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? TransactionsDatabaseInputs.transactionDatabase : "${usernameId}_${TransactionsDatabaseInputs.transactionDatabase}";
    var tableNameQuery = TransactionsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'transactionTitle TEXT, '
              'transactionDescription TEXT, '
              'sourceCardNumber TEXT, '
              'targetCardNumber TEXT, '
              'sourceBankName TEXT, '
              'targetBankName TEXT, '
              'sourceUsername TEXT, '
              'targetUsername TEXT, '
              'amountMoney TEXT, '
              'transactionType TEXT, '
              'transactionTimeMillisecond TEXT, '
              'transactionTime TEXT, '
              'transactionTimeYear TEXT, '
              'transactionTimeMonth TEXT, '
              'colorTag TEXT, '
              'budgetName TEXT'
              ')',
        );
      },

      version: 1,
      readOnly: false
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      transactionsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }

  }

  Future<void> updateTransactionData(TransactionsData transactionsData, String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? TransactionsDatabaseInputs.transactionDatabase : "${usernameId}_${TransactionsDatabaseInputs.transactionDatabase}";
    var tableNameQuery = TransactionsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      transactionsData.toMap(),
      where: 'id = ?',
      whereArgs: [transactionsData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}