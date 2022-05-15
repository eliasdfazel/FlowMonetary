/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 3:36 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';

class Display {

  static double displayWidth(BuildContext context) {

    return  MediaQuery.of(context).size.width;
  }

  static double displayHeight(BuildContext context) {

    return MediaQuery.of(context).size.height;
  }

  static double safeAreaHeight(BuildContext context) {

    var padding = MediaQuery.of(context).padding;

    return displayHeight(context) - padding.top - padding.bottom;
  }

}