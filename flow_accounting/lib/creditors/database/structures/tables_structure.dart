/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/23/22, 9:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';

class CreditorsData {

  final int id;



  int colorTag = ColorsResources.dark.value;

  CreditorsData({
    required this.id,



    required this.colorTag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,



      'colorTag': colorTag,
    };
  }

  @override
  String toString() {
    return 'CreditorsData{'
        'id: $id,'



        'colorTag: $colorTag,'
        '}';
  }
}
