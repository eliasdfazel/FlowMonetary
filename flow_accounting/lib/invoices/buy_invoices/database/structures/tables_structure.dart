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

class BuyInvoicesData {

  static const String BuyInvoice_Pre = "0";
  static const String BuyInvoice_Final = "1";

  static const String BuyInvoice_Returned = "666";

  final int id;

  final String companyName;
  final String companyLogoUrl;

  final String buyInvoiceNumber;

  final String buyInvoiceDescription;

  final String buyInvoiceDateText;
  final int buyInvoiceDateMillisecond;

  String boughtProductPrice = "0";
  String boughtProductPriceDiscount = "0";

  String invoiceDiscount = "0";

  final String productShippingExpenses;

  final String productTax;

  final String paidBy;

  final String boughtFrom;

  String buyPreInvoice = BuyInvoicesData.BuyInvoice_Final;

  final String companyDigitalSignature;

  String invoiceReturned = BuyInvoicesData.BuyInvoice_Returned;

  String invoiceChequesNumbers;

  int colorTag = ColorsResources.dark.value;

  BuyInvoicesData({
    required this.id,

    required this.companyName,
    required this.companyLogoUrl,

    required this.buyInvoiceNumber,

    required this.buyInvoiceDescription,

    required this.buyInvoiceDateText,
    required this.buyInvoiceDateMillisecond,

    required this.boughtProductPrice,
    required this.boughtProductPriceDiscount,

    required this.invoiceDiscount,

    required this.productShippingExpenses,

    required this.productTax,

    required this.paidBy,

    required this.boughtFrom,

    required this.buyPreInvoice,

    required this.companyDigitalSignature,

    required this.invoiceReturned,

    required this.invoiceChequesNumbers,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'companyName': companyName,
      'companyLogoUrl': companyLogoUrl,

      'buyInvoiceNumber': buyInvoiceNumber,

      'buyInvoiceDescription': buyInvoiceDescription,

      'buyInvoiceDateText': buyInvoiceDateText,
      'buyInvoiceDateMillisecond': buyInvoiceDateMillisecond,

      'boughtProductPrice': boughtProductPrice,
      'boughtProductPriceDiscount': boughtProductPriceDiscount,

      'invoiceDiscount': invoiceDiscount,

      'productShippingExpenses': productShippingExpenses,

      'productTax': productTax,

      'paidBy': paidBy,

      'boughtFrom': boughtFrom,

      'buyPreInvoice': buyPreInvoice,

      'companyDigitalSignature': companyDigitalSignature,

      'invoiceReturned': invoiceReturned,

      'invoiceChequesNumbers': invoiceChequesNumbers,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'BuyInvoicesData{'
        'id: $id,'

        'companyName: $companyName,'
        'companyLogoUrl: $companyLogoUrl,'

        'buyInvoiceNumber: $buyInvoiceNumber,'

        'buyInvoiceDescription: $buyInvoiceDescription,'

        'buyInvoiceDateText: $buyInvoiceDateText,'
        'buyInvoiceDateMillisecond: $buyInvoiceDateMillisecond,'

        'boughtProductPrice: $boughtProductPrice,'
        'boughtProductPriceDiscount: $boughtProductPriceDiscount,'

        'invoiceDiscount: $invoiceDiscount,'

        'productShippingExpenses: $productShippingExpenses,'

        'productTax: $productTax,'

        'paidBy: $paidBy,'

        'boughtFrom: $boughtFrom,'

        'buyPreInvoice: $buyPreInvoice,'

        'companyDigitalSignature: $companyDigitalSignature,'

        'invoiceReturned: $invoiceReturned,'

        'invoiceChequesNumbers: $invoiceChequesNumbers,'

        'colorTag: $colorTag,'
        '}';
  }
}