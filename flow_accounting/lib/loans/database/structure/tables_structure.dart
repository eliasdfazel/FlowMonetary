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

  final String loanTitle;
  final String loanDescription;

  final String loanPayer;

  final String loanDuePeriodType;

  final String loanDuePeriod;
  final String loanDuePeriodMillisecond;

  final String loanCount;

  final String loanComplete;
  final String loanPaid;
  final String loanRemaining;

  final String loansPaymentsIndexes;

  int colorTag = ColorsResources.dark.value;

  LoansData({
    required this.id,

    required this.loanTitle,
    required this.loanDescription,

    required this.loanPayer,

    required this.loanDuePeriodType,

    required this.loanDuePeriod,
    required this.loanDuePeriodMillisecond,

    required this.loanCount,

    required this.loanComplete,
    required this.loanPaid,
    required this.loanRemaining,

    required this.loansPaymentsIndexes,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'loanTitle': loanTitle,
      'loanDescription': loanDescription,

      'loanPayer': loanPayer,

      'loanDuePeriodType': loanDuePeriodType,

      'loanDuePeriod': loanDuePeriod,
      'loanDuePeriodMillisecond': loanDuePeriodMillisecond,

      'loanCount': loanCount,

      'loanComplete': loanComplete,
      'loanPaid': loanPaid,
      'loanRemaining': loanRemaining,

      'loansPaymentsIndexes': loansPaymentsIndexes,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'LoansData{'
      'id: $id,'

      'loanTitle: $loanTitle,'
      'loanDescription: $loanDescription,'

      'loanPayer: $loanPayer,'

      'loanDuePeriodType: $loanDuePeriodType,'

      'loanDuePeriod: $loanDuePeriod,'
      'loanDuePeriodMillisecond: $loanDuePeriodMillisecond,'

      'loanCount: $loanCount,'

      'loanComplete: $loanComplete,'
      'loanPaid: $loanPaid,'
      'loanRemaining: $loanRemaining,'

      'loansPaymentsIndexes: $loansPaymentsIndexes,'

      'colorTag: $colorTag,'
    '}';
  }
}
