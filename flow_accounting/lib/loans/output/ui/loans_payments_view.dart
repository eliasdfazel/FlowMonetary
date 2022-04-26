
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 5:03 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flow_accounting/loans/database/io/inputs.dart';
import 'package:flow_accounting/loans/database/structure/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/calendar/io/time_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee/marquee.dart';

class LoansPaymentsView extends StatefulWidget {

  LoansData loansData;

  LoansPaymentsView({Key? key, required this.loansData}) : super(key: key);

  @override
  _LoansPaymentsViewState createState() => _LoansPaymentsViewState();
}
class _LoansPaymentsViewState extends State<LoansPaymentsView> {

  TimeIO timeIO = TimeIO();

  List<DateTime> paymentsDateTime = [];

  List<LoansData> allLoans = [];
  List<Widget> allListContentWidgets = [];

  double eachPaymentAmount = 0;

  List<String> paidIndexed = [];

  bool thisLoanPaid = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    int loanAmount = int.parse(widget.loansData.loanComplete.replaceAll(",", ""));

    int paymentsCount = int.parse(widget.loansData.loanCount);

    eachPaymentAmount = (loanAmount / paymentsCount);

    if (widget.loansData.loansPaymentsIndexes != "-1") {

      paidIndexed = removeEmptyElementCsv(widget.loansData.loansPaymentsIndexes.split(","));

    }

