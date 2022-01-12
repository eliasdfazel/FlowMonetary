import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<Color?> imageDominantColor (ImageProvider imageProvider) async {

  final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);

  return paletteGenerator.dominantColor?.color;
}