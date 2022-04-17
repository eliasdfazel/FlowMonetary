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

  final int id;

  final String companyName;
  final String companyLogoUrl;

  final String buyInvoiceNumber;

  final String buyInvoiceDescription;

  final String buyInvoiceDateText;
  final int buyInvoiceDateMillisecond;

  final String boughtProductId;
  final String boughtProductName;
  final String boughtProductQuantity;
  final String productQuantityType;

  String boughtProductPrice = "0";
  String boughtProductEachPrice = "0";
  String boughtProductPriceDiscount = "0";

  final String paidBy;

  final String boughtFrom;

  String buyPreInvoice = BuyInvoicesData.BuyInvoice_Final;

  final String companyDigitalSignature;

  int colorTag = ColorsResources.dark.value;

  BuyInvoicesData({
    required this.id,

    required this.companyName,
    required this.companyLogoUrl,

    required this.buyInvoiceNumber,

    required this.buyInvoiceDescription,

    required this.buyInvoiceDateText,
    required this.buyInvoiceDateMillisecond,

    required this.boughtProductId,
    required this.boughtProductName,
    required this.boughtProductQuantity,
    required this.productQuantityType,

    required this.boughtProductPrice,
    required this.boughtProductEachPrice,
    required this.boughtProductPriceDiscount,

    required this.paidBy,

    required this.boughtFrom,

    required this.buyPreInvoice,

    required this.companyDigitalSignature,

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

      'boughtProductId': boughtProductId,
      'boughtProductName': boughtProductName,
      'boughtProductQuantity': boughtProductQuantity,
      'productQuantityType': productQuantityType,

      'boughtProductPrice': boughtProductPrice,
      'boughtProductEachPrice': boughtProductEachPrice,
      'boughtProductPriceDiscount': boughtProductPriceDiscount,

      'paidBy': paidBy,

      'boughtFrom': boughtFrom,

      'buyPreInvoice': buyPreInvoice,

      'companyDigitalSignature': companyDigitalSignature,

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

        'boughtProductId: $boughtProductId,'
        'boughtProductName: $boughtProductName,'
        'boughtProductQuantity: $boughtProductQuantity,'
        'productQuantityType: $productQuantityType,'

        'boughtProductPrice: $boughtProductPrice,'
        'boughtProductEachPrice: $boughtProductEachPrice,'
        'boughtProductPriceDiscount: $boughtProductPriceDiscount,'

        'paidBy: $paidBy,'

        'boughtFrom: $boughtFrom,'

        'buyPreInvoice: $buyPreInvoice,'

        'companyDigitalSignature: $companyDigitalSignature,'

        'colorTag: $colorTag,'
        '}';
  }
}
