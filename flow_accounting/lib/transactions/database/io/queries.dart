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

import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionsDatabaseQueries {

  Future<List<TransactionsData>> getAllTransactions(String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionsDatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : TransactionsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery, orderBy: "transactionTimeMillisecond DESC",);

    return List.generate(maps.length, (i) {
      return TransactionsData(
        id: maps[i]['id'],
        transactionTitle: maps[i]['transactionTitle'],
        transactionDescription: maps[i]['transactionDescription'],
        sourceCardNumber: maps[i]['sourceCardNumber'],
        targetCardNumber: maps[i]['targetCardNumber'],
        sourceBankName: maps[i]['sourceBankName'],
        targetBankName: maps[i]['targetBankName'],
        sourceUsername: maps[i]['sourceUsername'],
        targetUsername: maps[i]['targetUsername'],
        amountMoney: maps[i]['amountMoney'],
        transactionType: maps[i]['transactionType'],
        transactionTimeMillisecond: int.parse(maps[i]['transactionTimeMillisecond'].toString()),
        transactionTime: maps[i]['transactionTime'],
        transactionTimeYear: maps[i]['transactionTimeYear'],
        transactionTimeMonth: maps[i]['transactionTimeMonth'],
        colorTag: int.parse(maps[i]['colorTag'].toString()),
        budgetName: maps[i]['budgetName'],
      );
    });

  }

  Future<List<Map<String, Object?>>> queryTransactionByMonths(int transactionYear, int transactionMonth, String transactionType,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionsDatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : TransactionsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'transactionTimeYear = ? AND transactionTimeMonth = ? AND transactionType = ?',
      whereArgs: [transactionYear, transactionMonth, transactionType],
    );

    return databaseContents;
  }

  Future<List<Map<String, Object?>>> queryTransactionByCreditCard(
      String sourceCardNumber, String targetCardNumber,
      int transactionYear, int transactionMonth,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionsDatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : TransactionsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'sourceCardNumber = ? OR targetCardNumber = ? AND transactionTimeYear = ? AND transactionTimeMonth = ?',
      whereArgs: [sourceCardNumber, targetCardNumber, transactionYear, transactionMonth],
    );

    return databaseContents;
  }

  Future<Map<String, Object?>> querySpecificTransaction(int id,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionsDatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : TransactionsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return databaseContents[0];
  }

  Future<int> queryDeleteTransaction(int id,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), TransactionsDatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : TransactionsDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var queryResult = await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return queryResult;
  }

  TransactionsData extractTransactionsQuery(Map<String, Object?>inputData) {

    return TransactionsData(id: inputData["id"] as int,
      transactionTitle: inputData['transactionTitle'].toString(),
      transactionDescription: inputData['transactionDescription'].toString(),
      sourceCardNumber: inputData['sourceCardNumber'].toString(),
      targetCardNumber: inputData['targetCardNumber'].toString(),
      sourceBankName: inputData['sourceBankName'].toString(),
      targetBankName: inputData['targetBankName'].toString(),
      sourceUsername: inputData['sourceUsername'].toString(),
      targetUsername: inputData['targetUsername'].toString(),
      amountMoney: inputData['amountMoney'].toString(),
      transactionType: inputData['transactionType'].toString(),
      transactionTimeMillisecond: int.parse(inputData['transactionTimeMillisecond'].toString()),
      transactionTime: inputData['transactionTime'].toString(),
      transactionTimeYear: inputData['transactionTimeYear'].toString(),
      transactionTimeMonth: inputData['transactionTimeMonth'].toString(),
      colorTag: int.parse(inputData['colorTag'].toString()),
      budgetName: inputData['budgetName'].toString(),
    );
  }

}