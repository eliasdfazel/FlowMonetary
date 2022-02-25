/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/20/22, 4:28 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
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

    // Get All Transactions by Month & by Transaction Type
    // Sum Up Transaction Type Receive
    // Create 12 ASYNC Functions for Each Month

    List<double> listOfEarningPoint = [
      7000,
      300000000,
      2000000000,
      1000000,
      99500000.1,
      40000,
      3000,
      1900000,
      2900,
      400000,
      8000000,
      180000,
    ];
    double minimumEarning = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumEarning = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalEarningChart = LineChartView(listOfSpotY: listOfEarningPoint, minimumY: minimumEarning, maximumY: maximumEarning);

    List<double> listOfSpendingPoint = [
      3000,
      30,
      2000000,
      500,
      3500.1,
      40000,
      3000,
      4900,
      49000,
      4100,
      4000000,
      180000,
    ];
    double minimumSpending = listOfSpendingPoint.reduce((current, next) => (current < next) ? current : next);
    double maximumSpending = listOfSpendingPoint.reduce((current, next) => (current > next) ? current : next);
    LineChartView generalSpendingChart = LineChartView(listOfSpotY: listOfSpendingPoint, minimumY: minimumSpending, maximumY: maximumSpending);

    List<double> listOfBalancePoint = [
      100770,
      311000,
      200000,
      500000,
      650000.1,
      400007,
      405009,
      400509,
      90000,
      410000,
      100077,
      880000,
    ];
    double minimumBalance = listOfBalancePoint.reduce((current, next) => (current < next) ? current : next);
    double maximumBalance = listOfBalancePoint.reduce((current, next) => (current > next) ? current : next);
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
                right: 13,
                child: SizedBox(
                  height: 43,
                  width: 321,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 11,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 43,
                                width: double.infinity,
                                child: Blur(
                                  blur: 5,
                                  borderRadius: BorderRadius.circular(51),
                                  blurColor: Colors.black.withOpacity(0.3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              ColorsResources.black.withOpacity(0.3),
                                              ColorsResources.primaryColorDark.withOpacity(0.3),
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: const [0.0, 1.0],
                                            transform: const GradientRotation(45),
                                            tileMode: TileMode.clamp
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {



                                },
                                child: const SizedBox(
                                  height: 43,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      StringsResources.sortTransactionAmountHigh,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: ColorsResources.applicationGeeksEmpire,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 11,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 43,
                                width: double.infinity,
                                child: Blur(
                                  blur: 5,
                                  borderRadius: BorderRadius.circular(51),
                                  blurColor: Colors.black.withOpacity(0.3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              ColorsResources.black.withOpacity(0.3),
                                              ColorsResources.primaryColorDark.withOpacity(0.3),
                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: const [0.0, 1.0],
                                            transform: const GradientRotation(45),
                                            tileMode: TileMode.clamp
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {



                                },
                                child: const SizedBox(
                                  height: 43,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      StringsResources.sortTimeNew,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: ColorsResources.applicationGeeksEmpire,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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

  void getTransactionOne() async {



  }

}