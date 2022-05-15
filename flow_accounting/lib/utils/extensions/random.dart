/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/22/22, 6:48 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:math';

extension RandomOperation<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}