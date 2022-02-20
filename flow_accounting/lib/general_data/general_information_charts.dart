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
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
      70,
      30,
      20,
      50,
      35.1,
      40,
      30,
      19,
      29,
      41,
      80,
      18,
    ];
    double minimumEarning = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    double maximumEarning = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    LineChartView generalEarningChart = LineChartView(listOfSpotY: listOfEarningPoint, minimumY: minimumEarning, maximumY: maximumEarning);

    List<double> listOfSpendingPoint = [
      30,
      30,
      20,
      50,
      35.1,
      40,
      30,
      49,
      49,
      41,
      40,
      18,
    ];
    double minimumSpending = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    double maximumSpending = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    LineChartView generalSpendingChart = LineChartView(listOfSpotY: listOfSpendingPoint, minimumY: minimumSpending, maximumY: maximumSpending);

    List<double> listOfBalancePoint = [
      10,
      30,
      20,
      50,
      65.1,
      40,
      20,
      49,
      90,
      41,
      10,
      58,
    ];
    double minimumBalance = listOfEarningPoint.reduce((current, next) => (current > next) ? current : next);
    double maximumBalance = listOfEarningPoint.reduce((current, next) => (current < next) ? current : next);
    LineChartView generalBalanceChart = LineChartView(listOfSpotY: listOfBalancePoint, minimumY: minimumBalance, maximumY: maximumBalance);

    return SafeArea(
      child: MaterialApp(
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
                        ColorsResources.grayLight,
                        ColorsResources.greenGrayLight,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      transform: GradientRotation(45),
                      tileMode: TileMode.clamp),
                ),
              ),
              // Wave
              SizedBox(
                width: double.infinity,
                height: 179,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17.0),
                    child: WaveWidget(
                      config: CustomConfig(
                        colors: [
                          ColorsResources.greenGrayLight,
                          ColorsResources.blueGreen,
                          ColorsResources.black,
                        ],
                        heightPercentages: [0.13, 0.57, 0.79],
                        durations: [13000, 21000, 19000],
                        blur: const MaskFilter.blur(BlurStyle.normal, 3.1),
                      ),
                      backgroundColor: Colors.transparent,
                      size: const Size(double.infinity, 300),
                      waveAmplitude: 7,
                      duration: 1000,
                      isLoop: true,
                    ),
                  ),
                ),
              ),
              // Wave Line
              SizedBox(
                width: double.infinity,
                height: 179,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17.0),
                    child: WaveWidget(
                      config: CustomConfig(
                        colors: [
                          ColorsResources.primaryColorLighter,
                          ColorsResources.primaryColorLight,
                          ColorsResources.primaryColorLight,
                        ],
                        heightPercentages: [0.13, 0.57, 0.79],
                        durations: [13000, 21000, 19000],
                        blur: const MaskFilter.blur(BlurStyle.outer, 3.7),
                      ),
                      backgroundColor: Colors.transparent,
                      size: const Size(double.infinity, 300),
                      waveAmplitude: 7,
                      duration: 1000,
                      isLoop: true,
                    ),
                  ),
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
                  generalEarningChart,
                  generalSpendingChart,
                  generalBalanceChart
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                ColorsResources.white.withOpacity(0.3),
                                                ColorsResources.primaryColorLighter.withOpacity(0.3),
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                ColorsResources.white.withOpacity(0.3),
                                                ColorsResources.primaryColorLighter.withOpacity(0.3),
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
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 43,
                                width: 43,
                                child: Blur(
                                  blur: 3,
                                  borderRadius: BorderRadius.circular(51),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              ColorsResources.white.withOpacity(0.3),
                                              ColorsResources.primaryColorLighter.withOpacity(0.3),
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
                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {



                                  },
                                  child: const Icon(
                                      Icons.refresh_rounded,
                                      size: 31.0,
                                      color: ColorsResources.primaryColorDark
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }



}