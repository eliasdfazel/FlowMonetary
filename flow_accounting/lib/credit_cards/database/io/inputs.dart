/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 6:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardsDatabaseInputs {

  static const String databaseTableName = "all_credit_cards";

  static String creditCardDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText) ? "credit_cards_database.db" : "${UserInformation.UserId}_credit_cards_database.db";
  }

  Future<void> insertCreditCardsData(CreditCardsData creditCardsData,
      String tableName, String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
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

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }

  }

  Future<void> updateCreditCardsData(CreditCardsData creditCardsData,
      String tableName, String usernameId) async {

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

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

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}