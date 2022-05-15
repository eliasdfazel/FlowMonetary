/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/21/22, 7:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/utils/calendar/ui/persian_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarView extends StatefulWidget {

  String? inputDateTime;

  bool timeNeeded = true;

  bool darkTheme = false;

  CalendarView({Key? key, this.inputDateTime, this.darkTheme = false, this.timeNeeded = true}) : super(key: key);

  DateTime pickedDateTime = DateTime.now();

  String pickedDataTimeYear = "0";
  String pickedDataTimeMonth = "0";

  @override
  _CalendarView createState() => _CalendarView();
}
class _CalendarView extends State<CalendarView> {

  String inputDateTimeUntouched = "";

  Color backgroundColor = ColorsResources.light;
  Color headerColor = ColorsResources.white;

  Color doneColor = ColorsResources.applicationGeeksEmpire;
  Color cancelColor = ColorsResources.darkTransparent;

  Color itemColor = ColorsResources.applicationDarkGeeksEmpire;

  @override
  void initState() {

    initializeDateFormatting();

    super.initState();

    if (widget.inputDateTime != null) {

      inputDateTimeUntouched = widget.inputDateTime!;

    } else {



    }

    if (widget.darkTheme) {

      backgroundColor = ColorsResources.dark;
      headerColor = ColorsResources.black;

      doneColor = ColorsResources.applicationLightGeeksEmpire;
      cancelColor = ColorsResources.lightTransparent;

      itemColor = ColorsResources.applicationGeeksEmpire;

    } else {

      backgroundColor = ColorsResources.light;
      headerColor = ColorsResources.white;

      doneColor = ColorsResources.applicationGeeksEmpire;
      cancelColor = ColorsResources.darkTransparent;

      itemColor = ColorsResources.applicationDarkGeeksEmpire;

    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(1.1, 3, 1.1, 3),
      child: Container (
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomLeft: Radius.circular(17),
              bottomRight: Radius.circular(17)
          ),
          color: ColorsResources.lightTransparent
        ),
        child: TextButton(
            onPressed: () {

              /* Start - Date Picker */
              DatePicker.showPicker(
                context,
                theme: DatePickerTheme(
                  itemHeight: 73,
                  backgroundColor: backgroundColor,
                  headerColor: headerColor,
                  doneStyle: TextStyle(
                    color: doneColor,
                    fontSize: 19,
                    fontFamily: 'Sans',
                    fontWeight: FontWeight.bold
                  ),
                  cancelStyle: TextStyle(
                    color: cancelColor,
                    fontSize: 19,
                    fontFamily: 'Sans',
                  ),
                  itemStyle: TextStyle(
                    color: itemColor,
                    fontSize: 23,
                    fontFamily: 'Sans',
                  ),
                ),
                showTitleActions: true,
                onChanged: (changedDate) {

                  Gregorian gregorianCalendar = Gregorian(changedDate.year, changedDate.month, changedDate.day, changedDate.hour, changedDate.minute, 0, 0);
                  var iranianCalendar = gregorianCalendar.toJalali();

                  debugPrint("Picked Date Time: ${iranianCalendar}");

                },
                onConfirm: (changedDate) {

                  widget.pickedDateTime = changedDate;

                  Gregorian gregorianCalendar = Gregorian(changedDate.year, changedDate.month, changedDate.day, changedDate.hour, changedDate.minute, 0, 0);
                  var iranianCalendar = gregorianCalendar.toJalali();

                  String yearNumber = iranianCalendar.formatter.yyyy.toString();
                  String dayNumber = iranianCalendar.formatter.dd.toString();

                  String weekdayName = iranianCalendar.formatter.wN.toString();
                  String monthName = iranianCalendar.formatter.mN.toString();

                  widget.pickedDataTimeYear = yearNumber;
                  widget.pickedDataTimeMonth = iranianCalendar.formatter.mm;

                  if (widget.timeNeeded) {

                    /* Start - Time Picker */
                    DatePicker.showTimePicker(
                      context,
                      theme: DatePickerTheme(
                        itemHeight: 73,
                        backgroundColor: backgroundColor,
                        headerColor: headerColor,
                        doneStyle: TextStyle(
                            color: doneColor,
                            fontSize: 19,
                            fontFamily: 'Sans',
                            fontWeight: FontWeight.bold
                        ),
                        cancelStyle: TextStyle(
                          color: cancelColor,
                          fontSize: 19,
                          fontFamily: 'Sans',
                        ),
                        itemStyle: TextStyle(
                          color: itemColor,
                          fontSize: 23,
                          fontFamily: 'Sans',
                        ),
                      ),
                      showTitleActions: true,
                      onConfirm: (changedTime) {

                        setState(() {

                          widget.inputDateTime = "" +
                              weekdayName + " " +
                              dayNumber + " " +
                              monthName + " " +
                              yearNumber +
                              "\n" +
                              "ساعت" + " " +
                              "${changedTime.hour}:${changedTime.minute}";

                        });

                      },
                      onCancel: () {

                      },
                      locale: LocaleType.fa,
                    );
                    /* End - Time Picker */

                  } else {

                    setState(() {

                      widget.inputDateTime = "" +
                          weekdayName + " " +
                          dayNumber + " " +
                          monthName + " " +
                          yearNumber +
                          "\n" +
                          "ساعت" + " " +
                          "${widget.pickedDateTime.hour}:${widget.pickedDateTime.minute}";

                    });

                  }

                },
                pickerModel: PersianDatePicker(date: widget.pickedDateTime, locale: LocaleType.fa),
                locale: LocaleType.fa,
              );
              /* End - Date Picker */

            },
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "${widget.inputDateTime}",
                  style: const TextStyle(
                    color: ColorsResources.dark,
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

}