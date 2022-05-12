/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 5:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class SellInvoicesData {

  static const String SellInvoice_Pre = "0";
  static const String SellInvoice_Final = "1";

  static const String SellInvoice_Returned = "666";

  final int id;

  final String companyName;
  final String companyLogoUrl;

  final String sellInvoiceNumber;

  final String sellInvoiceDescription;

  final String sellInvoiceDateText;
  final int sellInvoiceDateMillisecond;

  String soldProductPrice = "0";
  String soldProductPriceDiscount = "0";

  String invoiceDiscount = "0";

  final String productShippingExpenses;

  final String productTax;

  final String paidTo;

  final String soldTo;

  String sellPreInvoice = SellInvoicesData.SellInvoice_Final;

  final String companyDigitalSignature;

  String invoiceReturned = SellInvoicesData.SellInvoice_Returned;

  int colorTag = ColorsResources.dark.value;

  SellInvoicesData({
    required this.id,

    required this.companyName,
    required this.companyLogoUrl,

    required this.sellInvoiceNumber,

    required this.sellInvoiceDescription,

    required this.sellInvoiceDateText,
    required this.sellInvoiceDateMillisecond,

    required this.soldProductPrice,
    required this.soldProductPriceDiscount,

    required this.invoiceDiscount,

    required this.productShippingExpenses,

    required this.productTax,

    required this.paidTo,

    required this.soldTo,

    required this.sellPreInvoice,

    required this.companyDigitalSignature,

    required this.invoiceReturned,

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

      'soldProductPrice': soldProductPrice,
      'soldProductPriceDiscount': soldProductPriceDiscount,

      'invoiceDiscount': invoiceDiscount,

      'productShippingExpenses': productShippingExpenses,

      'productTax': productTax,

      'paidTo': paidTo,

      'soldTo': soldTo,

      'sellPreInvoice': sellPreInvoice,

      'companyDigitalSignature': companyDigitalSignature,

      'invoiceReturned': invoiceReturned,

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

        'soldProductPrice: $soldProductPrice,'
        'soldProductPriceDiscount: $soldProductPriceDiscount,'

        'invoiceDiscount: $invoiceDiscount,'

        'productShippingExpenses: $productShippingExpenses,'

        'productTax: $productTax,'

        'paidTo: $paidTo,'

        'soldTo: $soldTo,'

        'sellPreInvoice: $sellPreInvoice,'

        'companyDigitalSignature: $companyDigitalSignature,'

        'invoiceReturned: $invoiceReturned,'

        'colorTag: $colorTag,'
        '}';
  }
}