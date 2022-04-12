/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/12/22, 5:37 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/loans/database/structure/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoansDatabaseInputs {

  static const String databaseTableName = "all_cheques";

  static String loansDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText()) ? "loans_database.db" : "${UserInformation.UserId}_loans_database.db";
  }

  Future<void> insertLoanData(LoansData loansData, String tableName,
      String usernameId) async {

    var databaseNameQuery = LoansDatabaseInputs.loansDatabase();
    var tableNameQuery = LoansDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
                'loanTitle TEXT, '
                'loanDescription TEXT, '
                'loanPayer TEXT, '
                'loanDuePeriodType TEXT, '
                'loanDuePeriod TEXT, '
                'loanDuePeriodMillisecond TEXT, '
                'loanCount TEXT, '
                'loanComplete TEXT, '
                'loanPaid TEXT, '
                'loanRemaining TEXT, '
                'colorTag TEXT'
                ')',
          );
        },

        version: 1,
        readOnly: false
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      loansData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

  Future<void> updateChequeData(LoansData loansData, String tableName, String usernameId) async {

    var databaseNameQuery = LoansDatabaseInputs.loansDatabase();
    var tableNameQuery = LoansDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      loansData.toMap(),
      where: 'id = ?',
      whereArgs: [loansData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}