/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 5:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/invoices/buy_invoices/database/io/inputs.dart';
import 'package:flow_accounting/invoices/buy_invoices/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BuyInvoicesDatabaseQueries {

  Future<List<BuyInvoicesData>> getAllBuyInvoices(String tableName,
      String usernameId) async {

    var databaseNameQuery = BuyInvoicesDatabaseInputs.buyInvoicesDatabase();
    var tableNameQuery = BuyInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    final List<Map<String, dynamic>> maps = await databaseInstance.query(tableNameQuery);

    return List.generate(maps.length, (i) {
      return BuyInvoicesData(
        id: maps[i]['id'],

        companyName: maps[i]['companyName'],
        companyLogoUrl: maps[i]['companyLogoUrl'],

        buyInvoiceNumber: maps[i]['buyInvoiceNumber'],

        buyInvoiceDescription: maps[i]['buyInvoiceDescription'],

        buyInvoiceDateText: maps[i]['buyInvoiceDateText'],
        buyInvoiceDateMillisecond: int.parse(maps[i]['buyInvoiceDateMillisecond'].toString()),

        boughtProductPrice: maps[i]['boughtProductPrice'],
        boughtProductPriceDiscount: maps[i]['boughtProductPriceDiscount'],

        invoiceDiscount: maps[i]['invoiceDiscount'],

        productShippingExpenses: maps[i]['productShippingExpenses'],

        productTax: maps[i]['productTax'],

        paidBy: maps[i]['paidBy'],

        boughtFrom: maps[i]['boughtFrom'],

        buyPreInvoice: maps[i]['buyPreInvoice'],

        companyDigitalSignature: maps[i]['companyDigitalSignature'],

        invoicePaidCash: maps[i]['invoicePaidCash'],

        invoiceChequesNumbers: maps[i]['invoiceChequesNumbers'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),

        invoiceReturned: maps[i]['invoiceReturned'],
      );
    });

  }

  Future<BuyInvoicesData> querySpecificBuyInvoiceById(
      String buyInvoiceId,
      String tableName, String usernameId) async {

    var databaseNameQuery = BuyInvoicesDatabaseInputs.buyInvoicesDatabase();
    var tableNameQuery = BuyInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    var databaseContents = await databaseInstance.query(
      tableNameQuery,
      where: 'id = ?',
      whereArgs: [buyInvoiceId],
    );

    return BuyInvoicesData(
      id: databaseContents[0]['id'] as int,

      companyName: databaseContents[0]['companyName'].toString(),
      companyLogoUrl: databaseContents[0]['companyLogoUrl'].toString(),

      buyInvoiceNumber: databaseContents[0]['buyInvoiceNumber'].toString(),

      buyInvoiceDescription: databaseContents[0]['buyInvoiceDescription'].toString(),

      buyInvoiceDateText: databaseContents[0]['buyInvoiceDateText'].toString(),
      buyInvoiceDateMillisecond: int.parse(databaseContents[0]['buyInvoiceDateMillisecond'].toString()),

      boughtProductPrice: databaseContents[0]['boughtProductPrice'].toString(),
      boughtProductPriceDiscount: databaseContents[0]['boughtProductPriceDiscount'].toString(),

      invoiceDiscount: databaseContents[0]['invoiceDiscount'].toString(),

      productShippingExpenses: databaseContents[0]['productShippingExpenses'].toString(),

      productTax: databaseContents[0]['productTax'].toString(),

      paidBy: databaseContents[0]['paidBy'].toString(),

      boughtFrom: databaseContents[0]['boughtFrom'].toString(),

      buyPreInvoice: databaseContents[0]['buyPreInvoice'].toString(),

      companyDigitalSignature: databaseContents[0]['companyDigitalSignature'].toString(),

      invoicePaidCash: databaseContents[0]['invoicePaidCash'].toString(),

      invoiceChequesNumbers: databaseContents[0]['invoiceChequesNumbers'].toString(),

      colorTag: int.parse(databaseContents[0]['colorTag'].toString()),

      invoiceReturned: databaseContents[0]['invoiceReturned'].toString(),
    );
  }

  Future<int> queryDeleteBuyInvoice(int id,
      String tableName, String usernameId) async {

    var databaseNameQuery = BuyInvoicesDatabaseInputs.buyInvoicesDatabase();
    var tableNameQuery = BuyInvoicesDatabaseInputs.databaseTableName;

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