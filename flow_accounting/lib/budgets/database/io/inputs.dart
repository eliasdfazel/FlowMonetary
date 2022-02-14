/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BudgetDatabaseInputs {

  static const String databaseTableName = "all_budgets";

  static const budgetsDatabase = "budgets_database.db";

  Future<void> insertTransactionData(BudgetsData transactionsData, String? tableName,
      {String usernameId = "Unknown"}) async {

    var tableNameQuery = (tableName != null) ? tableName : BudgetDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final database = openDatabase(
      join(await getDatabasesPath(), budgetsDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'budgetName TEXT, '
              'budgetDescription TEXT, '
              'budgetBalance TEXT'
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

}