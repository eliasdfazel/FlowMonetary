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

import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardsDatabaseQueries {

  Future<List<CreditCardsData>> getAllCreditCards(String? tableName,
      {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return CreditCardsData(
        id: maps[i]['id'],
        cardNumber: maps[i]['cardNumber'],
        cardExpiry: maps[i]['cardExpiry'],
        cardHolderName: maps[i]['cardHolderName'],
        cvv: maps[i]['cvv'],
        bankName: maps[i]['bankName'],
        cardBalance: maps[i]['cardBalance'],
        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<Map<String, Object?>> querySpecificCreditCard(int id,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return databaseContents[0];
  }

  Future<Map<String, Object?>> querySpecificCreditCardByCardNumber(
      String cardNumber,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'cardNumber = ?',
      whereArgs: [cardNumber],
    );

    return databaseContents[0];
  }

  Future<int> queryDeleteCreditCard(int id,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CreditCardsDatabaseInputs.creditCardDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CreditCardsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var queryResult = await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return queryResult;
  }

  Future<CreditCardsData> extractTransactionsQuery(
      Map<String, Object?> inputData) async {

    return CreditCardsData(
      id: inputData["id"] as int,
      cardNumber: inputData['sourceCardNumber'].toString(),
      cardExpiry: inputData['sourceBankName'].toString(),
      cardHolderName: inputData['targetBankName'].toString(),
      cvv: inputData['sourceUsername'].toString(),
      bankName: inputData['targetUsername'].toString(),
      cardBalance: inputData['amountMoney'].toString(),
      colorTag: int.parse(inputData['colorTag'].toString()),
    );
  }

}