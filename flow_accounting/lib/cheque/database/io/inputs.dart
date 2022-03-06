/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/6/22, 2:43 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/cheque/database/structures/table_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChequesDatabaseInputs {

  static const String databaseTableName = "all_cheques";

  static const chequesDatabase = "cheques_database.db";

  Future<void> insertChequeData(ChequesData chequesData, String? tableName,
      {String usernameId = "Unknown"}) async {

    var tableNameQuery = (tableName != null) ? tableName : ChequesDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final database = openDatabase(
      join(await getDatabasesPath(), ChequesDatabaseInputs.chequesDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'budgetName TEXT, '

              'colorTag TEXT'
              ')',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      chequesData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateChequeData(ChequesData chequesData, String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), ChequesDatabaseInputs.chequesDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : ChequesDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    await databaseInstance.update(
      tableNameQuery,
      chequesData.toMap(),
      where: 'id = ?',
      whereArgs: [chequesData.id],
    );

    if (databaseInstance.isOpen) {

      databaseInstance.close();

    }

  }

}