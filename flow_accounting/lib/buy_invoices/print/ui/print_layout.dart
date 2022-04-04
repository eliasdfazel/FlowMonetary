/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/4/22, 7:22 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/prototype/prototype_data.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/colors/color_modifier.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      home: PrintLayout().design(BuyInvoicesData(
          id: 0,
          companyName: "فروشگاه خانه من",
          companyLogoUrl: "",
          buyInvoiceNumber: "123456789",
          buyInvoiceDescription: "خرید محصولات wmf برای سفارش آقای راد",
          buyInvoiceDateText: "سه شنبه ۱۵ فروردین ۱۴۰۱",
          buyInvoiceDateMillisecond: 1649079465776,
          boughtProductId: "1649079065776",
          boughtProductName: "سرویس پذیرایی wmf مدل k23",
          boughtProductQuantity: "3",
          boughtProductPrice: "51000000",
          boughtProductEachPrice: "17000000",
          boughtProductPriceDiscount: "0",
          paidBy: "6274121345789654",
          boughtFrom: "نمایندگی wmf مشهد - احمدآباد",
          buyPreInvoice: BuyInvoicesData.BuyInvoice_Final,
          companyDigitalSignature: "",
          colorTag: PrototypeData().listOfColors[0].value
      ))
  ));

}

class PrintLayout {

  Widget design(BuyInvoicesData buyInvoicesData) {

    return SafeArea(
      child: Container(
        color: ColorsResources.black,
        child: Padding(
            padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    gradient: LinearGradient(
                        colors: [
                          ColorsResources.white,
                          Color(buyInvoicesData.colorTag).lighten(0.19),
                        ],
                        transform: GradientRotation(45)
                    )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                buyInvoicesData.companyName,
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
                                        borderRadius: BorderRadius.circular(19),
                                        child: ColoredBox(
                                            color: Color(buyInvoicesData.colorTag),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                                              child: Image.file(
                                                  File(buyInvoicesData.companyLogoUrl)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              height: 37,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                        StringsResources.buyInvoicesNumber(),
                                        style: TextStyle(
                                            fontSize: 13,
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
                              height: 37,
                              width: double.infinity,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Text(
                                        StringsResources.buyInvoicesDate(),
                                        style: TextStyle(
                                            fontSize: 13,
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
                    ),
                    Row(
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
                                        buyInvoicesData.buyInvoiceNumber,
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
                          flex: 1,
                          child: SizedBox(
                            height: 51,
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(7, 0, 9, 0),
                                child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                      buyInvoicesData.buyInvoiceDateText,
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
                  ],
                )
            )
        )
      )
    );
  }

}