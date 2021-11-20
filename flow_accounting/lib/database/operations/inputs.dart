import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/database/structures/financial_reports.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInputs {

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

  Future<void> updateDog(FinancialReports financialReports) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      'financial_reports_database',
      financialReports.toMap(),
      where: 'id = ?',
      whereArgs: [financialReports.id],
    );
  }

  Future<void> deleteFinancialReport(int id) async {

    final database = openDatabase(
      join(await getDatabasesPath(), 'financial_reports_database.db'),
    );

    final databaseInstance = await database;

    await databaseInstance.delete(
      'financial_reports_database',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}