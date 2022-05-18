/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 4:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/invoices/sell_invoices/database/io/inputs.dart';
import 'package:flow_accounting/invoices/sell_invoices/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SellInvoicesDatabaseQueries {

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

        soldProductPrice: maps[i]['soldProductPrice'],
        soldProductPriceDiscount: maps[i]['soldProductPriceDiscount'],

        invoiceDiscount: maps[i]['invoiceDiscount'],

        productShippingExpenses: maps[i]['productShippingExpenses'],

        productTax: maps[i]['productTax'],

        paidTo: maps[i]['paidTo'],

        soldTo: maps[i]['soldTo'],

        sellPreInvoice: maps[i]['sellPreInvoice'],

        companyDigitalSignature: maps[i]['companyDigitalSignature'],

        invoiceReturned: maps[i]['invoiceReturned'],

        invoicePaidCash: maps[i]['invoicePaidCash'],

        invoiceChequesNumbers: maps[i]['invoiceChequesNumbers'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

  }

  Future<SellInvoicesData> querySpecificSellInvoiceById(
      String buyInvoiceId,
      String tableName, String usernameId) async {

    var databaseNameQuery = SellInvoicesDatabaseInputs.sellInvoicesDatabase();
    var tableNameQuery = SellInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [buyInvoiceId],
    );

    return SellInvoicesData(
      id: databaseContents[0]['id'] as int,

      companyName: databaseContents[0]['companyName'].toString(),
      companyLogoUrl: databaseContents[0]['companyLogoUrl'].toString(),

      sellInvoiceNumber: databaseContents[0]['sellInvoiceNumber'].toString(),

      sellInvoiceDescription: databaseContents[0]['sellInvoiceDescription'].toString(),

      sellInvoiceDateText: databaseContents[0]['sellInvoiceDateText'].toString(),
      sellInvoiceDateMillisecond: int.parse(databaseContents[0]['sellInvoiceDateMillisecond'].toString()),

      soldProductPrice: databaseContents[0]['soldProductPrice'].toString(),
      soldProductPriceDiscount: databaseContents[0]['soldProductPriceDiscount'].toString(),

      invoiceDiscount: databaseContents[0]['invoiceDiscount'].toString(),

      productShippingExpenses: databaseContents[0]['productShippingExpenses'].toString(),

      productTax: databaseContents[0]['productTax'].toString(),

      paidTo: databaseContents[0]['paidTo'].toString(),

      soldTo: databaseContents[0]['soldTo'].toString(),

      sellPreInvoice: databaseContents[0]['sellPreInvoice'].toString(),

      companyDigitalSignature: databaseContents[0]['companyDigitalSignature'].toString(),

      invoiceReturned: databaseContents[0]['invoiceReturned'].toString(),

      invoicePaidCash: databaseContents[0]['invoicePaidCash'].toString(),

      invoiceChequesNumbers: databaseContents[0]['invoiceChequesNumbers'].toString(),

      colorTag: int.parse(databaseContents[0]['colorTag'].toString()),
    );
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