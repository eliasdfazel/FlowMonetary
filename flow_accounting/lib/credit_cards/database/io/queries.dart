/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 6:11 AM
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

  Future<List<CreditCardsData>> getAllCreditCards(String tableName,
      String usernameId) async {

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

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
        cardAccountNumber: maps[i]['cardAccountNumber'],
        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<Map<String, Object?>> querySpecificCreditCard(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return databaseContents[0];
  }

  Future<Map<String, Object?>> querySpecificCreditCardByCardNumber(
      String cardNumber,
      String tableName, String usernameId) async {

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;


    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'cardNumber = ?',
      whereArgs: [cardNumber],
    );

    return databaseContents[0];
  }

  Future<int> queryDeleteCreditCard(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = CreditCardsDatabaseInputs.creditCardDatabase();
    var tableNameQuery = CreditCardsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

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
      cardNumber: inputData['cardNumber'].toString(),
      cardExpiry: inputData['cardExpiry'].toString(),
      cardHolderName: inputData['cardHolderName'].toString(),
      cvv: inputData['cvv'].toString(),
      bankName: inputData['bankName'].toString(),
      cardBalance: inputData['cardBalance'].toString(),
      cardAccountNumber: inputData['cardAccountNumber'].toString(),
      colorTag: int.parse(inputData['colorTag'].toString()),
    );
  }

}