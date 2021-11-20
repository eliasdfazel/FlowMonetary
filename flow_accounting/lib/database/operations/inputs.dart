import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/database/structures/financial_reports.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInputs {

  Future<List<FinancialReports>> getAllFinancialReports() async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
      onCreate: (databaseInstance, version) {
        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS financial_reports_database(id INTEGER PRIMARY KEY, '
              'name'
              ' TEXT, type INTEGER)',
        );
      },
      version: 1,
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

  Future<void> deleteFinancialReport(int id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
      onCreate: (databaseInstance, version) {
        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS financial_reports_database(id INTEGER PRIMARY KEY, '
              'name'
              ' TEXT, type INTEGER)',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.delete(
      'financial_reports_database',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertFinancialReport(FinancialReports financialReports) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
      onCreate: (databaseInstance, version) {
        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS financial_reports_database(id INTEGER PRIMARY KEY, '
              'name'
              ' TEXT, type INTEGER)',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      'financial_reports_database',
      financialReports.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

}