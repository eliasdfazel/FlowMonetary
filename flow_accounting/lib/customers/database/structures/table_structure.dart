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

class CustomersData {

  final int id;

  final String customerName;
  final String customerDescription;

  int colorTag = ColorsResources.dark.value;

  CustomersData({
    required this.id,

    required this.customerName,
    required this.customerDescription,

    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'budgetName': customerName,
      'budgetDescription': customerDescription,

      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'BudgetsData{'
        'id: $id,'

        'budgetName: $customerName,'
        'budgetDescription: $customerDescription,'

        'colorTag: $colorTag,'
        '}';
  }
}