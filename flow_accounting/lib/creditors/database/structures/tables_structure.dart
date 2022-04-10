/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 6:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class CreditorsData {

  final int id;

  final String creditorsName;
  final String creditorsDescription;

  final String creditorsCompleteCredit;

  final String creditorsPaidCredit;
  final String creditorsRemainingCredit;

  final String creditorsDeadline;
  final String creditorsDeadlineText;

  int colorTag = ColorsResources.dark.value;

  CreditorsData({
    required this.id,

    required this.creditorsName,
    required this.creditorsDescription,

    required this.creditorsCompleteCredit,

    required this.creditorsPaidCredit,
    required this.creditorsRemainingCredit,

    required this.creditorsDeadline,
    required this.creditorsDeadlineText,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'creditorsName': creditorsName,
      'creditorsDescription': creditorsDescription,

      'creditorsCompleteCredit': creditorsCompleteCredit,

      'creditorsPaidCredit': creditorsPaidCredit,
      'creditorsRemainingCredit': creditorsRemainingCredit,

      'creditorsDeadline': creditorsDeadline,
      'creditorsDeadlineText': creditorsDeadlineText,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'CreditorsData{'
        'id: $id,'

        'creditorsName: $creditorsName,'
        'creditorsDescription: $creditorsDescription,'

        'creditorsCompleteCredit: $creditorsCompleteCredit,'

        'creditorsPaidCredit: $creditorsPaidCredit,'
        'creditorsRemainingCredit: $creditorsRemainingCredit,'

        'creditorsDeadline: $creditorsDeadline,'
        'creditorsDeadlineText: $creditorsDeadlineText,'

        'colorTag: $colorTag,'
        '}';
  }
}
