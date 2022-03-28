/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/28/22, 9:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/buy_invoices/database/io/inputs.dart';
import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
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

        buyInvoiceNumber: maps[i]['buyInvoiceNumber'],

        buyInvoiceDescription: maps[i]['buyInvoiceDescription'],

        buyInvoiceDateText: maps[i]['buyInvoiceDateText'],
        buyInvoiceDateMillisecond: int.parse(maps[i]['buyInvoiceDateMillisecond'].toString()),

        boughtProductId: maps[i]['boughtProductId'],
        boughtProductName: maps[i]['boughtProductName'],
        boughtProductQuantity: maps[i]['boughtProductQuantity'],

        boughtProductPrice: maps[i]['boughtProductPrice'],
        boughtProductEachPrice: maps[i]['boughtProductEachPrice'],
        boughtProductPriceDiscount: maps[i]['boughtProductPriceDiscount'],

        paidBy: maps[i]['paidBy'],

        boughtFrom: maps[i]['boughtFrom'],

        buyPreInvoice: maps[i]['buyPreInvoice'],

        colorTag: int.parse(maps[i]['colorTag'].toString()),
      );
    });

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