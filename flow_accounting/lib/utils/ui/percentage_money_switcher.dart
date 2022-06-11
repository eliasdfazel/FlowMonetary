/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 5/15/22, 7:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

class PercentageMoneySwitcher extends StatefulWidget {

  bool percentageEnable = true;

  PercentageMoneySwitcher({Key? key, this.percentageEnable = true}) : super(key: key);

  @override
  _PercentageMoneySwitcherState createState() => _PercentageMoneySwitcherState();
}
class _PercentageMoneySwitcherState extends State<PercentageMoneySwitcher> {


  Color percentageColor = ColorsResources.dark;
  Color moneyColor = ColorsResources.dark;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if (widget.percentageEnable) {

      percentageColor = ColorsResources.applicationLightGeeksEmpire;
      moneyColor = ColorsResources.dark;

    } else {

      percentageColor = ColorsResources.dark;
      moneyColor = ColorsResources.applicationLightGeeksEmpire;

    }

    return Container(
      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {

                widget.percentageEnable = true;

                setState(() {});

              },
              child: Text(
                "%",
                style: TextStyle(
                  fontSize: 17,
                  color: percentageColor
                ),
              )
          ),
          InkWell(
            onTap: () {

              widget.percentageEnable = false;

              setState(() {});

            },
            child: Text(
              "\$",
              style: TextStyle(
                  fontSize: 17,
                  color: moneyColor
              ),
            ),
          ),
        ],
      )
    );
  }


}