/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fl_chart/fl_chart.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

class LineChartView extends StatefulWidget {

  List<double> listOfSpotY = [
    3,
    3,
    2,
    5,
    3.1,
    4,
    3,
    4,
    4,
    4,
    4,
    5,
  ];

  double minimumY = 0;
  double maximumY = 100;

  LineChartView({Key? key, required this.listOfSpotY, required this.minimumY, required this.maximumY}) : super(key: key);

  double minimumX = 0;
  double maximumX = 11;

  @override
  LineChartViewState createState() => LineChartViewState();
}

class LineChartViewState extends State<LineChartView> {

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.37,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 13.0, left: 13.0, top: 31, bottom: 11),
              child: LineChart(chartData()),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData chartData() {

    return LineChartData(
      minX: widget.minimumX,
      maxX: widget.maximumX,
      minY: widget.minimumY,
      maxY: widget.maximumY,
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
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: ColorsResources.light,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            decoration: TextDecoration.none,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return 'بهار';
              case 4:
                return 'تابستان';
              case 7:
                return 'پاییز';
              case 10:
                return 'زمستان';
            }
            return '';
          },
          margin: 7,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: ColorsResources.light,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            decoration: TextDecoration.none,
          ),
          getTitles: (value) {

            return prepareTitleY(widget.listOfSpotY, value.toInt());
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ColorsResources.lightTransparent.withOpacity(0.13), width: 1),
      ),
      lineTouchData: LineTouchData(
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
          tooltipBgColor:
          ColorsResources.applicationGeeksEmpire.withOpacity(0.7),
          tooltipRoundedRadius: 51,
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
      lineBarsData: [
        LineChartBarData(
          spots: prepareSpots(widget.listOfSpotY),
          curveSmoothness: 0.39,
          isCurved: true,
          shadow: Shadow(
              color: ColorsResources.light.withOpacity(0.39),
              offset: const Offset(0.0, 0.0),
              blurRadius: 13),
          colors: [
            ColorsResources.springColor.withOpacity(0.97),
            ColorsResources.summerColor.withOpacity(0.97),
            ColorsResources.autumnColor.withOpacity(0.97),
            ColorsResources.winterColor.withOpacity(0.97),
          ],
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              ColorsResources.springColor.withOpacity(0.17),
              ColorsResources.summerColor.withOpacity(0.17),
              ColorsResources.autumnColor.withOpacity(0.17),
              ColorsResources.winterColor.withOpacity(0.17),
            ],
          ),
        ),
      ],
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
      case 1: {

        titleY = listOfSpotY.reduce((current, next) => (current > next) ? current : next).toString();

        break;
      }
      case 5: {

        titleY = listOfSpotY.reduce((current, next) => (current < next) ? current : next).toString();

        break;
      }
      case 9: {

        int minimumValue = listOfSpotY.reduce((current, next) => (current > next) ? current : next).toInt();
        int maximumValue = listOfSpotY.reduce((current, next) => (current < next) ? current : next).toInt();

        titleY = ((minimumValue + maximumValue) / 2).toString();

        break;
      }
    }

    return titleY;
  }

}