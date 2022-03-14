/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/14/22, 6:25 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardsDatabaseInputs {

  static const String databaseTableName = "all_credit_cards";
  static const String specificDatabaseTableName = "credit_cards";

  static const creditCardDatabase = "credit_cards_database.db";

  Future<void> insertCreditCardsData(CreditCardsData creditCardsData,
      String tableName, String usernameId) async {

    var tableNameQuery = (usernameId == StringsResources.unknownText) ? CreditCardsDatabaseInputs.databaseTableName : "${usernameId}_${CreditCardsDatabaseInputs.specificDatabaseTableName}";

    final database = openDatabase(
      join(await getDatabasesPath(), "6666" + CreditCardsDatabaseInputs.creditCardDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'cardNumber TEXT, '
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
      readOnly: false
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      creditCardsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

  Future<void> updateCreditCardsData(CreditCardsData creditCardsData,
      String tableName, String usernameId) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (usernameId == StringsResources.unknownText) ? CreditCardsDatabaseInputs.databaseTableName : "${usernameId}_${CreditCardsDatabaseInputs.specificDatabaseTableName}";

    await databaseInstance.update(
      tableNameQuery,
      creditCardsData.toMap(),
      where: 'id = ?',
      whereArgs: [creditCardsData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

  Future<void> deleteCreditCardsData(int id, String tableName,
      String usernameId) async {

    final database = openDatabase(
      join(await getDatabasesPath(), creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (usernameId == StringsResources.unknownText) ? CreditCardsDatabaseInputs.databaseTableName : "${usernameId}_${CreditCardsDatabaseInputs.specificDatabaseTableName}";

    await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (databaseInstance.isOpen) {

      // await databaseInstance.close();

    }

  }

}