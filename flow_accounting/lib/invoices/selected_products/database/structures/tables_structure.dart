/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

class InvoicedProductsData {

  static const Product_Purchased = 0;
  static const Product_Returned = 1;

  final int id;

  final int invoiceProductId;
  final String invoiceProductName;
  final int invoiceProductQuantity;
  final String invoiceProductQuantityType;
  final String invoiceProductPrice;

  int invoiceProductStatus = InvoicedProductsData.Product_Purchased;

  InvoicedProductsData({
    required this.id,

    required this.invoiceProductId,
    required this.invoiceProductName,
    required this.invoiceProductQuantity,
    required this.invoiceProductQuantityType,
    required this.invoiceProductPrice,

    required this.invoiceProductStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'invoiceProductId': invoiceProductId,
      'invoiceProductName': invoiceProductName,
      'invoiceProductQuantity': invoiceProductQuantity,
      'invoiceProductQuantityType': invoiceProductQuantityType,
      'invoiceProductPrice': invoiceProductPrice,

      'invoiceProductStatus': invoiceProductStatus,
    };
  }

  @override
  String toString() {
    return 'InvoicedProductsData{'
      'id: $id,'

      'invoiceProductId: $invoiceProductId,'
      'invoiceProductName: $invoiceProductName,'
      'invoiceProductQuantity: $invoiceProductQuantity,'
      'invoiceProductQuantityType: $invoiceProductQuantityType,'
      'invoiceProductPrice: $invoiceProductPrice,'

      'invoiceProductStatus: $invoiceProductStatus,'
    '}';
  }
}
