/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/2/22, 5:08 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class ChequesData {

  final int id;

  final String chequeMoneyAmount;

  final String chequeBankName;
  final String chequeBankBranch;

  final String chequeIssueDate;
  final String chequeDueDate;

  final String chequeSourceId;
  final String chequeSourceName;
  final String chequeSourceAccountNumber;

  final String chequeTargetId;
  final String chequeTargetName;
  final String chequeTargetAccountNumber;

  int colorTag = ColorsResources.dark.value;

  ChequesData({
    required this.id,

    required this.chequeMoneyAmount,

    required this.chequeBankName,
    required this.chequeBankBranch,

    required this.chequeIssueDate,
    required this.chequeDueDate,

    required this.chequeSourceId,
    required this.chequeSourceName,
    required this.chequeSourceAccountNumber,

    required this.chequeTargetId,
    required this.chequeTargetName,
    required this.chequeTargetAccountNumber,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'chequeMoneyAmount': chequeMoneyAmount,

      'chequeBankName': chequeBankName,
      'chequeBankBranch': chequeBankBranch,

      'chequeIssueDate': chequeIssueDate,
      'chequeDueDate': chequeDueDate,

      'chequeSourceId': chequeSourceId,
      'chequeSourceName': chequeSourceName,
      'chequeSourceAccountNumber': chequeSourceAccountNumber,

      'chequeTargetId': chequeTargetId,
      'chequeTargetName': chequeTargetName,
      'chequeTargetAccountNumber': chequeTargetAccountNumber,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'ChequesData{'
        'id: $id,'

        'chequeMoneyAmount: $chequeMoneyAmount,'

        'chequeBankName: $chequeBankName,'
        'chequeBankBranch: $chequeBankBranch,'

        'chequeIssueDate: $chequeIssueDate,'
        'chequeDueDate: $chequeDueDate,'

        'chequeSourceId: $chequeSourceId,'
        'chequeSourceName: $chequeSourceName,'
        'chequeSourceAccountNumber: $chequeSourceAccountNumber,'

        'chequeTargetId: $chequeTargetId,'
        'chequeTargetName: $chequeTargetName,'
        'chequeTargetAccountNumber: $chequeTargetAccountNumber,'

        'colorTag: $colorTag,'
        '}';
  }
}