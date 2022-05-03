/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 5/3/22, 3:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';

class PersianDatePicker extends CommonPickerModel {

  PersianDatePicker({required DateTime date, required LocaleType locale}) : super(locale: locale) {

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

    String numberOfDay = "1";

    try {

      Gregorian gregorianCalendar = Gregorian(currentLeftIndex(), currentMiddleIndex(), day.abs());
      Jalali iranianCalendar = gregorianCalendar.toJalali();

      numberOfDay = iranianCalendar.formatter.dd;

    } on Exception {}

    return numberOfDay;
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