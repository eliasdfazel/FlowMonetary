/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 5:27 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

class PrintLayout {

  Widget design(BuyInvoicesData buyInvoicesData) {

    return Padding(
      padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Container(
        color: ColorsResources.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

          ],
        )
      )
    );
  }

}