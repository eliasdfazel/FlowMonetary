/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/12/22, 5:42 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class LoansData {

  static const LoanPeriodType_Month = 1;
  static const LoanPeriodType_ThreeMonth = 2;
  static const LoanPeriodType_SixMonth = 3;
  static const LoanPeriodType_Year = 4;

  final int id;

  final String loanDescription;

  final String loanDuePeriodType;

  final String loanDuePeriod;
  final String loanDuePeriodMillisecond;

  final String loanComplete;
  final String loanPaid;
  final String loanRemaining;

  int colorTag = ColorsResources.dark.value;

  LoansData({
    required this.id,

    required this.loanDescription,

    required this.loanDuePeriodType,

    required this.loanDuePeriod,
    required this.loanDuePeriodMillisecond,

    required this.loanComplete,
    required this.loanPaid,
    required this.loanRemaining,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'loanDescription': loanDescription,

      'loanDuePeriodType': loanDuePeriodType,

      'loanDuePeriod': loanDuePeriod,
      'loanDuePeriodMillisecond': loanDuePeriodMillisecond,

      'loanComplete': loanComplete,
      'loanPaid': loanPaid,
      'loanRemaining': loanRemaining,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'LoansData{'
      'id: $id,'

      'loanDescription: $loanDescription,'

      'loanDuePeriodType: $loanDuePeriodType,'

      'loanDuePeriod: $loanDuePeriod,'
      'loanDuePeriodMillisecond: $loanDuePeriodMillisecond,'

      'loanComplete: $loanComplete,'
      'loanPaid: $loanPaid,'
      'loanRemaining: $loanRemaining,'

      'colorTag: $colorTag,'
    '}';
  }
}
