import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQueries {

  Future<List<BudgetsData>> getAllFinancialReports() async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query('financial_reports_database');

    return List.generate(maps.length, (i) {
      return BudgetsData(
        id: maps[i]['id']
      );
    });

  }

  Future<Map<String, Object?>> queryFinancialReport(int id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      'financial_reports_database',
      where: 'id = ?',
      whereArgs: [id],
    );

    return databaseContents[0];
  }

  Future<BudgetsData> extractFinancialReport(Map<String, Object?>inputData) async {

    return BudgetsData(id: inputData["id"] as int);
  }

}