import 'dart:async';
import 'dart:core';

import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseQueries {

  Future<List<TransactionsData>> getAllTransactions(String? tableName, {String usernameId = ""}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), DatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : DatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}-${tableNameQuery}";

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return TransactionsData(
        id: maps[i]['id'],
        sourceCardNumber: maps[i]['sourceCardNumber'],
        targetCardNumber: maps[i]['targetCardNumber'],
        sourceBankName: maps[i]['sourceBankName'],
        targetBankName: maps[i]['targetBankName'],
        sourceUsername: maps[i]['sourceUsername'],
        targetUsername: maps[i]['targetUsername'],
        amountMoney: maps[i]['amountMoney'],
        transactionTime: maps[i]['transactionTime'],
      );
    });

  }

  Future<Map<String, Object?>> queryFinancialReport(int id, String? tableName, {String usernameId = ""}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), DatabaseInputs.transactionDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : DatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}-${tableNameQuery}";

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return databaseContents[0];
  }

  Future<TransactionsData> extractFinancialReport(Map<String, Object?>inputData) async {

    return TransactionsData(id: inputData["id"] as int,
      sourceCardNumber: inputData['sourceCardNumber'].toString(),
      targetCardNumber: inputData['targetCardNumber'].toString(),
      sourceBankName: inputData['sourceBankName'].toString(),
      targetBankName: inputData['targetBankName'].toString(),
      sourceUsername: inputData['sourceUsername'].toString(),
      targetUsername: inputData['targetUsername'].toString(),
      amountMoney: inputData['amountMoney'].toString(),
      transactionTime: inputData['transactionTime'].toString(),
    );
  }

}