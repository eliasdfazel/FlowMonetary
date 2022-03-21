/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/21/22, 6:28 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/chart/chart_view.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sqflite/sqflite.dart';

class GeneralFinancialCharts extends StatefulWidget {
  const GeneralFinancialCharts({Key? key}) : super(key: key);

  @override
  _GeneralFinancialChartsState createState() => _GeneralFinancialChartsState();
}
class _GeneralFinancialChartsState extends State<GeneralFinancialCharts> {

  ListView yearsListView = ListView();

  List<Widget> allYearsItems = [];

  Widget totalEarningPlaceholder = const Divider(height: 1);
  List<double> listOfEarningPoint = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  Widget totalSpendingPlaceholder = const Divider(height: 1);
  List<double> listOfSpendingPoint = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  Widget totalBalancePlaceholder = const Divider(height: 1);
  List<double> listOfBalancePoint = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {

    yearListItem();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsResources.applicationName(),
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
              padding: const EdgeInsets.fromLTRB(0, 71, 0, 79),
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(27, 3, 27, 7),
                  child: Column(
                    children: [
                      Padding(
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
                      totalEarningPlaceholder,
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
                      Padding(
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
                      totalSpendingPlaceholder
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
                      Padding(
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
                      totalBalancePlaceholder
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
                  width: 179,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
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
                        yearsListView,
                      ],
                    ),
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

  void yearListItem() async {

    DateTime nowTime = DateTime.now();
    Gregorian gregorianCalendar = Gregorian(nowTime.year, nowTime.month, nowTime.day, nowTime.hour, nowTime.minute, 0, 0);
    var iranianCalendar = gregorianCalendar.toJalali();

    int yearNumber = int.parse(iranianCalendar.formatter.yyyy);

    List<int> inputIntList = [];
    inputIntList.addAll(List.generate(13, (i) => (yearNumber - 1) - i));
    inputIntList.addAll(List.generate(13, (i) => yearNumber + i));
    inputIntList.sort();

    ScrollController scrollController = ScrollController(initialScrollOffset: (43 * 13));

    yearsListView = ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        physics: const BouncingScrollPhysics(),
        itemCount: inputIntList.length,
        controller: scrollController,
        itemBuilder: (context, index) {

          String itemData = inputIntList[index].toString();

          return ClipRRect(
            borderRadius: BorderRadius.circular(51),
            child: Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              child: InkWell(
                  splashColor:
                      ColorsResources.applicationGeeksEmpire.withOpacity(0.3),
                  splashFactory: InkRipple.splashFactory,
                  onTap: () {
                    debugPrint("Selected Year: ${index}. $itemData");

                    getTransactionsReceiveSum(int.parse(itemData));

                  },
                  child: SizedBox(
                      height: 43,
                      width: 179,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          itemData,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: ColorsResources.light,
                              fontSize: 13,
                              letterSpacing: 1.7,
                              shadows: [
                                Shadow(
                                    color: ColorsResources.white,
                                    blurRadius: 13,
                                    offset: Offset(0, 0))
                              ]),
                        ),
                      ))),
            ),
          );
        });

    setState(() {

      yearsListView;

    });

