/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 6/11/22, 6:22 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/home/interface/sections/credit_cards_list_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/utils/colors/color_extractor.dart';
import 'package:flow_accounting/utils/extensions/bank_logos.dart';
import 'package:flow_accounting/utils/io/file_io.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareSnapshot {

  String backgroundPattern = generateBackgroundPattern();

  void shareCreditCardSnapshot(CreditCardsData creditCardsData) {

    ScreenshotController().captureFromWidget(designCreditCardSnapshot(creditCardsData)).then((Uint8List? snapshotBytes) async {

      if (snapshotBytes != null) {

        File invoiceSnapshotFile = await createFileOfBytes("CreditCard", "PNG", snapshotBytes);

        Share.shareFiles([invoiceSnapshotFile.path],
            text: "${creditCardsData.bankName}");

      }

    });

  }

  Widget designCreditCardSnapshot(CreditCardsData creditCardsData) {

    return Container(
      height: 279,
      width: 373,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.0),
        child: Stack(
          children: <Widget> [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                gradient: LinearGradient(
                    colors: [
                      ColorsResources.light,
                      ColorsResources.primaryColorLight.withOpacity(0.59),
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    transform: GradientRotation(45),
                    tileMode: TileMode.clamp),
              ),
            ),
            Opacity(
              opacity: 0.73,
              child: Image(
                image: AssetImage(backgroundPattern),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Opacity(
                opacity: 0.73,
                child: Image(
                  image: AssetImage("logo.png"),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
            ),
            Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 11, 13, 0),
                    child: SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 13,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 17, 0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      creditCardsData.bankName,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 27,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: 51,
                                width: 51,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: ColorsResources.white,
                                      shape: BoxShape.circle
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(51),
                                        child: Image.network(
                                          generateBankLogoUrl(creditCardsData.bankName),
                                          height: 51,
                                          width: 51,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                    child: SizedBox(
                      height: 63,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      creditCardsData.cardNumber.substring(0, 4),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      creditCardsData.cardNumber.substring(4, 8),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      creditCardsData.cardNumber.substring(8, 12),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      creditCardsData.cardNumber.substring(12, 16),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 5, 13, 1),
                    child: SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          creditCardsData.cardAccountNumber,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 21,
                            color: ColorsResources.dark,
                            shadows: [
                              Shadow(
                                color: ColorsResources.dark.withOpacity(0.37),
                                blurRadius: 7,
                                offset: const Offset(1.9, 1.9),
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 5, 13, 1),
                    child: SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 19,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      creditCardsData.cardHolderName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 27,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]
        )
      )
    );
  }

  Future<Color> extractBankDominantColor(ImageProvider? bankLogoImageProviderFront) async {

    Color dominantColor = ColorsResources.dark;

    if (bankLogoImageProviderFront != null) {

      Future<Color?> bankDominantColor = imageDominantColor(bankLogoImageProviderFront);

      bankDominantColor.then((extractedColor) {

        if (extractedColor != null) {

          dominantColor = extractedColor;

        }

      });

    }

    return dominantColor;

  }

}
