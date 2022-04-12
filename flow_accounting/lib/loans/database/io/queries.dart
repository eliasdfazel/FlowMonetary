/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/12/22, 5:34 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/loans/database/io/inputs.dart';
import 'package:flow_accounting/loans/database/structure/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoansDatabaseQueries {

  Future<List<LoansData>> getAllLoans(String tableName,
      String usernameId) async {

    var databaseNameQuery = LoansDatabaseInputs.loansDatabase();
    var tableNameQuery = LoansDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return LoansData(
        id: maps[i]['id'],

        loanDescription: maps[i]['loanDescription'],

        loanDuePeriod: maps[i]['loanIssueMonthly'],
        loanDuePeriodMillisecond: maps[i]['loanIssueMonthlyMillisecond'],

        loanComplete: maps[i]['loanComplete'],
        loanPaid: maps[i]['loanPaid'],
        loanRemaining: maps[i]['loanRemaining'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<int> queryDeleteCheque(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = LoansDatabaseInputs.loansDatabase();
    var tableNameQuery = LoansDatabaseInputs.databaseTableName;

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