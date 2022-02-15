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

class BudgetsData {

  final int id;

  final String budgetName;
  final String budgetDescription;

  final String budgetBalance;

  int colorTag = ColorsResources.dark.value;

  BudgetsData({
    required this.id,

    required this.budgetName,
    required this.budgetDescription,

    required this.budgetBalance,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'budgetName': budgetName,
      'budgetDescription': budgetDescription,

      'budgetBalance': budgetBalance,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'BudgetsData{'
      'id: $id,'

      'budgetName: $budgetName,'
      'budgetDescription: $budgetDescription,'

      'budgetBalance: $budgetBalance,'

      'colorTag: $colorTag,'
    '}';
  }
}
