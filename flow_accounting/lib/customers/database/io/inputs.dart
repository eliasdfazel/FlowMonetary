/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/13/22, 10:08 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomersDatabaseInputs {

  static const String databaseTableName = "all_customers";

  static const customersDatabase = "customers_database.db";

  Future<void> insertCustomerData(CustomersData customersData, String? tableName,
      String usernameId) async {

    var tableNameQuery = (tableName != null) ? tableName : CustomersDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    final database = openDatabase(
      join(await getDatabasesPath(), CustomersDatabaseInputs.customersDatabase),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'customerName TEXT, '
              'customerDescription TEXT, '
              'customerCountry TEXT,'
              'customerCity TEXT,'
              'customerStreetAddress TEXT,'
              'customerPhoneNumber TEXT,'
              'customerEmailAddress TEXT,'
              'customerAge TEXT,'
              'customerBirthday TEXT,'
              'customerJob TEXT,'
              'customerMaritalStatus TEXT,'
              'customerImagePath TEXT,'
              'colorTag TEXT'
              ')',
        );
      },

      version: 1,
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      customersData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

  Future<void> updateCustomerData(CustomersData customersData, String? tableName, String usernameId) async {

    final database = openDatabase(
      join(await getDatabasesPath(), CustomersDatabaseInputs.customersDatabase),
    );

    final databaseInstance = await database;

    var tableNameQuery = (tableName != null) ? tableName : CustomersDatabaseInputs.databaseTableName;
    tableNameQuery = "${usernameId}_${tableNameQuery}";

    await databaseInstance.update(
      tableNameQuery,
      customersData.toMap(),
      where: 'id = ?',
      whereArgs: [customersData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}