/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 3:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:share_plus/share_plus.dart';

class PrintingProcess {

  void startBuyInvoicePrint(BuyInvoicesData buyInvoicesData, String filePath, {String? sharingLabel}) {

    Share.shareFiles([filePath],
        text: "${sharingLabel}");

  }

}