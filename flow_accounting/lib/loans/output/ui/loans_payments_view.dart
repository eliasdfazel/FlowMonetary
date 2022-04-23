
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 5:03 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/loans/database/structure/tables_structure.dart';
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

  List<DateTime> paymentsDateTime = [];

  List<LoansData> allLoans = [];
  List<Widget> allListContentWidgets = [];

  double eachPaymentAmount = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    int loanAmount = int.parse(widget.loansData.loanComplete);

    int paymentsCount = int.parse(widget.loansData.loanCount);

    eachPaymentAmount = (loanAmount / paymentsCount);

    allListContentWidgets.add(
        Padding(
          padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
          child: PhysicalModel(
            color: ColorsResources.light,
            elevation: 7,
            shadowColor: Color(widget.loansData.colorTag).withOpacity(0.79),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(17)),
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
            ),
          ),
        )
    );

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
                      ColorsResources.black,
                      ColorsResources.primaryColorLighter,
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
                  ListView(
                    padding: const EdgeInsets.fromLTRB(0, 73, 0, 79),
                    physics: const BouncingScrollPhysics(),
                    children: allListContentWidgets,
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

  Widget outputItem(BuildContext context, int itemIndex, LoansData loansData) {

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              paymentProcessed(itemIndex, loansData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.gameGeeksEmpire,
            icon: Icons.delete_rounded,
            label: StringsResources.loansPaymentsPaid(),
            autoClose: true,
          )
        ],
      ),
      child: Padding(
        padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
        child: PhysicalModel(
          color: ColorsResources.light,
          elevation: 7,
          shadowColor: Color(loansData.colorTag).withOpacity(0.79),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
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
                                  text: loansData.loanComplete,
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
                                          loansData.loanTitle,
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
                                  loansData.loanDescription,
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
                                    Color(loansData.colorTag).withOpacity(0.7),
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
        ),
      )
    );

  }

  void paymentProcessed(int itemIndex, LoansData loansData) async {



  }

  void calculatePayments(LoansData loansData) {

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

    for (int paymentIndex = 1; paymentIndex < paymentsCount; paymentsCount++) {

      DateTime loanPayment = DateTime(firstLoanPaymentMillisecond + (paymentIndex * paymentTimeType));

      paymentsDateTime.add(loanPayment);

    }

  }

}