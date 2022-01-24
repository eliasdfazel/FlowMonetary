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
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarView extends StatefulWidget {
  CalendarView({Key? key}) : super(key: key);

  DateTime pickedDateTime = DateTime.now();
  String pickedDataTimeText = StringsResources.transactionTime;

  @override
  _CalendarView createState() => _CalendarView();
}
class _CalendarView extends State<CalendarView> {

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
        child: TextButton(
            onPressed: () {
              DatePicker.showDateTimePicker(
                  context,
                  theme: DatePickerTheme(
                    backgroundColor: ColorsResources.primaryColorLightest.withOpacity(0.5),
                    itemHeight: 73,
                    headerColor: Colors.transparent,
                    doneStyle: const TextStyle(
                      color: ColorsResources.applicationGeeksEmpire,
                      fontSize: 19,
                      fontFamily: 'Sans',
                    ),
                    cancelStyle: const TextStyle(
                      color: ColorsResources.darkTransparent,
                      fontSize: 19,
                      fontFamily: 'Sans',
                    ),
                    itemStyle: const TextStyle(
                      color: ColorsResources.dark,
                      fontSize: 23,
                      fontFamily: 'Sans',
                    ),
                  ),
                  showTitleActions: true,
                  onChanged: (date) {

                  },
                  onConfirm: (date) {

                    setState(() {

                      widget.pickedDataTimeText = DateFormat.yMMMMEEEEd("fa").format(date) +
                          "\n" +
                          DateFormat.Hms("fa").format(date);


                    });

                  },
                  currentTime: DateTime.now(), locale: LocaleType.fa);
            },
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                widget.pickedDataTimeText,
                style: const TextStyle(
                    color: ColorsResources.dark,
                ),
              ),
            )
        ),
      ),
    );
  }

}
