/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 6:17 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/buy_invoices/print/ui/print_layout.dart';
import 'package:flow_accounting/utils/io/FileIO.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class PrintingProcess {

  void startBuyInvoicePrint(BuyInvoicesData buyInvoicesData, {String? sharingLabel}) {

    Widget invoiceLayout = PrintLayout().design(buyInvoicesData);

    ScreenshotController().captureFromWidget(invoiceLayout).then((Uint8List? snapshotBytes) async {

      if (snapshotBytes != null) {

        File invoiceSnapshotFile = await createFileOfBytes("BuyInvoice_${buyInvoicesData.buyInvoiceNumber}", "PNG", snapshotBytes);

        Share.shareFiles([invoiceSnapshotFile.path],
            text: "${sharingLabel}");

      }

    });

  }

}