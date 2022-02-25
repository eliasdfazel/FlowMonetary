/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/20/22, 4:28 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/chart/chart_view.dart';
import 'package:flutter/material.dart';

class GeneralFinancialCharts extends StatefulWidget {
  const GeneralFinancialCharts({Key? key}) : super(key: key);

  @override
  _GeneralFinancialChartsState createState() => _GeneralFinancialChartsState();
}

class _GeneralFinancialChartsState extends State<GeneralFinancialCharts> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Convert Monthly Money Amount to be Between

    List<double> listOfEarningPoint = [
      700000000,
      3000000,
      200,
      500000,
      3500.1,
      40000,
      3000,
      1900,
      29000,
      400,
      80,
      180,
    ];
    double minimumEarning = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumEarning = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalEarningChart = LineChartView(listOfSpotY: listOfEarningPoint, minimumY: minimumEarning, maximumY: maximumEarning);

    List<double> listOfSpendingPoint = [
      3000,
      300,
      200000,
      50000,
      350.1,
      400,
      3000,
      490,
      4900,
      4100000,
      4000,
      180,
    ];
    double minimumSpending = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumSpending = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalSpendingChart = LineChartView(listOfSpotY: listOfSpendingPoint, minimumY: minimumSpending, maximumY: maximumSpending);

    List<double> listOfBalancePoint = [
      10,
      3000,
      200,
      500,
      650.1,
      40000,
      200,
      490,
      900,
      41,
      10000,
      88,
    ];
    double minimumBalance = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumBalance = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalBalanceChart = LineChartView(listOfSpotY: listOfBalancePoint, minimumY: minimumBalance, maximumY: maximumBalance);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsResources.applicationName,
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Sans',
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ColorsResources.primaryColorLight),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: Scaffold(
        backgroundColor: ColorsResources.black,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)),
                gradient: LinearGradient(
                    colors: [
                      ColorsResources.dark,
                      ColorsResources.black,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    transform: GradientRotation(45),
                    tileMode: TileMode.clamp),
              ),
            ),
            ListView(
              padding: const EdgeInsets.fromLTRB(0, 53, 0, 79),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 3, 27, 7),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 7),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            StringsResources.totalEarningText,
                            style: TextStyle(
                              color: ColorsResources.light,
                              fontSize: 17,
                              shadows: [
                                Shadow(
                                  color: ColorsResources.primaryColorDark,
                                  blurRadius: 7,
                                  offset: Offset(1.0, 1.0)
                                ),
                                Shadow(
                                    color: ColorsResources.lightTransparent,
                                    blurRadius: 7,
                                    offset: Offset(-1.0, -1.0)
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                      generalEarningChart
                    ],
                  ),
                ),
                const Divider(
                  height: 19,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 13, 27, 7),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 7),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            StringsResources.totalSpendingText,
                            style: TextStyle(
                                color: ColorsResources.light,
                                fontSize: 17,
                                shadows: [
                                  Shadow(
                                      color: ColorsResources.primaryColorDark,
                                      blurRadius: 7,
                                      offset: Offset(1.0, 1.0)
                                  ),
                                  Shadow(
                                      color: ColorsResources.lightTransparent,
                                      blurRadius: 7,
                                      offset: Offset(-1.0, -1.0)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      generalSpendingChart
                    ],
                  ),
                ),
                const Divider(
                  height: 19,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 13, 27, 7),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 7),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            StringsResources.totalBalanceText,
                            style: TextStyle(
                                color: ColorsResources.light,
                                fontSize: 17,
                                shadows: [
                                  Shadow(
                                      color: ColorsResources.primaryColorDark,
                                      blurRadius: 7,
                                      offset: Offset(1.0, 1.0)
                                  ),
                                  Shadow(
                                      color: ColorsResources.lightTransparent,
                                      blurRadius: 7,
                                      offset: Offset(-1.0, -1.0)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      generalBalanceChart
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                top: 19,
                left: 13,
                child: InkWell(
                  onTap: () {

                    Navigator.pop(context);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: ColorsResources.blueGrayLight.withOpacity(0.7),
                              blurRadius: 7,
                              spreadRadius: 0.1,
                              offset: const Offset(0.0, 3.7)
                          )
                        ]
                    ),
                    child: const Image(
                      image: AssetImage("go_previous_icon.png"),
                      fit: BoxFit.scaleDown,
                      width: 41,
                      height: 41,
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

}