/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 6:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/cheque/database/io/inputs.dart';
import 'package:flow_accounting/cheque/database/structures/table_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChequesDatabaseQueries {

  Future<List<ChequesData>> getAllCheques(String tableName,
      String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return ChequesData(
        id: maps[i]['id'],

        chequeTitle: maps[i]['chequeTitle'],
        chequeDescription: maps[i]['chequeDescription'],

        chequeMoneyAmount: maps[i]['chequeMoneyAmount'],

        chequeNumber: maps[i]['chequeNumber'],

        chequeTransactionType: maps[i]['chequeTransactionType'],

        chequeSourceBankName: maps[i]['chequeSourceBankName'],
        chequeSourceBankBranch: maps[i]['chequeSourceBankBranch'],

        chequeTargetBankName: maps[i]['chequeTargetBankName'],

        chequeIssueDate: maps[i]['chequeIssueDate'],
        chequeDueDate: maps[i]['chequeDueDate'],

        chequeIssueMillisecond: maps[i]['chequeIssueMillisecond'],
        chequeDueMillisecond: maps[i]['chequeDueMillisecond'],

        chequeSourceId: maps[i]['chequeSourceId'],
        chequeSourceName: maps[i]['chequeSourceName'],
        chequeSourceAccountNumber: maps[i]['chequeSourceAccountNumber'],

        chequeTargetId: maps[i]['chequeTargetId'],
        chequeTargetName: maps[i]['chequeTargetName'],
        chequeTargetAccountNumber: maps[i]['chequeTargetAccountNumber'],

        chequeDoneConfirmation: maps[i]['chequeTargetAccountNumber'],

        chequeRelevantCreditCard: maps[i]['chequeRelevantCreditCard'],
        chequeRelevantBudget: maps[i]['chequeRelevantBudget'],

        chequeCategory: maps[i]['chequeCategory'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<ChequesData?> querySpecificChequesByNumber(
      String chequeNumber,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'chequeNumber = ?',
      whereArgs: [chequeNumber],
    );

    ChequesData? chequesData = null;

    if (databaseContents.isNotEmpty) {

      chequesData = await extractChequesQuery(databaseContents[0]);

    }

    return chequesData;
  }

  Future<List<ChequesData>> queryChequeByTargetTimeMoney(
      String amountMoneyFirst, String amountMoneyLast,
      String timeFirst, String timeLast,
      String targetName,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: '(chequeMoneyAmount BETWEEN ? AND ?) AND (chequeDueMillisecond BETWEEN ? AND ?) AND (chequeTargetName = ?)',
      whereArgs: [amountMoneyFirst, amountMoneyLast, timeFirst, timeLast, targetName],
    );

    return List.generate(databaseContents.length, (i) {
      return ChequesData(
        id: databaseContents[i]['id'],

        chequeTitle: databaseContents[i]['chequeTitle'],
        chequeDescription: databaseContents[i]['chequeDescription'],

        chequeMoneyAmount: databaseContents[i]['chequeMoneyAmount'],

        chequeNumber: databaseContents[i]['chequeNumber'],

        chequeTransactionType: databaseContents[i]['chequeTransactionType'],

        chequeSourceBankName: databaseContents[i]['chequeSourceBankName'],
        chequeSourceBankBranch: databaseContents[i]['chequeSourceBankBranch'],

        chequeTargetBankName: databaseContents[i]['chequeTargetBankName'],

        chequeIssueDate: databaseContents[i]['chequeIssueDate'],
        chequeDueDate: databaseContents[i]['chequeDueDate'],

        chequeIssueMillisecond: databaseContents[i]['chequeIssueMillisecond'],
        chequeDueMillisecond: databaseContents[i]['chequeDueMillisecond'],

        chequeSourceId: databaseContents[i]['chequeSourceId'],
        chequeSourceName: databaseContents[i]['chequeSourceName'],
        chequeSourceAccountNumber: databaseContents[i]['chequeSourceAccountNumber'],

        chequeTargetId: databaseContents[i]['chequeTargetId'],
        chequeTargetName: databaseContents[i]['chequeTargetName'],
        chequeTargetAccountNumber: databaseContents[i]['chequeTargetAccountNumber'],

        chequeDoneConfirmation: databaseContents[i]['chequeTargetAccountNumber'],

        chequeRelevantCreditCard: databaseContents[i]['chequeRelevantCreditCard'],
        chequeRelevantBudget: databaseContents[i]['chequeRelevantBudget'],

        chequeCategory: databaseContents[i]['chequeCategory'],

        colorTag: int.parse(databaseContents[i]['colorTag'].toString()),
      );
    });
  }

  Future<List<ChequesData>> queryChequeByTarget(
      String targetName,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'chequeTargetName = ?',
      whereArgs: [targetName],
    );

    return List.generate(databaseContents.length, (i) {
      return ChequesData(
        id: databaseContents[i]['id'],

        chequeTitle: databaseContents[i]['chequeTitle'],
        chequeDescription: databaseContents[i]['chequeDescription'],

        chequeMoneyAmount: databaseContents[i]['chequeMoneyAmount'],

        chequeNumber: databaseContents[i]['chequeNumber'],

        chequeTransactionType: databaseContents[i]['chequeTransactionType'],

        chequeSourceBankName: databaseContents[i]['chequeSourceBankName'],
        chequeSourceBankBranch: databaseContents[i]['chequeSourceBankBranch'],

        chequeTargetBankName: databaseContents[i]['chequeTargetBankName'],

        chequeIssueDate: databaseContents[i]['chequeIssueDate'],
        chequeDueDate: databaseContents[i]['chequeDueDate'],

        chequeIssueMillisecond: databaseContents[i]['chequeIssueMillisecond'],
        chequeDueMillisecond: databaseContents[i]['chequeDueMillisecond'],

        chequeSourceId: databaseContents[i]['chequeSourceId'],
        chequeSourceName: databaseContents[i]['chequeSourceName'],
        chequeSourceAccountNumber: databaseContents[i]['chequeSourceAccountNumber'],

        chequeTargetId: databaseContents[i]['chequeTargetId'],
        chequeTargetName: databaseContents[i]['chequeTargetName'],
        chequeTargetAccountNumber: databaseContents[i]['chequeTargetAccountNumber'],

        chequeDoneConfirmation: databaseContents[i]['chequeTargetAccountNumber'],

        chequeRelevantCreditCard: databaseContents[i]['chequeRelevantCreditCard'],
        chequeRelevantBudget: databaseContents[i]['chequeRelevantBudget'],

        chequeCategory: databaseContents[i]['chequeCategory'],

        colorTag: int.parse(databaseContents[i]['colorTag'].toString()),
      );
    });
  }

  Future<List<ChequesData>> queryChequeByCategory(
      String chequeCategory,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'chequeCategory = ?',
      whereArgs: [chequeCategory],
    );

    return List.generate(databaseContents.length, (i) {
      return ChequesData(
        id: databaseContents[i]['id'],

        chequeTitle: databaseContents[i]['chequeTitle'],
        chequeDescription: databaseContents[i]['chequeDescription'],

        chequeMoneyAmount: databaseContents[i]['chequeMoneyAmount'],

        chequeNumber: databaseContents[i]['chequeNumber'],

        chequeTransactionType: databaseContents[i]['chequeTransactionType'],

        chequeSourceBankName: databaseContents[i]['chequeSourceBankName'],
        chequeSourceBankBranch: databaseContents[i]['chequeSourceBankBranch'],

        chequeTargetBankName: databaseContents[i]['chequeTargetBankName'],

        chequeIssueDate: databaseContents[i]['chequeIssueDate'],
        chequeDueDate: databaseContents[i]['chequeDueDate'],

        chequeIssueMillisecond: databaseContents[i]['chequeIssueMillisecond'],
        chequeDueMillisecond: databaseContents[i]['chequeDueMillisecond'],

        chequeSourceId: databaseContents[i]['chequeSourceId'],
        chequeSourceName: databaseContents[i]['chequeSourceName'],
        chequeSourceAccountNumber: databaseContents[i]['chequeSourceAccountNumber'],

        chequeTargetId: databaseContents[i]['chequeTargetId'],
        chequeTargetName: databaseContents[i]['chequeTargetName'],
        chequeTargetAccountNumber: databaseContents[i]['chequeTargetAccountNumber'],

        chequeDoneConfirmation: databaseContents[i]['chequeTargetAccountNumber'],

        chequeRelevantCreditCard: databaseContents[i]['chequeRelevantCreditCard'],
        chequeRelevantBudget: databaseContents[i]['chequeRelevantBudget'],

        chequeCategory: databaseContents[i]['chequeCategory'],

        colorTag: int.parse(databaseContents[i]['colorTag'].toString()),
      );
    });
  }

  Future<List<ChequesData>> queryChequeByMoney(
      String amountMoneyFirst, String amountMoneyLast,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'chequeMoneyAmount BETWEEN ? AND ?',
      whereArgs: [amountMoneyFirst, amountMoneyLast],
    );

    return List.generate(databaseContents.length, (i) {
      return ChequesData(
        id: databaseContents[i]['id'],

        chequeTitle: databaseContents[i]['chequeTitle'],
        chequeDescription: databaseContents[i]['chequeDescription'],

        chequeMoneyAmount: databaseContents[i]['chequeMoneyAmount'],

        chequeNumber: databaseContents[i]['chequeNumber'],

        chequeTransactionType: databaseContents[i]['chequeTransactionType'],

        chequeSourceBankName: databaseContents[i]['chequeSourceBankName'],
        chequeSourceBankBranch: databaseContents[i]['chequeSourceBankBranch'],

        chequeTargetBankName: databaseContents[i]['chequeTargetBankName'],

        chequeIssueDate: databaseContents[i]['chequeIssueDate'],
        chequeDueDate: databaseContents[i]['chequeDueDate'],

        chequeIssueMillisecond: databaseContents[i]['chequeIssueMillisecond'],
        chequeDueMillisecond: databaseContents[i]['chequeDueMillisecond'],

        chequeSourceId: databaseContents[i]['chequeSourceId'],
        chequeSourceName: databaseContents[i]['chequeSourceName'],
        chequeSourceAccountNumber: databaseContents[i]['chequeSourceAccountNumber'],

        chequeTargetId: databaseContents[i]['chequeTargetId'],
        chequeTargetName: databaseContents[i]['chequeTargetName'],
        chequeTargetAccountNumber: databaseContents[i]['chequeTargetAccountNumber'],

        chequeDoneConfirmation: databaseContents[i]['chequeTargetAccountNumber'],

        chequeRelevantCreditCard: databaseContents[i]['chequeRelevantCreditCard'],
        chequeRelevantBudget: databaseContents[i]['chequeRelevantBudget'],

        chequeCategory: databaseContents[i]['chequeCategory'],

        colorTag: int.parse(databaseContents[i]['colorTag'].toString()),
      );
    });
  }

  Future<List<ChequesData>> queryChequeByTime(
      String timeFirst, String timeLast,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'chequeDueMillisecond BETWEEN ? AND ?',
      whereArgs: [timeFirst, timeLast],
    );

    return List.generate(databaseContents.length, (i) {
      return ChequesData(
        id: databaseContents[i]['id'],

        chequeTitle: databaseContents[i]['chequeTitle'],
        chequeDescription: databaseContents[i]['chequeDescription'],

        chequeMoneyAmount: databaseContents[i]['chequeMoneyAmount'],

        chequeNumber: databaseContents[i]['chequeNumber'],

        chequeTransactionType: databaseContents[i]['chequeTransactionType'],

        chequeSourceBankName: databaseContents[i]['chequeSourceBankName'],
        chequeSourceBankBranch: databaseContents[i]['chequeSourceBankBranch'],

        chequeTargetBankName: databaseContents[i]['chequeTargetBankName'],

        chequeIssueDate: databaseContents[i]['chequeIssueDate'],
        chequeDueDate: databaseContents[i]['chequeDueDate'],

        chequeIssueMillisecond: databaseContents[i]['chequeIssueMillisecond'],
        chequeDueMillisecond: databaseContents[i]['chequeDueMillisecond'],

        chequeSourceId: databaseContents[i]['chequeSourceId'],
        chequeSourceName: databaseContents[i]['chequeSourceName'],
        chequeSourceAccountNumber: databaseContents[i]['chequeSourceAccountNumber'],

        chequeTargetId: databaseContents[i]['chequeTargetId'],
        chequeTargetName: databaseContents[i]['chequeTargetName'],
        chequeTargetAccountNumber: databaseContents[i]['chequeTargetAccountNumber'],

        chequeDoneConfirmation: databaseContents[i]['chequeTargetAccountNumber'],

        chequeRelevantCreditCard: databaseContents[i]['chequeRelevantCreditCard'],
        chequeRelevantBudget: databaseContents[i]['chequeRelevantBudget'],

        chequeCategory: databaseContents[i]['chequeCategory'],

        colorTag: int.parse(databaseContents[i]['colorTag'].toString()),
      );
    });
  }

  Future<int> queryDeleteCheque(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = ChequesDatabaseInputs.chequesDatabase();
    var tableNameQuery = ChequesDatabaseInputs.databaseTableName;

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

  Future<ChequesData> extractChequesQuery(
      Map<String, Object?> inputData) async {

    return ChequesData(
      id: inputData['id'] as int,

      chequeTitle: inputData['chequeTitle'].toString(),
      chequeDescription: inputData['chequeDescription'].toString(),

      chequeMoneyAmount: inputData['chequeMoneyAmount'].toString(),

      chequeNumber: inputData['chequeNumber'].toString(),

      chequeTransactionType: inputData['chequeTransactionType'].toString(),

      chequeSourceBankName: inputData['chequeSourceBankName'].toString(),
      chequeSourceBankBranch: inputData['chequeSourceBankBranch'].toString(),

      chequeTargetBankName: inputData['chequeTargetBankName'].toString(),

      chequeIssueDate: inputData['chequeIssueDate'].toString(),
      chequeDueDate: inputData['chequeDueDate'].toString(),

      chequeIssueMillisecond: inputData['chequeIssueMillisecond'].toString(),
      chequeDueMillisecond: inputData['chequeDueMillisecond'].toString(),

      chequeSourceId: inputData['chequeSourceId'].toString(),
      chequeSourceName: inputData['chequeSourceName'].toString(),
      chequeSourceAccountNumber: inputData['chequeSourceAccountNumber'].toString(),

      chequeTargetId: inputData['chequeTargetId'].toString(),
      chequeTargetName: inputData['chequeTargetName'].toString(),
      chequeTargetAccountNumber: inputData['chequeTargetAccountNumber'].toString(),

      chequeDoneConfirmation: inputData['chequeTargetAccountNumber'].toString(),

      chequeRelevantCreditCard: inputData['chequeRelevantCreditCard'].toString(),
      chequeRelevantBudget: inputData['chequeRelevantBudget'].toString(),

      chequeCategory: inputData['chequeCategory'].toString(),

      colorTag: int.parse(inputData['colorTag'].toString()),
    );
  }

}