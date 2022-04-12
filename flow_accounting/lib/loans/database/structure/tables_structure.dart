/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/12/22, 5:13 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class LoansData {

  final int id;

  final String loanDescription;

  final String loanIssueMonthly;
  final String loanIssueMonthlyMillisecond;

  final String loanComplete;
  final String loanPaid;
  final String loanRemaining;

  int colorTag = ColorsResources.dark.value;

  LoansData({
    required this.id,

    required this.loanDescription,

    required this.loanIssueMonthly,
    required this.loanIssueMonthlyMillisecond,

    required this.loanComplete,
    required this.loanPaid,
    required this.loanRemaining,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'loanDescription': loanDescription,

      'loanIssueMonthly': loanIssueMonthly,
      'loanIssueMonthlyMillisecond': loanIssueMonthlyMillisecond,

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

      'loanIssueMonthly: $loanIssueMonthly,'
      'loanIssueMonthlyMillisecond: $loanIssueMonthlyMillisecond,'

      'loanComplete: $loanComplete,'
      'loanPaid: $loanPaid,'
      'loanRemaining: $loanRemaining,'

      'colorTag: $colorTag,'
    '}';
  }
}
