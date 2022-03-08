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

import 'package:flow_accounting/cheque/database/io/inputs.dart';
import 'package:flow_accounting/cheque/database/structures/table_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ChequesDatabaseQueries {

  Future<List<ChequesData>> getAllCheques(String? tableName,
      {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), ChequesDatabaseInputs.chequesDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : ChequesDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return ChequesData(
        id: maps[i]['id'],

        chequeTitle: maps[i]['chequeTitle'],
        chequeDescription: maps[i]['chequeDescription'],

        chequeMoneyAmount: maps[i]['chequeMoneyAmount'],

        chequeNumber: maps[i]['chequeNumber'],

        chequeTransactionType: maps[i]['chequeTransactionType'],

        chequeBankName: maps[i]['chequeBankName'],
        chequeBankBranch: maps[i]['chequeBankBranch'],

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

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<int> queryDeleteCheque(int id,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), ChequesDatabaseInputs.chequesDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : ChequesDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

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

      chequeBankName: inputData['chequeBankName'].toString(),
      chequeBankBranch: inputData['chequeBankBranch'].toString(),

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

      colorTag: int.parse(inputData['colorTag'].toString()),
    );
  }

}