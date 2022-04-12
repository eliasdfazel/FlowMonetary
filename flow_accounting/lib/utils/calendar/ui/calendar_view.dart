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
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarView extends StatefulWidget {

  String? pickedDataTimeText;

  CalendarView({Key? key, this.pickedDataTimeText}) : super(key: key);

  String? inputDateTime;

  DateTime pickedDateTime = DateTime.now();

  String pickedDataTimeYear = "0";
  String pickedDataTimeMonth = "0";

  @override
  _CalendarView createState() => _CalendarView();
}
class _CalendarView extends State<CalendarView> {

  @override
  void initState() {

    initializeDateFormatting();

    super.initState();

    if (widget.inputDateTime != null) {

      widget.pickedDataTimeText = widget.inputDateTime!;

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
                  backgroundColor: ColorsResources.light,
                  headerColor: ColorsResources.white,
                  doneStyle: const TextStyle(
                    color: ColorsResources.applicationGeeksEmpire,
                    fontSize: 19,
                    fontFamily: 'Sans',
                    fontWeight: FontWeight.bold
                  ),
                  cancelStyle: const TextStyle(
                    color: ColorsResources.darkTransparent,
                    fontSize: 19,
                    fontFamily: 'Sans',
                  ),
                  itemStyle: const TextStyle(
                    color: ColorsResources.applicationDarkGeeksEmpire,
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

                  /* Start - Time Picker */
                  DatePicker.showTimePicker(
                    context,
                    theme: DatePickerTheme(
                      itemHeight: 73,
                      backgroundColor: ColorsResources.light,
                      headerColor: ColorsResources.white,
                      doneStyle: const TextStyle(
                        color: ColorsResources.applicationGeeksEmpire,
                        fontSize: 19,
                        fontFamily: 'Sans',
                        fontWeight: FontWeight.bold
                      ),
                      cancelStyle: const TextStyle(
                        color: ColorsResources.darkTransparent,
                        fontSize: 19,
                        fontFamily: 'Sans',
                      ),
                      itemStyle: const TextStyle(
                          color: ColorsResources.applicationDarkGeeksEmpire,
                          fontSize: 23,
                          fontFamily: 'Sans',
                      ),
                    ),
                    showTitleActions: true,
                    onConfirm: (changedTime) {

                      setState(() {

                        widget.pickedDataTimeText = "" +
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

                      setState(() {

                        widget.pickedDataTimeText = "" +
                            weekdayName + " " +
                            dayNumber + " " +
                            monthName + " " +
                            yearNumber +
                            "\n" +
                            "ساعت" + " " +
                            "${iranianCalendar.hour}:${iranianCalendar.minute}";

                      });

                    },
                    locale: LocaleType.fa,
                  );
                  /* End - Time Picker */

                },
                pickerModel: CustomDatePicker(date: widget.pickedDateTime, locale: LocaleType.fa),
                locale: LocaleType.fa,
              );
              /* End - Date Picker */

            },
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "${widget.pickedDataTimeText}",
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

class CustomDatePicker extends CommonPickerModel {

  CustomDatePicker({required DateTime date, required LocaleType locale}) : super(locale: locale) {

    this.currentTime = date;

    this.setLeftIndex(this.currentTime.year);

    this.setMiddleIndex(this.currentTime.month);

    this.setRightIndex(this.currentTime.day);

  }

  @override
  String? leftStringAtIndex(int year) {//YEAR

    Gregorian gregorianCalendar = Gregorian(year, currentMiddleIndex(), currentRightIndex());
    var iranianCalendar = gregorianCalendar.toJalali();

    return iranianCalendar.formatter.yyyy;
  }

  @override
  String? middleStringAtIndex(int month) {//Month

    Gregorian gregorianCalendar = Gregorian(currentLeftIndex(), month, currentRightIndex());
    var iranianCalendar = gregorianCalendar.toJalali();

    return iranianCalendar.formatter.mN;
  }

  @override
  String? rightStringAtIndex(int day) {//Day

    Gregorian gregorianCalendar = Gregorian(currentLeftIndex(), currentMiddleIndex(), day);
    var iranianCalendar = gregorianCalendar.toJalali();

    return iranianCalendar.formatter.dd;
  }

  @override
  String leftDivider() {

    return "/";
  }

  @override
  String rightDivider() {

    return "/";
  }

  @override
  List<int> layoutProportions() {

    return [7, 5, 3];
  }

  @override
  DateTime finalTime() {

    return DateTime(
        this.currentLeftIndex(),
        this.currentMiddleIndex(),
        this.currentRightIndex(),
        this.currentTime.hour,
        this.currentTime.minute
    );
  }

}