/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 3:36 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<bool> fileExist(String fileName) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/$fileName';

  File file = File(filePath);

  return file.exists();
}

Future<File> createFileOfBytes(String fileName, String fileFormat, Uint8List contentBytes) async {

  Directory appDocumentsDirectory = await getApplicationSupportDirectory();

  String appDocumentsPath = appDocumentsDirectory.path;

  String filePath = '$appDocumentsPath/${fileName}.${fileFormat}';

  return File(filePath).writeAsBytes(contentBytes);
}