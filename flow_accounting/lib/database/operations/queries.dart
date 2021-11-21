import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/database/structures/financial_reports.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQueries {

  Future<List<FinancialReports>> getAllFinancialReports() async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query('financial_reports_database');

    return List.generate(maps.length, (i) {
      return FinancialReports(
        id: maps[i]['id'],
        name: maps[i]['name'],
        type: maps[i]['type'],
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

  Future<FinancialReports> extractFinancialReport(Map<String, Object?>inputData) async {

    return FinancialReports(id: inputData["id"] as int,
        name: inputData["name"].toString(),
        type: inputData["type"] as int);
  }

}