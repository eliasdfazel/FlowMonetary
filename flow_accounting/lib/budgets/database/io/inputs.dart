/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInputs {

  String databaseTableName = "all_budgets";

  static const budgetsDatabase = "budgets_database.db";

  Future<void> insertBudget(BudgetsData budgetsData) async {

    final database = openDatabase(
      join(await getDatabasesPath(), budgetsDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $databaseTableName(id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'type INTEGER'
              ')',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      databaseTableName,
      budgetsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateBudget(BudgetsData budgetsData) async {

    final database = openDatabase(
      join(await getDatabasesPath(), budgetsDatabase),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      databaseTableName,
      budgetsData.toMap(),
      where: 'id = ?',
      whereArgs: [budgetsData.id],
    );

    if (databaseInstance.isOpen) {

      databaseInstance.close();

    }

  }

  Future<void> deleteBudget(int id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), budgetsDatabase),
    );

    final databaseInstance = await database;

    await databaseInstance.delete(
      'all_budgets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}