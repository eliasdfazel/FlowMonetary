/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 6:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/creditors/database/io/inputs.dart';
import 'package:flow_accounting/creditors/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditorsDatabaseQueries {

  Future<List<CreditorsData>> getAllCreditors(String tableName,
      String usernameId) async {

    var databaseNameQuery = CreditorsDatabaseInputs.creditorsDatabase();
    var tableNameQuery = CreditorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return CreditorsData(
        id: maps[i]['id'],

        creditorsName: maps[i]['creditorName'],
        creditorsDescription: maps[i]['creditorDescription'],

        creditorsCompleteCredit: maps[i]['creditorCompleteDebt'],

        creditorsPaidCredit: maps[i]['creditorPaidDebt'],
        creditorsRemainingCredit: maps[i]['creditorRemainingDebt'],

        creditorsDeadline: maps[i]['creditorDeadline'],
        creditorsDeadlineText: maps[i]['creditorDeadlineText'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<CreditorsData> querySpecificCreditorById(int creditorId,
    String tableName, String usernameId) async {

    var databaseNameQuery = CreditorsDatabaseInputs.creditorsDatabase();
    var tableNameQuery = CreditorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [creditorId],
    );

    return CreditorsData(
      id: databaseContents[0]['id'],

      creditorsName: databaseContents[0]['creditorName'],
      creditorsDescription: databaseContents[0]['creditorDescription'],

      creditorsCompleteCredit: databaseContents[0]['creditorCompleteDebt'],

      creditorsPaidCredit: databaseContents[0]['creditorPaidDebt'],
      creditorsRemainingCredit: databaseContents[0]['creditorRemainingDebt'],

      creditorsDeadline: databaseContents[0]['creditorDeadline'],
      creditorsDeadlineText: databaseContents[0]['creditorDeadlineText'],

      colorTag: int.parse(databaseContents[0]['colorTag'].toString()),
    );

  }

  Future<int> queryDeleteCreditor(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = CreditorsDatabaseInputs.creditorsDatabase();
    var tableNameQuery = CreditorsDatabaseInputs.databaseTableName;

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

}