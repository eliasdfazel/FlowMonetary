/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/6/22, 6:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class SellInvoicesData {

  static const String SellInvoice_Pre = "0";
  static const String SellInvoice_Final = "1";

  final int id;

  final String companyName;
  final String companyLogoUrl;

  final String sellInvoiceNumber;

  final String sellInvoiceDescription;

  final String sellInvoiceDateText;
  final int sellInvoiceDateMillisecond;

  final String soldProductId;
  final String soldProductName;
  final String soldProductQuantity;

  String soldProductPrice = "0";
  String soldProductEachPrice = "0";
  String soldProductPriceDiscount = "0";

  final String paidTo;

  final String soldTo;

  String sellPreInvoice = SellInvoicesData.SellInvoice_Final;

  final String companyDigitalSignature;

  int colorTag = ColorsResources.dark.value;

  SellInvoicesData({
    required this.id,

    required this.companyName,
    required this.companyLogoUrl,

    required this.sellInvoiceNumber,

    required this.sellInvoiceDescription,

    required this.sellInvoiceDateText,
    required this.sellInvoiceDateMillisecond,

    required this.soldProductId,
    required this.soldProductName,
    required this.soldProductQuantity,

    required this.soldProductPrice,
    required this.soldProductEachPrice,
    required this.soldProductPriceDiscount,

    required this.paidTo,

    required this.soldTo,

    required this.sellPreInvoice,

    required this.companyDigitalSignature,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'companyName': companyName,
      'companyLogoUrl': companyLogoUrl,

      'sellInvoiceNumber': sellInvoiceNumber,

      'sellInvoiceDescription': sellInvoiceDescription,

      'sellInvoiceDateText': sellInvoiceDateText,
      'sellInvoiceDateMillisecond': sellInvoiceDateMillisecond,

      'soldProductId': soldProductId,
      'soldProductName': soldProductName,
      'soldProductQuantity': soldProductQuantity,

      'soldProductPrice': soldProductPrice,
      'soldProductEachPrice': soldProductEachPrice,
      'soldProductPriceDiscount': soldProductPriceDiscount,

      'paidTo': paidTo,

      'soldTo': soldTo,

      'sellPreInvoice': sellPreInvoice,

      'companyDigitalSignature': companyDigitalSignature,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'SellInvoicesData{'
        'id: $id,'

        'companyName: $companyName,'
        'companyLogoUrl: $companyLogoUrl,'

        'sellInvoiceNumber: $sellInvoiceNumber,'

        'sellInvoiceDescription: $sellInvoiceDescription,'

        'sellInvoiceDateText: $sellInvoiceDateText,'
        'sellInvoiceDateMillisecond: $sellInvoiceDateMillisecond,'

        'soldProductId: $soldProductId,'
        'soldProductName: $soldProductName,'
        'soldProductQuantity: $soldProductQuantity,'

        'soldProductPrice: $soldProductPrice,'
        'soldProductEachPrice: $soldProductEachPrice,'
        'soldProductPriceDiscount: $soldProductPriceDiscount,'

        'paidTo: $paidTo,'

        'soldTo: $soldTo,'

        'sellPreInvoice: $sellPreInvoice,'

        'companyDigitalSignature: $companyDigitalSignature,'

        'colorTag: $colorTag,'
        '}';
  }
}
