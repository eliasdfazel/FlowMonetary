/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 10:40 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProductsDatabaseQueries {

  Future<List<ProductsData>> getAllProducts(String tableName, String usernameId) async {

    var databaseNameQuery = ProductsDatabaseInputs.productsDatabase();
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

        productTax: maps[i]['productTax'],

        productQuantity: int.parse(maps[i]['productQuantity'].toString()),
        productQuantityType: maps[i]['productQuantityType'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<ProductsData> querySpecificProductById(
      String productId,
      String tableName, String usernameId) async {

    var databaseNameQuery = ProductsDatabaseInputs.productsDatabase();
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [productId],
    );

    return ProductsData(
      id: databaseContents[0]['id'] as int,

      productImageUrl: databaseContents[0]['productImageUrl'].toString(),

      productName: databaseContents[0]['productName'].toString(),
      productDescription: databaseContents[0]['productDescription'].toString(),

      productCategory: databaseContents[0]['productCategory'].toString(),

      productBrand: databaseContents[0]['productBrand'].toString(),
      productBrandLogoUrl: databaseContents[0]['productBrandLogoUrl'].toString(),

      productPrice: databaseContents[0]['productPrice'].toString(),
      productProfitPercent: databaseContents[0]['productProfitPercent'].toString(),

      productTax: databaseContents[0]['productTax'].toString(),

      productQuantity: int.parse(databaseContents[0]['productQuantity'].toString()),
      productQuantityType: databaseContents[0]['productQuantityType'].toString(),

      colorTag: int.parse(databaseContents[0]['colorTag'].toString()),
    );
  }

  Future<ProductsData?> querySpecificProductByName(
      String productName,
      String tableName, String usernameId) async {

    var databaseNameQuery = ProductsDatabaseInputs.productsDatabase();
    var tableNameQuery = ProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = null;

    try {

      databaseContents = await databaseInstance.query(
        tableNameQuery,
        where: 'productName = ?',
        whereArgs: [productName],
      );

    } on Exception {}

    ProductsData? queriedProduct = null;

    if (databaseContents != null) {

      queriedProduct = ProductsData(
        id: databaseContents[0]['id'] as int,

        productImageUrl: databaseContents[0]['productImageUrl'].toString(),

        productName: databaseContents[0]['productName'].toString(),
        productDescription: databaseContents[0]['productDescription'].toString(),

        productCategory: databaseContents[0]['productCategory'].toString(),

        productBrand: databaseContents[0]['productBrand'].toString(),
        productBrandLogoUrl: databaseContents[0]['productBrandLogoUrl'].toString(),

        productPrice: databaseContents[0]['productPrice'].toString(),
        productProfitPercent: databaseContents[0]['productProfitPercent'].toString(),

        productTax: databaseContents[0]['productTax'].toString(),

        productQuantity: int.parse(databaseContents[0]['productQuantity'].toString()),
        productQuantityType: databaseContents[0]['productQuantityType'].toString(),

        colorTag: int.parse(databaseContents[0]['colorTag'].toString()),
      );

    }

    return queriedProduct;
  }

  Future<int> queryDeleteProduct(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = ProductsDatabaseInputs.productsDatabase();
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