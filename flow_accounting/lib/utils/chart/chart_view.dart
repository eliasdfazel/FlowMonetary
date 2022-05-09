/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/29/22, 9:25 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fl_chart/fl_chart.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

class LineChartView extends StatefulWidget {

  List<double> listOfSpotY = [];

  LineChartView({Key? key, required this.listOfSpotY}) : super(key: key);

  double chartMinimumX = 0;
  double chartMaximumX = 11;

  double chartMinimumY = 0;
  double chartMaximumY = 100;

  @override
  LineChartViewState createState() => LineChartViewState();
}

class LineChartViewState extends State<LineChartView> {

  final List<int> showIndexes = const [1, 4, 7, 10];

  double minimumY = 0;
  double maximumY = 1000000000000;

  @override
  void initState() {
    super.initState();

    minimumY = widget.listOfSpotY.reduce((current, next) => (current < next) ? current : next);
    maximumY = widget.listOfSpotY.reduce((current, next) => (current > next) ? current : next);

    debugPrint("Spots: ${widget.listOfSpotY}");
    debugPrint("Chart Minimum: ${minimumY} | Chart Maximum: ${maximumY}");

  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.37,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(13),
              ),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.dark,
                    ColorsResources.blueGray,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp
              ),
              boxShadow: [
                BoxShadow(
                  color: ColorsResources.lightTransparent,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 0)
                )
              ]
            ),
            child: LineChart(chartData()),
          ),
        ),
      ],
    );
  }

  LineChartData chartData() {

    var allSpots = prepareSpots(widget.listOfSpotY);

    var lineChartBarData = LineChartBarData(
      showingIndicators: showIndexes,
      show: true,
      spots: allSpots,
      curveSmoothness: 0.37,
      isCurved: true,
      shadow: Shadow(
          color: ColorsResources.light.withOpacity(0.39),
          offset: const Offset(0.0, 0.0),
          blurRadius: 13),
      gradient: LinearGradient(
        colors: [
          ColorsResources.springColor.withOpacity(0.97),
          ColorsResources.summerColor.withOpacity(0.97),
          ColorsResources.autumnColor.withOpacity(0.97),
          ColorsResources.winterColor.withOpacity(0.97),
        ]
      ),
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,

      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
            colors: [
              ColorsResources.springColor.withOpacity(0.97),
              ColorsResources.summerColor.withOpacity(0.97),
              ColorsResources.autumnColor.withOpacity(0.97),
              ColorsResources.winterColor.withOpacity(0.97),
            ]
        ),
      ),
    );

    var linesBarsData = [
      lineChartBarData,
    ];

    return LineChartData(
      minX: widget.chartMinimumX,
      maxX: widget.chartMaximumX,
      minY: widget.chartMinimumY,
      maxY: widget.listOfSpotY.reduce((current, next) => (current > next) ? current : next),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {

          return FlLine(
            color: ColorsResources.light.withOpacity(0.13),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {

          return FlLine(
            color: ColorsResources.lightTransparent.withOpacity(0.13),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTitlesWidget: (value, titleMeta)  {

            String title = "بهار";

            switch (value.toInt()) {
              case 1:

                title = 'بهار';

                break;
              case 4:

                title =  'تابستان';

                break;
              case 7:

                title = 'پاییز';

                break;
              case 10:

                title = 'زمستان';

                break;
            }

            return Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
              child: Text(
                title,
                style: TextStyle(
                  color: ColorsResources.light,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  decoration: TextDecoration.none,
                ),
              )
            );
          },
        )),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ColorsResources.lightTransparent.withOpacity(0.07), width: 1),
      ),
      showingTooltipIndicators: [
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBarData, 1, allSpots[1]),
        ]),
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBarData, 4, allSpots[4]),
        ]),
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBarData, 7, allSpots[7]),
        ]),
        ShowingTooltipIndicators([
          LineBarSpot(lineChartBarData, 10, allSpots[10]),
        ])
      ],
      lineTouchData: LineTouchData(
        enabled: true,
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {

          return spotIndexes.map((index) {

            return TouchedSpotIndicatorData(
              FlLine(
                color: ColorsResources.lightTransparent,
              ),
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 7,
                      color: ColorsResources.light.withOpacity(0.3),
                      strokeWidth: 2,
                      strokeColor: ColorsResources.light,
                    ),
              ),
            );

          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: ColorsResources.applicationGeeksEmpire,
          tooltipRoundedRadius: 51,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipPadding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
          tooltipMargin: 19,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {

            return lineBarsSpot.map((lineBarSpot) {

              return LineTooltipItem(
                lineBarSpot.y.toString(),

                const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    decoration: TextDecoration.none),
              );

            }).toList();
          },
        ),
      ),
      backgroundColor: Colors.transparent,
      lineBarsData: linesBarsData,
    );
  }

  List<FlSpot> prepareSpots(List<double?>  listOfSpotY) {

    return [
      FlSpot(0, listOfSpotY[0] ?? 0.0),
      FlSpot(1, listOfSpotY[1] ?? 0.0),
      FlSpot(2, listOfSpotY[2] ?? 0.0),
      FlSpot(3, listOfSpotY[3] ?? 0.0),
      FlSpot(4, listOfSpotY[4] ?? 0.0),
      FlSpot(5, listOfSpotY[5] ?? 0.0),
      FlSpot(6, listOfSpotY[6] ?? 0.0),
      FlSpot(7, listOfSpotY[7] ?? 0.0),
      FlSpot(8, listOfSpotY[8] ?? 0.0),
      FlSpot(9, listOfSpotY[9] ?? 0.0),
      FlSpot(10, listOfSpotY[10] ?? 0.0),
      FlSpot(11, listOfSpotY[11] ?? 0.0),
    ];
  }

  String prepareTitleY(List<double> listOfSpotY, int indexValue) {

    String titleY = '';

    switch (indexValue) {
      case 0: {

        titleY = listOfSpotY.reduce((current, next) => (current < next) ? current : next).toString();

        break;
      }
      case 5: {

        int minimumValue = listOfSpotY.reduce((current, next) => (current < next) ? current : next).toInt();
        int maximumValue = listOfSpotY.reduce((current, next) => (current > next) ? current : next).toInt();

        titleY = ((minimumValue + maximumValue) / 2).toString();

        break;
      }
      case 11: {

        titleY = listOfSpotY.reduce((current, next) => (current > next) ? current : next).toString();

        break;
      }
    }

    return titleY;
  }

}
