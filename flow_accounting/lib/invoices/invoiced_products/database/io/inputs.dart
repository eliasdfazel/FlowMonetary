/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 5/11/22, 7:13 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/invoices/invoiced_products/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class InvoicedProductsDatabaseInputs {

  static String invoicedProductsDatabase(int invoiceId) {

    return "${invoiceId}_InvoicedProducts.db";
  }

  static const String databaseTableName = "all_selected_products";

  Future<void> insertInvoicedProductData(InvoicedProductsData invoicedProductsData, String databaseName, String tableName,
      {bool isPrototype = false}) async {

    var databaseNameQuery = databaseName;
    var tableNameQuery = InvoicedProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
                'invoiceProductId TEXT, '
                'invoiceProductName TEXT, '
                'invoiceProductQuantity TEXT, '
                'invoiceProductQuantityType TEXT, '
                'invoiceProductPrice TEXT, '
                'invoiceProductStatus TEXT'
                ')',
          );
        },

        version: 1,
        readOnly: false
    );

    final databaseInstance = await database;

    await databaseInstance.insert(
      tableNameQuery,
      invoicedProductsData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }
  }

  Future<void> updateInvoicedData(InvoicedProductsData invoicedProductsData, String databaseName, String tableName) async {

    var databaseNameQuery = databaseName;
    var tableNameQuery = InvoicedProductsDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      invoicedProductsData.toMap(),
      where: 'invoiceProductId = ?',
      whereArgs: [invoicedProductsData.invoiceProductId],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}