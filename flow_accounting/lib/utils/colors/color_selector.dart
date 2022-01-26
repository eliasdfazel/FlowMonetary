/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/22, 1:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class ColorSelectorView extends StatefulWidget {
  ColorSelectorView({Key? key}) : super(key: key);

  DateTime pickedDateTime = DateTime.now();
  String pickedDataTimeText = StringsResources.transactionTime;

  @override
  _ColorSelectorView createState() => _ColorSelectorView();
}
class _ColorSelectorView extends State<ColorSelectorView> {

  TextEditingController textControllerMoneyAmount = TextEditingController();
  TextEditingController textControllerTransactionType = TextEditingController();

  @override
  void initState() {

    initializeDateFormatting();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
      child: Container (
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
          color: ColorsResources.lightTransparent
        ),
        child: SizedBox(
          height: 99,
          width: double.infinity,
        ),
      ),
    );
  }

}
