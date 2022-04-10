/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 6:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/creditors/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CreditorsDatabaseInputs {

  static const String databaseTableName = "all_creditors";

  static String creditorsDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText()) ? "creditors_database.db" : "${UserInformation.UserId}_creditors_database.db";;
  }

  Future<void> insertCreditorData(CreditorsData creditorsData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = CreditorsDatabaseInputs.creditorsDatabase();
    var tableNameQuery = CreditorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
                'creditorsName TEXT, '
                'creditorsDescription TEXT, '
                'creditorsCompleteCredit TEXT, '
                'creditorsPaidCredit TEXT, '
                'creditorsRemainingCredit TEXT, '
                'creditorsDeadline TEXT, '
                'creditorsDeadlineText TEXT, '
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
      creditorsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }

  }

  Future<void> updateCreditorData(CreditorsData creditorsData, String tableName, String usernameId) async {

    var databaseNameQuery = CreditorsDatabaseInputs.creditorsDatabase();
    var tableNameQuery = CreditorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      creditorsData.toMap(),
      where: 'id = ?',
      whereArgs: [creditorsData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}