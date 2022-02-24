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
      700000,
      300000000,
      200,
      500000000000,
      350000.1,
      4000000000,
      30000000000000000,
      1900000,
      290000,
      40001,
      80000,
      1800000,
    ];
    double minimumEarning = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumEarning = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalEarningChart = LineChartView(listOfSpotY: listOfEarningPoint, minimumY: minimumEarning, maximumY: maximumEarning);

    List<double> listOfSpendingPoint = [
      300000,
      3000000000,
      20000,
      500,
      3500.1,
      400,
      3000000,
      490,
      49000,
      410,
      4000,
      180,
    ];
    double minimumSpending = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumSpending = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalSpendingChart = LineChartView(listOfSpotY: listOfSpendingPoint, minimumY: minimumSpending, maximumY: maximumSpending);

    List<double> listOfBalancePoint = [
      1000,
      3000,
      200,
      50000000,
      6500.1,
      400,
      200,
      490000000,
      900,
      410,
      100,
      8800000,
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
            // Gradient Background
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
            // Rounded Borders
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17)),
                  border: Border(
                      top: BorderSide(
                        color: Colors.black,
                        width: 7,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 7,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 7,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 7,
                      )),
                  color: Colors.transparent),
            ),
            // All Contents
            Padding(
              padding: const EdgeInsets.fromLTRB(
                /*left*/
                  1.1,
                  /*top*/ 3,
                  /*right*/ 1.1,
                  /*bottom*/ 7.3),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17)),
                ),
              ),
            ),
            ListView(
              padding: const EdgeInsets.fromLTRB(0, 73, 0, 79),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 3, 27, 3),
                  child: generalEarningChart,
                ),
                const Divider(
                  height: 19,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 3, 27, 3),
                  child: generalSpendingChart,
                ),
                const Divider(
                  height: 19,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 3, 27, 3),
                  child: generalBalanceChart
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