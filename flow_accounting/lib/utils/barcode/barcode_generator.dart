/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/27/22, 7:49 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:path_provider/path_provider.dart';

class BarcodeGenerator {

  void buildBarcode(Barcode barcode, String data, String filename,
      {double? width, double? height, double? fontHeight}) async {

    final svg = barcode.toSvg(
      data,
      width: width ?? 173,
      height: height ?? 173,
      fontHeight: fontHeight,
    );

    Directory appDocumentsDirectory = await getApplicationSupportDirectory();

    String appDocumentsPath = appDocumentsDirectory.path;

    String filePath = '$appDocumentsPath/${'$filename.svg'}';

    File(filePath).writeAsStringSync(svg);
  }

}