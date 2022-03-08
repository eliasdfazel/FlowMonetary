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

  static const TransactionType_Send = "-";
  static const TransactionType_Receive = "+";

  static const ChequesConfirmation_Done = "DONE";
  static const ChequesConfirmation_NOT = "NOT";

  static const String TransactionBudgetName = "Unknown";

  final int id;

  final String chequeTitle;
  final String chequeDescription;

  final String chequeNumber;

  final String chequeMoneyAmount;

  final String chequeTransactionType;

  final String chequeSourceBankName;
  final String chequeSourceBankBranch;

  final String chequeTargetBankName;

  final String chequeIssueDate;
  final String chequeDueDate;

  final String chequeIssueMillisecond;
  final String chequeDueMillisecond;

  final String chequeSourceId;
  final String chequeSourceName;
  final String chequeSourceAccountNumber;

  final String chequeTargetId;
  final String chequeTargetName;
  final String chequeTargetAccountNumber;

  final String chequeDoneConfirmation;

  final String chequeRelevantCreditCard;
  final String chequeRelevantBudget;

  int colorTag = ColorsResources.dark.value;

  ChequesData({
    required this.id,

    required this.chequeTitle,
    required this.chequeDescription,

    required this.chequeNumber,

    required this.chequeMoneyAmount,

    required this.chequeTransactionType,

    required this.chequeSourceBankName,
    required this.chequeSourceBankBranch,

    required this.chequeTargetBankName,

    required this.chequeIssueDate,
    required this.chequeDueDate,

    required this.chequeIssueMillisecond,
    required this.chequeDueMillisecond,

    required this.chequeSourceId,
    required this.chequeSourceName,
    required this.chequeSourceAccountNumber,

    required this.chequeTargetId,
    required this.chequeTargetName,
    required this.chequeTargetAccountNumber,

    required this.chequeDoneConfirmation,

    required this.chequeRelevantCreditCard,
    required this.chequeRelevantBudget,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'chequeTitle': chequeTitle,
      'chequeDescription': chequeDescription,

      'chequeNumber': chequeNumber,

      'chequeMoneyAmount': chequeMoneyAmount,

      'chequeTransactionType': chequeTransactionType,

      'chequeSourceBankName': chequeSourceBankName,
      'chequeSourceBankBranch': chequeSourceBankBranch,

      'chequeTargetBankName': chequeTargetBankName,

      'chequeIssueDate': chequeIssueDate,
      'chequeDueDate': chequeDueDate,

      'chequeIssueMillisecond': chequeIssueMillisecond,
      'chequeDueMillisecond': chequeDueMillisecond,

      'chequeSourceId': chequeSourceId,
      'chequeSourceName': chequeSourceName,
      'chequeSourceAccountNumber': chequeSourceAccountNumber,

      'chequeTargetId': chequeTargetId,
      'chequeTargetName': chequeTargetName,
      'chequeTargetAccountNumber': chequeTargetAccountNumber,

      'chequeDoneConfirmation': chequeDoneConfirmation,

      'chequeRelevantCreditCard': chequeRelevantCreditCard,
      'chequeRelevantBudget': chequeRelevantBudget,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'ChequesData{'
        'id: $id,'

        'chequeTitle: $chequeTitle,'
        'chequeDescription: $chequeDescription,'

        'chequeNumber: $chequeNumber,'

        'chequeMoneyAmount: $chequeMoneyAmount,'

        'chequeTransactionType: $chequeTransactionType,'

        'chequeSourceBankName: $chequeSourceBankName,'
        'chequeSourceBankBranch: $chequeSourceBankBranch,'

        'chequeTargetBankName: $chequeTargetBankName,'

        'chequeIssueDate: $chequeIssueDate,'
        'chequeDueDate: $chequeDueDate,'

        'chequeIssueMillisecond: $chequeIssueMillisecond,'
        'chequeDueMillisecond: $chequeDueMillisecond,'

        'chequeSourceId: $chequeSourceId,'
        'chequeSourceName: $chequeSourceName,'
        'chequeSourceAccountNumber: $chequeSourceAccountNumber,'

        'chequeTargetId: $chequeTargetId,'
        'chequeTargetName: $chequeTargetName,'
        'chequeTargetAccountNumber: $chequeTargetAccountNumber,'

        'chequeDoneConfirmation: $chequeDoneConfirmation,'

        'chequeRelevantCreditCard: $chequeRelevantCreditCard,'
        'chequeRelevantBudget: $chequeRelevantBudget,'

        'colorTag: $colorTag,'
        '}';
  }
}