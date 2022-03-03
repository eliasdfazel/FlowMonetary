/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/2/22, 5:54 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/customers/database/io/inputs.dart';
import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomersDatabaseQueries {

  Future<List<CustomersData>> getAllCustomers(String? tableName,
      {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CustomersDatabaseInputs.customersDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CustomersDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return CustomersData(
        id: maps[i]['id'],

        customerName: maps[i]['customerName'],
        customerDescription: maps[i]['customerDescription'],

        customerCountry: maps[i]['customerCountry'],
        customerCity: maps[i]['customerCity'],
        customerStreetAddress: maps[i]['customerStreetAddress'],

        customerPhoneNumber: maps[i]['customerPhoneNumber'],
        customerEmailAddress: maps[i]['customerEmailAddress'],

        customerAge: maps[i]['customerAge'],
        customerBirthday: maps[i]['customerBirthday'],

        customerJob: maps[i]['customerJob'],

        customerMaritalStatus: maps[i]['customerMaritalStatus'],

        customerImagePath: maps[i]['customerImagePath'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<int> queryDeleteCustomer(int id,
      String? tableName, {String usernameId = "Unknown"}) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CustomersDatabaseInputs.customersDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CustomersDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    var queryResult = await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return queryResult;
  }

}