/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/15/22, 9:24 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDatabaseInputs {

  static const String databaseTableName = "all_products";

  static const productsDatabase = "products_database.db";

  Future<void> insertProductData(ProductsData budgetsData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? ProductsDatabaseInputs.productsDatabase : "${usernameId}_${ProductsDatabaseInputs.productsDatabase}";
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '



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
      budgetsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }
  }

  Future<void> updateBudgetData(ProductsData budgetsData, String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? ProductsDatabaseInputs.productsDatabase : "${usernameId}_${ProductsDatabaseInputs.productsDatabase}";
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      budgetsData.toMap(),
      where: 'id = ?',
      whereArgs: [budgetsData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}