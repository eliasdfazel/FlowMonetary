/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 8:25 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:core';

import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BuyInvoicesDatabaseInputs {

  static const String databaseTableName = "all_budgets";

  static String buyInvoicesDatabase() {

    return (UserInformation.UserId == StringsResources.unknownText) ? "buy_invoices_database.db" : "${UserInformation.UserId}_buy_invoices_database.db";;
  }

  Future<void> insertBuyInvoiceData(BuyInvoicesData buyInvoicesData, String tableName,
      String usernameId, {bool isPrototype = false}) async {

    var databaseNameQuery = BuyInvoicesDatabaseInputs.buyInvoicesDatabase();
    var tableNameQuery = BuyInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
      onCreate: (databaseInstance, version) {

        return databaseInstance.execute(
          'CREATE TABLE IF NOT EXISTS $tableNameQuery(id INTEGER PRIMARY KEY, '
              'buyInvoiceNumber TEXT, '
              'buyInvoiceDateText TEXT, '
              'buyInvoiceDateMillisecond TEXT, '
              'boughtProductName TEXT, '
              'boughtProductQuantity TEXT, '
              'boughtProductPrice TEXT, '
              'boughtProductEachPrice TEXT, '
              'boughtProductPriceDiscount TEXT, '
              'paidBy TEXT, '
              'boughtFrom TEXT, '
              'buyPreInvoice TEXT, '
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
      buyInvoicesData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (databaseInstance.isOpen && !isPrototype) {

      await databaseInstance.close();

    }
  }

  Future<void> updateInvoiceData(BuyInvoicesData buyInvoicesData, String tableName, String usernameId) async {

    var databaseNameQuery = BuyInvoicesDatabaseInputs.buyInvoicesDatabase();
    var tableNameQuery = BuyInvoicesDatabaseInputs.databaseTableName;

    final database = openDatabase(
      join(await getDatabasesPath(), databaseNameQuery),
    );

    final databaseInstance = await database;

    await databaseInstance.update(
      tableNameQuery,
      buyInvoicesData.toMap(),
      where: 'id = ?',
      whereArgs: [buyInvoicesData.id],
    );

    if (databaseInstance.isOpen) {

      await databaseInstance.close();

    }

  }

}