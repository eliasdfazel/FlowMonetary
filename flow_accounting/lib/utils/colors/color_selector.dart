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

  Color backgroundColor = ColorsResources.dark;

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
      ColorsResources.dark,
      ColorsResources.blueGray,
      ColorsResources.blueGreen,
      ColorsResources.greenGray,
      ColorsResources.grayLight,
      ColorsResources.primaryColor,
      ColorsResources.primaryColorLight,
      ColorsResources.gameGeeksEmpire,
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
          color: widget.backgroundColor
        ),
        child: SizedBox(
          height: 99,
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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

          widget.backgroundColor = aColor;

        });

      },
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(51.0),
                    topRight: Radius.circular(51.0),
                    bottomLeft: Radius.circular(51.0),
                    bottomRight: Radius.circular(51.0)
                ),
                border: Border(
                    top: BorderSide(
                      color: ColorsResources.lightTransparent,
                      width: 3,
                    ),
                    bottom: BorderSide(
                      color: ColorsResources.lightTransparent,
                      width: 3,
                    ),
                    left: BorderSide(
                      color: ColorsResources.lightTransparent,
                      width: 3,
                    ),
                    right: BorderSide(
                      color: ColorsResources.lightTransparent,
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
