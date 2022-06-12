/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 11:04 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomersDatabaseInputs {

  static const String databaseTableName = "all_customers";

  static String customersDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText()) ? "customers_database.db" : "${UserInformation.UserId}_customers_database.db";;
  }

  Future<void> insertCustomerData(CustomersData customersData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = CustomersDatabaseInputs.customersDatabase();
    var tableNameQuery = CustomersDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
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
              'customerPurchases TEXT,'
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
      customersData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }

  }

  Future<void> updateCustomerData(CustomersData customersData, String tableName, String usernameId) async {

    var databaseNameQuery = CustomersDatabaseInputs.customersDatabase();
    var tableNameQuery = CustomersDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

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