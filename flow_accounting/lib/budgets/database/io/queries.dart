/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/14/22, 6:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/budgets/database/io/inputs.dart';
import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BudgetsDatabaseQueries {

  Future<List<BudgetsData>> getAllBudgets(String tableName,
      String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? BudgetsDatabaseInputs.budgetsDatabase : "${usernameId}_${BudgetsDatabaseInputs.budgetsDatabase}";
    var tableNameQuery = BudgetsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return BudgetsData(
        id: maps[i]['id'],

        budgetName: maps[i]['budgetName'],
        budgetDescription: maps[i]['budgetDescription'],

        budgetBalance: maps[i]['budgetBalance'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<Map<String, Object?>> querySpecificBudgetsByName(
      String budgetName,
      String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? BudgetsDatabaseInputs.budgetsDatabase : "${usernameId}_${BudgetsDatabaseInputs.budgetsDatabase}";
    var tableNameQuery = BudgetsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'budgetName = ?',
      whereArgs: [budgetName],
    );

    return databaseContents[0];
  }

  Future<int> queryDeleteBudget(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? BudgetsDatabaseInputs.budgetsDatabase : "${usernameId}_${BudgetsDatabaseInputs.budgetsDatabase}";
    var tableNameQuery = BudgetsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var queryResult = await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return queryResult;
  }

  Future<BudgetsData> extractBudgetsQuery(
      Map<String, Object?> inputData) async {

    return BudgetsData(
      id: inputData["id"] as int,
      budgetName: inputData['budgetName'].toString(),
      budgetDescription: inputData['budgetDescription'].toString(),
      budgetBalance: inputData['budgetBalance'].toString(),
      colorTag: int.parse(inputData['colorTag'].toString()),
    );
  }

}