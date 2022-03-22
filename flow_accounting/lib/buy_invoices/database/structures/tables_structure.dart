/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 8:25 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class BuyInvoicesData {

  static const String BuyInvoice_Pre = "0";
  static const String BuyInvoice_Final = "1";

  final int id;

  final String buyInvoiceNumber;

  final String buyInvoiceDateText;
  final String buyInvoiceDateMillisecond;

  final String boughtProductName;
  final String boughtProductQuantity;

  String boughtProductPrice = "0";
  String boughtProductEachPrice = "0";
  String boughtProductPriceDiscount = "0";

  final String paidBy;

  final String boughtFrom;

  String buyPreInvoice = BuyInvoicesData.BuyInvoice_Final;

  int colorTag = ColorsResources.dark.value;

  BuyInvoicesData({
    required this.id,

    required this.buyInvoiceNumber,

    required this.buyInvoiceDateText,
    required this.buyInvoiceDateMillisecond,

    required this.boughtProductName,
    required this.boughtProductQuantity,

    required this.boughtProductPrice,
    required this.boughtProductEachPrice,
    required this.boughtProductPriceDiscount,

    required this.paidBy,

    required this.boughtFrom,

    required this.buyPreInvoice,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'buyInvoiceNumber': buyInvoiceNumber,

      'buyInvoiceDateText': buyInvoiceDateText,
      'buyInvoiceDateMillisecond': buyInvoiceDateMillisecond,

      'boughtProductName': boughtProductName,
      'boughtProductQuantity': boughtProductQuantity,

      'boughtProductPrice': boughtProductPrice,
      'boughtProductEachPrice': boughtProductEachPrice,
      'boughtProductPriceDiscount': boughtProductPriceDiscount,

      'paidBy': paidBy,

      'boughtFrom': boughtFrom,

      'buyPreInvoice': buyPreInvoice,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'BuyInvoicesData{'
        'id: $id,'

        'buyInvoiceNumber: $buyInvoiceNumber,'

        'buyInvoiceDateText: $buyInvoiceDateText,'
        'buyInvoiceDateMillisecond: $buyInvoiceDateMillisecond,'

        'boughtProductName: $boughtProductName,'
        'boughtProductQuantity: $boughtProductQuantity,'

        'boughtProductPrice: $boughtProductPrice,'
        'boughtProductEachPrice: $boughtProductEachPrice,'
        'boughtProductPriceDiscount: $boughtProductPriceDiscount,'

        'paidBy: $paidBy,'

        'boughtFrom: $boughtFrom,'

        'buyPreInvoice: $buyPreInvoice,'

        'colorTag: $colorTag,'
        '}';
  }
}
