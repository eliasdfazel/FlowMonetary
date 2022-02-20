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
            ],
          ),
        ),
      ),
    );
  }
}
