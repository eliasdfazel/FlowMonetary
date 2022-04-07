/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 3:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/sell_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/colors/color_modifier.dart';
import 'package:flutter/material.dart';

class SellPrintLayout {

  Widget design(SellInvoicesData sellInvoicesData) {

    String invoiceType = StringsResources.buyInvoiceFinal();

    switch (sellInvoicesData.sellPreInvoice) {
      case SellInvoicesData.SellInvoice_Pre: {

        invoiceType = StringsResources.buyInvoicePre();

        break;
      }
      case SellInvoicesData.SellInvoice_Final: {

        invoiceType = StringsResources.buyInvoiceFinal();

        break;
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        body: Container(
            color: ColorsResources.black,
            child: Padding(
                padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        gradient: LinearGradient(
                            colors: [
                              ColorsResources.white,
                              Color(sellInvoicesData.colorTag).lighten(0.19),
                            ],
                            transform: GradientRotation(45)
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    flex: 9,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                        child: Align(
                                            alignment: AlignmentDirectional.centerEnd,
                                            child: Text(
                                                sellInvoicesData.companyName,
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    color: ColorsResources.black,
                                                    fontFamily: 'Sans',
                                                    decoration: TextDecoration.none
                                                )
                                            )
                                        )
                                    )
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Align(
                                                alignment: AlignmentDirectional.center,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(11),
                                                    child: ColoredBox(
                                                        color: Color(sellInvoicesData.colorTag),
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                                                            child: Image.file(
                                                                File(sellInvoicesData.companyLogoUrl)
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                              ]
                          ),
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.buyInvoicesNumber(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.buyInvoicesDate(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.sellInvoiceNumber,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.sellInvoiceDateText,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),

                        Divider(
                          height: 1,
                          indent: 13,
                          endIndent: 13,
                          thickness: 1,
                          color: ColorsResources.blue.withOpacity(0.37),
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.productQuantity(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.buyInvoiceProductHint(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.soldProductQuantity,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.soldProductName,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),

                        Divider(
                          height: 1,
                          indent: 13,
                          endIndent: 13,
                          thickness: 1,
                          color: ColorsResources.blue.withOpacity(0.37),
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.invoiceDiscount(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.invoiceEachPrice(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.soldProductPriceDiscount,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.soldProductEachPrice,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.invoicePrice(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.soldProductPrice,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(7, 7, 7, 0),
                            child: SizedBox(
                                height: 79,
                                width: double.infinity,
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11),
                                      border: Border(
                                          top: BorderSide(
                                            color: ColorsResources.blue.withOpacity(0.37),
                                            width: 3,
                                          ),
                                          bottom: BorderSide(
                                            color: ColorsResources.blue.withOpacity(0.37),
                                            width: 3,
                                          ),
                                          left: BorderSide(
                                            color: ColorsResources.blue.withOpacity(0.37),
                                            width: 3,
                                          ),
                                          right: BorderSide(
                                            color: ColorsResources.blue.withOpacity(0.37),
                                            width: 3,
                                          )
                                      ),
                                      color: ColorsResources.white.withOpacity(0.37),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(7, 1, 7, 1),
                                        child: Align(
                                            alignment: AlignmentDirectional.centerEnd,
                                            child: Text(
                                                "buy\nInv\noice\nsDa\nta.buyInvo\niceDescription",
                                                maxLines: 3,
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: ColorsResources.dark,
                                                    fontFamily: 'Sans',
                                                    fontWeight: FontWeight.w300,
                                                    decoration: TextDecoration.none
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 27,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.invoicePaidBy(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 27,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.buyInvoiceBoughtFrom(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 37,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.paidTo,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      fontWeight: FontWeight.bold,
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                      height: 37,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  sellInvoicesData.soldTo,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      fontWeight: FontWeight.bold,
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),

                        Divider(
                          height: 3,
                          indent: 13,
                          endIndent: 13,
                          thickness: 1,
                          color: ColorsResources.blue.withOpacity(0.37),
                        ),

                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.digitalSignature(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                      height: 31,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  StringsResources.buyInvoiceType(),
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: ColorsResources.blackTransparent,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.center,
                                              child: Image.file(
                                                File(sellInvoicesData.companyDigitalSignature),
                                                fit: BoxFit.contain,
                                              )
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                      height: 51,
                                      width: double.infinity,
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                          child: Align(
                                              alignment: AlignmentDirectional.centerEnd,
                                              child: Text(
                                                  invoiceType,
                                                  textDirection: TextDirection.rtl,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: ColorsResources.black,
                                                      fontFamily: 'Sans',
                                                      decoration: TextDecoration.none
                                                  )
                                              )
                                          )
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                )
            )
        )
      )
    );
  }

}