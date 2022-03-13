/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/13/22, 8:17 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BudgetsDatabaseInputs {

  static const String databaseTableName = "all_budgets";

  static const budgetsDatabase = "budgets_database.db";

  Future<void> insertBudgetData(BudgetsData budgetsData, String? tableName,
      String usernameId) async {

    var tableNameQuery = (tableName != null) ? tableName : BudgetsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final database = openDatabase(
      join(await getDatabasesPath(), BudgetsDatabaseInputs.budgetsDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'budgetName TEXT, '
              'budgetDescription TEXT, '
              'budgetBalance TEXT, '
              'colorTag TEXT'
              ')',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      budgetsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateBudgetData(BudgetsData budgetsData, String? tableName, String usernameId) async {

    final database = openDatabase(
      join(await getDatabasesPath(), BudgetsDatabaseInputs.budgetsDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : BudgetsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    await databaseInstance.update(
      tableNameQuery,
      budgetsData.toMap(),
      where: 'id = ?',
      whereArgs: [budgetsData.id],
    );

  }

}