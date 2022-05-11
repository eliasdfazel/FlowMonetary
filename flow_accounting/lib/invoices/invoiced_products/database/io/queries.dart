/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 5/11/22, 7:22 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/invoices/invoiced_products/database/io/inputs.dart';
import 'package:flow_accounting/invoices/invoiced_products/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InvoicedProductsQueries {


  Future<List<InvoicedProductsData>> getAllInvoicedProducts(String databaseName, String tableName) async {

    var databaseNameQuery = databaseName;
    var tableNameQuery = InvoicedProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> databaseContents = await databaseInstance.query(tableNameQuery);

    return List.generate(databaseContents.length, (i) {
      return InvoicedProductsData(
        id: databaseContents[i]['id'] as int,

        invoiceProductId: int.parse(databaseContents[i]['invoiceProductId'].toString()),
        invoiceProductName: databaseContents[i]['invoiceProductName'].toString(),
        invoiceProductPrice: databaseContents[i]['invoiceProductPrice'].toString(),
        invoiceProductQuantity: int.parse(databaseContents[i]['invoiceProductQuantity'].toString()),
        invoiceProductQuantityType: databaseContents[i]['invoiceProductQuantityType'].toString(),

        invoiceProductStatus: int.parse(databaseContents[i]['invoiceProductId'].toString()),
      );
    });

  }

  Future<InvoicedProductsData> queryInvoicedProductById(
      String invoiceProductId,
      String databaseName, String tableName) async {

    var databaseNameQuery = databaseName;
    var tableNameQuery = InvoicedProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'invoiceProductId = ?',
      whereArgs: [invoiceProductId],
    );

    return InvoicedProductsData(
      id: databaseContents[0]['id'] as int,

      invoiceProductId: int.parse(databaseContents[0]['invoiceProductId'].toString()),
      invoiceProductName: databaseContents[0]['invoiceProductName'].toString(),
      invoiceProductPrice: databaseContents[0]['invoiceProductPrice'].toString(),
      invoiceProductQuantity: int.parse(databaseContents[0]['invoiceProductQuantity'].toString()),
      invoiceProductQuantityType: databaseContents[0]['invoiceProductQuantityType'].toString(),

      invoiceProductStatus: int.parse(databaseContents[0]['invoiceProductId'].toString()),
    );
  }

}