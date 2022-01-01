import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/transactions/database/structures/financial_reports.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInputs {

  String databaseTableName = "all_transactions";

  DatabaseInputs(this.databaseTableName);

  static const TransactionDatabase = "transactions_database.db";

  Future<void> insertFinancialReport(FinancialReports financialReports) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionDatabase),
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
      financialReports.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateDog(FinancialReports financialReports) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionDatabase),
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
      join(await getDatabasesPath(), TransactionDatabase),
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