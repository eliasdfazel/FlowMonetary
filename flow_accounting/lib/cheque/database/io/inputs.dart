/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/14/22, 6:08 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/cheque/database/structures/table_structure.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChequesDatabaseInputs {

  static const String databaseTableName = "all_cheques";
  static const String specificDatabaseTableName = "cheques";

  static const chequesDatabase = "cheques_database.db";

  Future<void> insertChequeData(ChequesData chequesData, String tableName,
      String usernameId) async {

    var tableNameQuery = (usernameId == StringsResources.unknownText) ? ChequesDatabaseInputs.databaseTableName : "${usernameId}_${ChequesDatabaseInputs.specificDatabaseTableName}";

    final database = openDatabase(
      join(await getDatabasesPath(), ChequesDatabaseInputs.chequesDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'chequeTitle TEXT, '
              'chequeDescription TEXT, '

              'chequeNumber TEXT, '

              'chequeMoneyAmount TEXT, '

              'chequeTransactionType TEXT, '

              'chequeSourceBankName TEXT, '
              'chequeSourceBankBranch TEXT, '

              'chequeTargetBankName TEXT, '

              'chequeIssueDate TEXT, '
              'chequeDueDate TEXT, '

              'chequeIssueMillisecond TEXT, '
              'chequeDueMillisecond TEXT, '

              'chequeSourceId TEXT, '
              'chequeSourceName TEXT, '
              'chequeSourceAccountNumber TEXT, '

              'chequeTargetId TEXT, '
              'chequeTargetName TEXT, '
              'chequeTargetAccountNumber TEXT, '

              'chequeDoneConfirmation TEXT, '

              'chequeRelevantCreditCard TEXT, '
              'chequeRelevantBudget TEXT, '

              'colorTag TEXT'
              ')',
        );
      },

      version: 1,
      readOnly: false
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      chequesData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

  Future<void> updateChequeData(ChequesData chequesData, String tableName, String usernameId) async {

    final database = openDatabase(
      join(await getDatabasesPath(), ChequesDatabaseInputs.chequesDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (usernameId == StringsResources.unknownText) ? ChequesDatabaseInputs.databaseTableName : "${usernameId}_${ChequesDatabaseInputs.specificDatabaseTableName}";

    await databaseInstance.update(
      tableNameQuery,
      chequesData.toMap(),
      where: 'id = ?',
      whereArgs: [chequesData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}