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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

DateTime pickedDateTime = DateTime.now();
String pickedDataTimeText = StringsResources.transactionTime;

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarView createState() => _CalendarView();
}
class _CalendarView extends State<CalendarView> {

  TextEditingController textControllerMoneyAmount = TextEditingController();
  TextEditingController textControllerTransactionType = TextEditingController();

  @override
  void initState() {
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
          gradient: LinearGradient(
              colors: [
                ColorsResources.white,
                ColorsResources.primaryColorLighter,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              transform: GradientRotation(45),
              tileMode: TileMode.clamp),
        ),
        child: TextButton(
            onPressed: () {
              DatePicker.showDatePicker(
                  context,
                  theme: DatePickerTheme(
                    backgroundColor: ColorsResources.lightTransparent,
                  ),
                  showTitleActions: true,
                  onChanged: (date) {

                    print('change $date');
                    pickedDateTime = date;

                  },
                  onConfirm: (date) {

                    print('confirm $date');

                    setState(() {

                      pickedDataTimeText = date.toString();

                    });

                  },
                  currentTime: DateTime.now(), locale: LocaleType.fa);
            },
            child: Text(
              pickedDataTimeText,
              style: TextStyle(color: Colors.blue),
            )
        ),
      ),
    );
  }

}
