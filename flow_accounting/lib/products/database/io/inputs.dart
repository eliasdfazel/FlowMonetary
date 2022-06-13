/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/27/22, 5:46 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDatabaseInputs {

  static const String databaseTableName = "all_products";

  static String productsDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText()) ? "products_database.db" : "${UserInformation.UserId}_products_database.db";
  }

  Future<void> insertProductData(ProductsData productsData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = ProductsDatabaseInputs.productsDatabase();
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
                'productTax TEXT, '
                'productQuantity TEXT, '
                'productQuantityType TEXT, '
                'extraBarcodeData TEXT, '
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

    var databaseNameQuery = ProductsDatabaseInputs.productsDatabase();
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