    getTransactionsReceiveSum(yearNumber);

  }

  void getTransactionsReceiveSum(int selectedYear) async {

    String databaseDirectory = await getDatabasesPath();

    String transactionDatabasePath = "${databaseDirectory}/${TransactionsDatabaseInputs.transactionsDatabase}";

    bool transactionDatabaseExist = await databaseExists(transactionDatabasePath);

    if (transactionDatabaseExist) {

      TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

      double monthSumOne = 0;
      var monthOne = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 1, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthOne) {

        monthSumOne += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("1: $monthSumOne");

      double monthSumTwo = 0;
      var monthTwo = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 2, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthTwo) {

        monthSumTwo += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("2: $monthSumTwo");

      double monthSumThree = 0;
      var monthThree = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 3, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthThree) {

        monthSumThree += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("3: $monthSumThree");

      double monthSumFour = 0;
      var monthFour = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 4, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthFour) {

        monthSumFour += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("4: $monthSumFour");

      double monthSumFive = 0;
      var monthFive = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 5, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthFive) {

        monthSumFive += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("5: $monthSumFive");

      double monthSumSix = 0;
      var monthSix = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 6, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthSix) {

        monthSumSix += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("6: $monthSumSix");

      double monthSumSeven = 0;
      var monthSeven = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 7, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthSeven) {

        monthSumSeven += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("7: $monthSumSeven");

      double monthSumEight = 0;
      var monthEight = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 8, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthEight) {

        monthSumEight += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("8: $monthSumEight");

      double monthSumNine = 0;
      var monthNine = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 9, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthNine) {

        monthSumNine += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("9: $monthSumNine");

      double monthSumTen = 0;
      var monthTen = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 10, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthTen) {

        monthSumTen += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("10: $monthSumTen");

      double monthSumEleven = 0;
      var monthEleven = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 11, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthEleven) {

        monthSumEleven += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("11: $monthSumEleven");

      double monthSumTwelve = 0;
      var monthTwelve = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 12, TransactionsData.TransactionType_Receive, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
      for (var element in monthTwelve) {

        monthSumTwelve += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

      }
      debugPrint("12: $monthSumTwelve");

      listOfEarningPoint.clear();
      listOfEarningPoint.addAll([
        monthSumOne,
        monthSumTwo,
        monthSumThree,
        monthSumFour,
        monthSumFive,
        monthSumSix,
        monthSumSeven,
        monthSumEight,
        monthSumNine,
        monthSumTen,
        monthSumEleven,
        monthSumTwelve
      ]);

      setState(() {

        totalEarningPlaceholder = LineChartView(listOfSpotY: listOfEarningPoint);

      });

      getTransactionsSendSum(selectedYear);

    }

  }

  void getTransactionsSendSum(int selectedYear) async {

    TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

    double monthSumOne = 0;
    var monthOne = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 1, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthOne) {

      monthSumOne += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("1: $monthSumOne");

    double monthSumTwo = 0;
    var monthTwo = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 2, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthTwo) {

      monthSumTwo += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("2: $monthSumTwo");

    double monthSumThree = 0;
    var monthThree = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 3, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthThree) {

      monthSumThree += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("3: $monthSumThree");

    double monthSumFour = 0;
    var monthFour = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 4, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthFour) {

      monthSumFour += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("4: $monthSumFour");

    double monthSumFive = 0;
    var monthFive = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 5, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthFive) {

      monthSumFive += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("5: $monthSumFive");

    double monthSumSix = 0;
    var monthSix = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 6, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthSix) {

      monthSumSix += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("6: $monthSumSix");

    double monthSumSeven = 0;
    var monthSeven = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 7, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthSeven) {

      monthSumSeven += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("7: $monthSumSeven");

    double monthSumEight = 0;
    var monthEight = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 8, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthEight) {

      monthSumEight += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("8: $monthSumEight");

    double monthSumNine = 0;
    var monthNine = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 9, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthNine) {

      monthSumNine += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("9: $monthSumNine");

    double monthSumTen = 0;
    var monthTen = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 10, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthTen) {

      monthSumTen += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("10: $monthSumTen");

    double monthSumEleven = 0;
    var monthEleven = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 11, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthEleven) {

      monthSumEleven += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("11: $monthSumEleven");

    double monthSumTwelve = 0;
    var monthTwelve = await transactionsDatabaseQueries.queryTransactionByMonths(selectedYear, 12, TransactionsData.TransactionType_Send, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);
    for (var element in monthTwelve) {

      monthSumTwelve += int.parse(transactionsDatabaseQueries.extractTransactionsQuery(element).amountMoney);

    }
    debugPrint("12: $monthSumTwelve");

    listOfSpendingPoint.clear();
    listOfSpendingPoint.addAll([
      monthSumOne,
      monthSumTwo,
      monthSumThree,
      monthSumFour,
      monthSumFive,
      monthSumSix,
      monthSumSeven,
      monthSumEight,
      monthSumNine,
      monthSumTen,
      monthSumEleven,
      monthSumTwelve
    ]);

    setState(() {

      totalSpendingPlaceholder = LineChartView(listOfSpotY: listOfSpendingPoint);

    });

    prepareTotalBalance();

  }

  void prepareTotalBalance() async {

    listOfBalancePoint.clear();
    listOfBalancePoint.addAll([
      listOfEarningPoint[0] - listOfSpendingPoint[0],
      listOfEarningPoint[1] - listOfSpendingPoint[1],
      listOfEarningPoint[2] - listOfSpendingPoint[2],
      listOfEarningPoint[3] - listOfSpendingPoint[3],
      listOfEarningPoint[4] - listOfSpendingPoint[4],
      listOfEarningPoint[5] - listOfSpendingPoint[5],
      listOfEarningPoint[6] - listOfSpendingPoint[6],
      listOfEarningPoint[7] - listOfSpendingPoint[7],
      listOfEarningPoint[8] - listOfSpendingPoint[8],
      listOfEarningPoint[9] - listOfSpendingPoint[9],
      listOfEarningPoint[10] - listOfSpendingPoint[10],
      listOfEarningPoint[11] - listOfSpendingPoint[11],
    ]);

    setState(() {

      totalBalancePlaceholder = LineChartView(listOfSpotY: listOfBalancePoint);

    });

  }

}