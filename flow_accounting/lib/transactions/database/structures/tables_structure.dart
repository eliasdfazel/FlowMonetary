/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class TransactionsData {

  static const TransactionType_Send = "-";
  static const TransactionType_Receive = "+";

  static const String TransactionBudgetName = "";

  final int id;

  final String sourceCardNumber;
  final String targetCardNumber;

  final String sourceBankName;
  final String targetBankName;

  final String sourceUsername;
  final String targetUsername;

  final String amountMoney;
  final String transactionType;
  /// Transaction Time In Millisecond
  final String transactionTime;

  int colorTag = ColorsResources.dark.value;

  final String budgetName;

  TransactionsData({
    required this.id,

    required this.sourceCardNumber,
    required this.targetCardNumber,

    required this.sourceBankName,
    required this.targetBankName,

    required this.sourceUsername,
    required this.targetUsername,

    required this.amountMoney,
    required this.transactionType,
    required this.transactionTime,

    required this.colorTag,

    required this.budgetName,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'sourceCardNumber': sourceCardNumber,
      'targetCardNumber': targetCardNumber,

      'sourceBankName': sourceBankName,
      'targetBankName': targetBankName,

      'sourceUsername': sourceUsername,
      'targetUsername': targetUsername,

      'amountMoney': amountMoney,
      'transactionType': transactionType,
      'transactionTime': transactionTime,

      'colorTag': colorTag,

      'budgetName': budgetName,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'TransactionsData{id: $id, '
        'sourceCardNumber: $sourceCardNumber, '
        'targetCardNumber: $targetCardNumber'

        'sourceBankName: $sourceBankName,'
        'targetBankName: $targetBankName,'

        'sourceUsername: $sourceUsername,'
        'targetUsername: $targetUsername,'

        'amountMoney: $amountMoney,'
        'transactionType: $transactionType,'
        'transactionTime: $transactionTime,'

        'colorTag: $colorTag,'

        'budgetName: $budgetName,'
        '}';
  }
}