    calculatePayments(widget.loansData);

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Sans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
      home: Scaffold(
          backgroundColor: ColorsResources.black,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(1.1, 3, 1.1, 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)
                ),
                gradient: LinearGradient(
                    colors: [
                      ColorsResources.blueGray,
                      ColorsResources.black,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    transform: GradientRotation(45),
                    tileMode: TileMode.clamp),
              ),
              child: Stack(
                children: [
                  const Opacity(
                    opacity: 0.07,
                    child: Image(
                      image: AssetImage("input_background_pattern.png"),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 7.0,
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 279, 0, 79),
                    physics: const BouncingScrollPhysics(),
                    children: allListContentWidgets,
                  ),
                  Padding(
                    padding: const  EdgeInsets.fromLTRB(13, 79, 13, 13),
                    child: PhysicalModel(
                      color: Colors.transparent,
                      elevation: 7,
                      shadowColor: Color(widget.loansData.colorTag).withOpacity(0.79),
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(17)),
                      child: Stack(
                        children: [
                          Blur(
                            blur: 3.0,
                            borderRadius: BorderRadius.circular(17),
                            alignment: AlignmentDirectional.center,
                            blurColor: Color(widget.loansData.colorTag),
                            colorOpacity: 0.1,
                            child: const SizedBox(
                              width: double.infinity,
                              height: 191,
                            ),
                          ),
                          Container(
                            height: 191,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(17),
                                  topRight: Radius.circular(17),
                                  bottomLeft: Radius.circular(17),
                                  bottomRight: Radius.circular(17)
                              ),
                              gradient: LinearGradient(
                                  colors: [
                                    ColorsResources.white.withOpacity(0.51),
                                    ColorsResources.light.withOpacity(0.51),
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  transform: GradientRotation(45),
                                  tileMode: TileMode.clamp
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 59,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(27, 11, 13, 0),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Marquee(
                                                  text: widget.loansData.loanComplete,
                                                  style: const TextStyle(
                                                    color: ColorsResources.dark,
                                                    fontSize: 31,
                                                    fontFamily: "Numbers",
                                                  ),
                                                  scrollAxis: Axis.horizontal,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  blankSpace: 293.0,
                                                  velocity: 37.0,
                                                  fadingEdgeStartFraction: 0.13,
                                                  fadingEdgeEndFraction: 0.13,
                                                  startAfter: const Duration(milliseconds: 777),
                                                  numberOfRounds: 3,
                                                  pauseAfterRound: const Duration(milliseconds: 500),
                                                  showFadingOnlyWhenScrolling: true,
                                                  startPadding: 13.0,
                                                  accelerationDuration: const Duration(milliseconds: 500),
                                                  accelerationCurve: Curves.linear,
                                                  decelerationDuration: const Duration(milliseconds: 500),
                                                  decelerationCurve: Curves.easeOut,
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 39,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(27, 11, 13, 0),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Marquee(
                                                  text: eachPaymentAmount.toString(),
                                                  style: const TextStyle(
                                                    color: ColorsResources.darkTransparent,
                                                    fontSize: 19,
                                                    fontFamily: "Numbers",
                                                  ),
                                                  scrollAxis: Axis.horizontal,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  blankSpace: 293.0,
                                                  velocity: 37.0,
                                                  fadingEdgeStartFraction: 0.13,
                                                  fadingEdgeEndFraction: 0.13,
                                                  startAfter: const Duration(milliseconds: 777),
                                                  numberOfRounds: 3,
                                                  pauseAfterRound: const Duration(milliseconds: 500),
                                                  showFadingOnlyWhenScrolling: true,
                                                  startPadding: 13.0,
                                                  accelerationDuration: const Duration(milliseconds: 500),
                                                  accelerationCurve: Curves.linear,
                                                  decelerationDuration: const Duration(milliseconds: 500),
                                                  decelerationCurve: Curves.easeOut,
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: 39,
                                            width: double.infinity,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(19, 11, 19, 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(
                                                          widget.loansData.loanTitle,
                                                          style: const TextStyle(
                                                            color: ColorsResources.dark,
                                                            fontSize: 19,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                        SizedBox(
                                          height: 51,
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(31, 0, 19, 0),
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  widget.loansData.loanDescription,
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: ColorsResources.dark.withOpacity(0.537),
                                                      fontSize: 15
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      child: RotatedBox(
                                        quarterTurns: 3,
                                        child: SizedBox(
                                          height: 27,
                                          width: 79,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(17),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft: Radius.circular(0),
                                                  bottomRight: Radius.circular(17)
                                              ),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color(widget.loansData.colorTag).withOpacity(0.7),
                                                    ColorsResources.light,
                                                  ],
                                                  begin: const FractionalOffset(0.0, 0.0),
                                                  end: const FractionalOffset(1.0, 0.0),
                                                  stops: const [0.0, 1.0],
                                                  transform: const GradientRotation(45),
                                                  tileMode: TileMode.clamp
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          )
                        ],
                      )
                    ),
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
          )
      ),
    );
  }

  Widget outputItem(BuildContext context, int itemIndex, DateTime dateTime) {

    for (int i = 0; i < paidIndexed.length; i++) {

      if (paidIndexed[i] == itemIndex.toString()) {
        debugPrint("Loan Index ${itemIndex} Is Paid");

        thisLoanPaid = true;

        break;

      } else {

        thisLoanPaid = false;

      }

    }

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              paymentProcessed(itemIndex, true);

              setState(() {

                thisLoanPaid = true;

              });

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.lightBlue,
            icon: Icons.paid_rounded,
            label: StringsResources.loansPaymentsPaid(),
            autoClose: true,
          )
        ],
      ),
      child: Padding(
        padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
        child: PhysicalModel(
          color: ColorsResources.light,
          elevation: 9,
          shadowColor: Color(widget.loansData.colorTag).withOpacity(0.79),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(19)),
          child: Container(
            height: 173,
            width: 173,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17)
              ),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.white,
                    ColorsResources.light,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 19, 19, 0),
                      child: Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: Text(
                          timeIO.humanReadableFarsi(dateTime),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 19,
                            color: ColorsResources.dark,
                            shadows: [
                              Shadow(
                                color: ColorsResources.primaryColorLight,
                                blurRadius: 7,
                                offset: Offset(1.0, 1.0)
                              )
                            ]
                          ),
                        )
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(17, 7, 7, 17),
                      child: Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Transform.scale(
                            scale: 2.73,
                            child: Checkbox(
                              tristate: true,
                              checkColor: ColorsResources.applicationLightGeeksEmpire,
                              fillColor: MaterialStateProperty.all(ColorsResources.dark.withOpacity(0.1)),
                              visualDensity: VisualDensity.comfortable,
                              shape: CircleBorder(),
                              splashRadius: 37,
                              onChanged: (newValue) {

                                paymentProcessed(itemIndex, newValue ?? false);

                              },
                              value: thisLoanPaid,
                            )
                        )
                      )
                    )
                  ],
                )
            ),
          )
        ),
      )
    );

  }

  void preparePaymentsItems() async {

    allListContentWidgets.clear();

    int itemIndex = 0;

    for (var element in paymentsDateTime) {

      allListContentWidgets.add(outputItem(context, itemIndex, element));

      itemIndex++;

    }

    setState(() {

      allListContentWidgets;

    });

  }

  void calculatePayments(LoansData loansData) async {
    debugPrint("${loansData}");

    int paymentsCount = int.parse(loansData.loanCount);

    int firstLoanPaymentMillisecond = int.parse(loansData.loanDuePeriodMillisecond);

    int paymentTimeType = TimeIO.OneMonthMillisecond;

    switch (int.parse(loansData.loanDuePeriodType)) {
      case LoansData.LoanPeriodType_Month: {

        paymentTimeType = TimeIO.OneMonthMillisecond;

        break;
      }
      case LoansData.LoanPeriodType_ThreeMonth: {

        paymentTimeType = TimeIO.ThreeMonthsMillisecond;

        break;
      }
      case LoansData.LoanPeriodType_SixMonth: {

        paymentTimeType = TimeIO.SixMonthsMillisecond;

        break;
      }
      case LoansData.LoanPeriodType_Year: {

        paymentTimeType = TimeIO.TwelveMonthsMillisecond;

        break;
      }
    }

    for (int paymentIndex = 0; paymentIndex < paymentsCount; paymentIndex++) {

      DateTime loanPayment = DateTime.fromMillisecondsSinceEpoch(firstLoanPaymentMillisecond + (paymentIndex * paymentTimeType));

      paymentsDateTime.add(loanPayment);

    }

    preparePaymentsItems();

  }

  void paymentProcessed(int itemIndex, bool insertIt) async {

    if (widget.loansData.loansPaymentsIndexes == "-1") {

      widget.loansData.loansPaymentsIndexes = "";

    }

    if (insertIt) {
      debugPrint("Loan Index ${itemIndex} Paid");

      widget.loansData.loansPaymentsIndexes += "${itemIndex},";

    } else {
      debugPrint("Loan Index ${itemIndex} Not Paid");

      widget.loansData.loansPaymentsIndexes.replaceAll("${itemIndex},", "");

    }

    widget.loansData.loansPaymentsIndexes = cleanUpCsvDatabase(widget.loansData.loansPaymentsIndexes);

    LoansDatabaseInputs loansDatabaseInputs = LoansDatabaseInputs();

    loansDatabaseInputs.updateChequeData(widget.loansData, LoansDatabaseInputs.databaseTableName, UserInformation.UserId);

    if (widget.loansData.loansPaymentsIndexes != "-1") {

      paidIndexed = removeEmptyElementCsv(widget.loansData.loansPaymentsIndexes.split(","));

    }

    Future.delayed(Duration(milliseconds: 357), () {

      preparePaymentsItems();

    });

  }

  List<String> removeEmptyElementCsv(List<String> inputList) {

    List<String> cleanCsvList = [];

    inputList.forEach((element) {

      if (element.isNotEmpty) {

        cleanCsvList.add(element);

      }

    });

    return cleanCsvList;
  }

  String cleanUpCsvDatabase(String inputCsvData) {

    List<String> csvData = removeEmptyElementCsv(inputCsvData.split(","));

    String clearCsvDatabase = "";

    csvData.forEach((element) {

      clearCsvDatabase += "${element},";

    });

    return clearCsvDatabase;
  }

}