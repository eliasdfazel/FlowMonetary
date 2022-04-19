/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/6/22, 6:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/sell_invoices/database/structures/tables_structure.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SellInvoicesDatabaseInputs {

  static const String databaseTableName = "all_sell_invoices";

  static String sellInvoicesDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText()) ? "sell_invoices_database.db" : "${UserInformation.UserId}_sell_invoices_database.db";;
  }

  Future<void> insertSellInvoiceData(SellInvoicesData sellInvoicesData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = SellInvoicesDatabaseInputs.sellInvoicesDatabase();
    var tableNameQuery = SellInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
        join(await getDatabasesPath(), databaseNameQuery),
        onCreate: (databaseInstance, version) {

          return databaseInstance.execute(
            'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
                'companyName TEXT, '
                'companyLogoUrl TEXT, '
                'sellInvoiceNumber TEXT, '
                'sellInvoiceDescription TEXT, '
                'sellInvoiceDateText TEXT, '
                'sellInvoiceDateMillisecond TEXT, '
                'soldProductId TEXT, '
                'soldProductName TEXT, '
                'soldProductQuantity TEXT, '
                'productQuantityType TEXT, '
                'soldProductPrice TEXT, '
                'soldProductEachPrice TEXT, '
                'soldProductPriceDiscount TEXT, '
                'productShippingExpenses TEXT, '
                'productTax TEXT, '
                'paidTo TEXT, '
                'soldTo TEXT, '
                'sellPreInvoice TEXT, '
                'companyDigitalSignature TEXT, '
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
      sellInvoicesData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }
  }

  Future<void> updateInvoiceData(SellInvoicesData sellInvoicesData, String tableName, String usernameId) async {

    var databaseNameQuery = SellInvoicesDatabaseInputs.sellInvoicesDatabase();
    var tableNameQuery = SellInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      sellInvoicesData.toMap(),
      where: 'id = ?',
      whereArgs: [sellInvoicesData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}