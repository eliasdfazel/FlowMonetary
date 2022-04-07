/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 3:41 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/sell_invoices/database/io/inputs.dart';
import 'package:flow_accounting/sell_invoices/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class sellInvoicesDatabaseQueries {

  Future<List<SellInvoicesData>> getAllSellInvoices(String tableName,
      String usernameId) async {

    var databaseNameQuery = SellInvoicesDatabaseInputs.sellInvoicesDatabase();
    var tableNameQuery = SellInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return SellInvoicesData(
        id: maps[i]['id'],

        companyName: maps[i]['companyName'],
        companyLogoUrl: maps[i]['companyLogoUrl'],

        sellInvoiceNumber: maps[i]['sellInvoiceNumber'],

        sellInvoiceDescription: maps[i]['sellInvoiceDescription'],

        sellInvoiceDateText: maps[i]['sellInvoiceDateText'],
        sellInvoiceDateMillisecond: int.parse(maps[i]['sellInvoiceDateMillisecond'].toString()),

        soldProductId: maps[i]['soldProductId'],
        soldProductName: maps[i]['soldProductName'],
        soldProductQuantity: maps[i]['soldProductName'],

        soldProductPrice: maps[i]['soldProductPrice'],
        soldProductEachPrice: maps[i]['soldProductEachPrice'],
        soldProductPriceDiscount: maps[i]['soldProductPriceDiscount'],

        paidTo: maps[i]['paidBy'],

        soldTo: maps[i]['soldTo'],

        sellPreInvoice: maps[i]['sellPreInvoice'],

        companyDigitalSignature: maps[i]['companyDigitalSignature'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<int> queryDeleteSellInvoice(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = SellInvoicesDatabaseInputs.sellInvoicesDatabase();
    var tableNameQuery = SellInvoicesDatabaseInputs.databaseTableName;

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