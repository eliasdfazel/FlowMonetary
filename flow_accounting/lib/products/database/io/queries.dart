/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/16/22, 8:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDatabaseQueries {

  Future<List<ProductsData>> getAllProducts(String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? ProductsDatabaseInputs.productsDatabase : "${usernameId}_${ProductsDatabaseInputs.productsDatabase}";
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return ProductsData(
        id: maps[i]['id'],

        productImageUrl: maps[i]['productImageUrl'],

        productName: maps[i]['productName'],
        productDescription: maps[i]['productDescription'],

        productCategory: maps[i]['productCategory'],

        productBrand: maps[i]['productBrand'],
        productBrandLogoUrl: maps[i]['productBrandLogoUrl'],

        productPrice: maps[i]['productPrice'],
        productProfitPercent: maps[i]['productProfitPercent'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<int> queryDeleteProduct(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = (usernameId == StringsResources.unknownText) ? ProductsDatabaseInputs.productsDatabase : "${usernameId}_${ProductsDatabaseInputs.productsDatabase}";
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var queryResult = await databaseInstance.delete(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [id],
    );

    return queryResult;
  }

}