/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 2:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/debtors/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DebtorsDatabaseInputs {

  static const String databaseTableName = "all_debtors";

  static String debtorsDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText()) ? "debtors_database.db" : "${UserInformation.UserId}_debtors_database.db";;
  }

  Future<void> insertDebtorData(DebtorsData debtorsData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = DebtorsDatabaseInputs.debtorsDatabase();
    var tableNameQuery = DebtorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
                'debtorsName TEXT, '
                'debtorsDescription TEXT, '
                'debtorsCompleteDebt TEXT, '
                'debtorsPaidDebt TEXT, '
                'debtorsRemainingDebt TEXT, '
                'debtorsDeadline TEXT, '
                'debtorsDeadlineText TEXT, '
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
      debtorsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }

  }

  Future<void> updateDebtorData(DebtorsData debtorsData, String tableName, String usernameId) async {

    var databaseNameQuery = DebtorsDatabaseInputs.debtorsDatabase();
    var tableNameQuery = DebtorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      debtorsData.toMap(),
      where: 'id = ?',
      whereArgs: [debtorsData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}