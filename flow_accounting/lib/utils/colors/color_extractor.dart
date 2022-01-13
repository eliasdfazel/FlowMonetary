/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color?> imageDominantColor (ImageProvider imageProvider) async {

  final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);

  return paletteGenerator.dominantColor?.color;
}