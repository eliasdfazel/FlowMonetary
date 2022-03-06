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

import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardsDatabaseInputs {

  static const String databaseTableName = "all_credit_cards";

  static const creditCardDatabase = "credit_cards_database.db";

  Future<void> insertCreditCardsData(CreditCardsData creditCardsData,
      String? tableName, {String usernameId = "Unknown"}) async {

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'cardNumber TEXT, '
              'targetCardNumber TEXT, '
              'cardExpiry TEXT, '
              'cardHolderName TEXT, '
              'cvv TEXT, '
              'bankName TEXT, '
              'cardBalance TEXT, '
              'colorTag TEXT '
              ')',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      creditCardsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

  Future<void> updateCreditCardsData(CreditCardsData creditCardsData,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    await databaseInstance.update(
      tableNameQuery,
      creditCardsData.toMap(),
      where: 'id = ?',
      whereArgs: [creditCardsData.id],
    );

    if (databaseInstance.isOpen) {

      databaseInstance.close();

    }

  }

  Future<void> deleteCreditCardsData(int id, String? tableName,
      {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}