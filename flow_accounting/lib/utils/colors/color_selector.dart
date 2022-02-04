/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/24/22, 1:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class ColorSelectorView extends StatefulWidget {
  ColorSelectorView({Key? key}) : super(key: key);

  Color selectedColor = ColorsResources.white;

  ValueNotifier<Color> selectedColorNotifier = ValueNotifier(Colors.transparent);

  @override
  _ColorSelectorView createState() => _ColorSelectorView();
}
class _ColorSelectorView extends State<ColorSelectorView> {

  @override
  void initState() {

    initializeDateFormatting();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> colorItem = [];

    List<Color> listOfColors = [
      ColorsResources.primaryColor,
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.deepOrange,
      Colors.blue,
      Colors.yellowAccent,
      Colors.cyan,
      Colors.redAccent,
      Colors.lightGreenAccent,
      Colors.indigoAccent,
      Colors.red.shade700,
      Colors.green,
      Colors.deepPurple,
      Colors.greenAccent
    ];

    for (var aColor in listOfColors) {

      colorItem.add(designColorItem(aColor));

    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
      child: Container (
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomLeft: Radius.circular(17),
              bottomRight: Radius.circular(17)
          ),
          color: widget.selectedColor.withOpacity(0.9)
        ),
        child: SizedBox(
          height: 103,
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: colorItem,
          ),
        ),
      ),
    );
  }

  Widget designColorItem(Color aColor) {

    return GestureDetector(
      onTap: () {

        setState(() {

          widget.selectedColor = aColor;

        });

        Future.delayed(const Duration(milliseconds: 199), () {

          widget.selectedColorNotifier.value = (aColor);

        });

      },
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(51.0),
                    topRight: Radius.circular(51.0),
                    bottomLeft: Radius.circular(51.0),
                    bottomRight: Radius.circular(51.0)
                ),
                border: Border(
                    top: BorderSide(
                      color: ColorsResources.white.withOpacity(0.7),
                      width: 3,
                    ),
                    bottom: BorderSide(
                      color: ColorsResources.white.withOpacity(0.7),
                      width: 3,
                    ),
                    left: BorderSide(
                      color: ColorsResources.white.withOpacity(0.7),
                      width: 3,
                    ),
                    right: BorderSide(
                      color: ColorsResources.white.withOpacity(0.7),
                      width: 3,
                    )
                ),
                color: Colors.transparent,
              ),
              child: SizedBox(
                width: 71,
                height: 71,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(51.0),
                    child: ColoredBox(
                      color: aColor,
                    )
                ),
              )
          ),
        )
      ),
    );
  }

}