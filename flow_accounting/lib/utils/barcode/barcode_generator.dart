/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/27/22, 5:41 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:barcode/barcode.dart';

class BarcodeGenerator {

  void buildBarcode(Barcode barcode, String data,
      {String? filename, double? width, double? height, double? fontHeight}) {

    final svg = barcode.toSvg(
      data,
      width: width ?? 173,
      height: height ?? 173,
      fontHeight: fontHeight,
    );

    filename ??= barcode.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    File('$filename.svg').writeAsStringSync(svg);
  }

}