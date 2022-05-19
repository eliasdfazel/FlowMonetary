/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/9/22, 7:58 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class DebtorsData {

  final int id;

  final String debtorsName;
  final String debtorsDescription;

  final String debtorsCompleteDebt;

  String debtorsPaidDebt;
  String debtorsRemainingDebt;

  final String debtorsDeadline;
  final String debtorsDeadlineText;

  int colorTag = ColorsResources.dark.value;

  DebtorsData({
    required this.id,

    required this.debtorsName,
    required this.debtorsDescription,

    required this.debtorsCompleteDebt,

    required this.debtorsPaidDebt,
    required this.debtorsRemainingDebt,

    required this.debtorsDeadline,
    required this.debtorsDeadlineText,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'debtorsName': debtorsName,
      'debtorsDescription': debtorsDescription,

      'debtorsCompleteDebt': debtorsCompleteDebt,

      'debtorsPaidDebt': debtorsPaidDebt,
      'debtorsRemainingDebt': debtorsRemainingDebt,

      'debtorsDeadline': debtorsDeadline,
      'debtorsDeadlineText': debtorsDeadlineText,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'DebtorsData{'
      'id: $id,'

        'debtorsName: $debtorsName,'
        'debtorsDescription: $debtorsDescription,'

        'debtorsCompleteDebt: $debtorsCompleteDebt,'

        'debtorsPaidDebt: $debtorsPaidDebt,'
        'debtorsRemainingDebt: $debtorsRemainingDebt,'

        'debtorsDeadline: $debtorsDeadline,'
        'debtorsDeadlineText: $debtorsDeadlineText,'

      'colorTag: $colorTag,'
    '}';
  }
}
