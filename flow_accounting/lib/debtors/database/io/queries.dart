/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 4:12 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/debtors/database/io/inputs.dart';
import 'package:flow_accounting/debtors/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DebtorsDatabaseQueries {

  Future<List<DebtorsData>> getAllDebtors(String tableName,
      String usernameId) async {

    var databaseNameQuery = DebtorsDatabaseInputs.debtorsDatabase();
    var tableNameQuery = DebtorsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return DebtorsData(
        id: maps[i]['id'],

        debtorsName: maps[i]['debtorsName'],
        debtorsDescription: maps[i]['debtorsDescription'],

        debtorsCompleteDebt: maps[i]['debtorsCompleteDebt'],

        debtorsPaidDebt: maps[i]['debtorsPaidDebt'],
        debtorsRemainingDebt: maps[i]['debtorsRemainingDebt'],

        debtorsDeadline: maps[i]['debtorsDeadline'],
        debtorsDeadlineText: maps[i]['debtorsDeadlineText'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

}