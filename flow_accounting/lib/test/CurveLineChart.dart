/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/20/22, 3:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:fl_chart/fl_chart.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: LineChartSample2()));
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.57,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                  mainData()
              ),
            ),
          ),
        ),
      ],
    ));
  }

  LineChartData mainData() {

    return LineChartData(
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
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12,
              decoration: TextDecoration.none
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
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
            decoration: TextDecoration.none
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff0000), width: 1)
      ),
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {

          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                color: Colors.pink,
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
          tooltipBgColor: Colors.black,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toString(),
                const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              );
            }).toList();
          },
        ),
      ),
      backgroundColor: Colors.transparent,
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [//12 Months
            FlSpot(0, 3),
            FlSpot(1, 3),
            FlSpot(2, 2),
            FlSpot(3, 5),
            FlSpot(4, 3.1),
            FlSpot(5, 4),
            FlSpot(6, 3),
            FlSpot(7, 4),
            FlSpot(8, 4),
            FlSpot(9, 4),
            FlSpot(10, 4),
            FlSpot(11, 5),
          ],
          curveSmoothness: 0.39,
          isCurved: true,
          shadow: Shadow(
            color: ColorsResources.light.withOpacity(0.39),
            offset: const Offset(0.0, 0.0),
            blurRadius: 13
          ),
          colors: [
            const Color(0xffe623b8).withOpacity(0.9),
            const Color(0xff23e62d).withOpacity(0.9),
            const Color(0xffbce623).withOpacity(0.9),
            const Color(0xff23b6e6).withOpacity(0.9),
          ],
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              const Color(0xffe623b8).withOpacity(0.17),
              const Color(0xff23e62d).withOpacity(0.17),
              const Color(0xffbce623).withOpacity(0.17),
              const Color(0xff23b6e6).withOpacity(0.17),
            ],
          ),
        ),
      ],
    );
  }
}
