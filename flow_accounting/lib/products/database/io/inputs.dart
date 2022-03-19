/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/19/22, 5:57 AM
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

  Future<void> insertProductData(ProductsData productsData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? ProductsDatabaseInputs.productsDatabase : "${usernameId}_${ProductsDatabaseInputs.productsDatabase}";
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
                'productImageUrl TEXT, '
                'productName TEXT, '
                'productDescription TEXT, '
                'productCategory TEXT, '
                'productBrand TEXT, '
                'productBrandLogoUrl TEXT, '
                'productPrice TEXT, '
                'productProfitPercent TEXT, '
                'productQuantity TEXT, '
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
      productsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }
  }

  Future<void> updateProductData(ProductsData productsData, String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? ProductsDatabaseInputs.productsDatabase : "${usernameId}_${ProductsDatabaseInputs.productsDatabase}";
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      productsData.toMap(),
      where: 'id = ?',
      whereArgs: [productsData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}