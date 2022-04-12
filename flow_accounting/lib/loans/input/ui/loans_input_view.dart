/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/12/22, 5:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:flow_accounting/loans/database/io/inputs.dart';
import 'package:flow_accounting/loans/database/structure/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/calendar/ui/calendar_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoansInputView extends StatefulWidget {

  LoansData? loansData;

  LoansInputView({Key? key, this.loansData}) : super(key: key);

  @override
  _LoansInputViewState createState() => _LoansInputViewState();
}
class _LoansInputViewState extends State<LoansInputView> {

  CalendarView loanCalendarView = CalendarView();

  ColorSelectorView colorSelectorView = ColorSelectorView();

  TextEditingController controllerLoanTitle = TextEditingController();
  TextEditingController controllerLoanDescription = TextEditingController();

  TextEditingController controllerLoanPayer = TextEditingController();

  TextEditingController controllerLoanComplete = TextEditingController();
  TextEditingController controllerLoanPaid = TextEditingController();
  TextEditingController controllerLoanRemaining = TextEditingController();

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  bool loanDataUpdated = false;

  int loanPeriodType = LoansData.LoanPeriodType_Month;
  String loanPeriod = StringsResources.loansPeriodOneMonth();

  String? warningNoticeTitle;

  String? warningNoticeComplete;

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {

    loanCalendarView.pickedDataTimeText = StringsResources.chequeIssueDate();

    controllerLoanTitle.text = widget.loansData?.loanTitle == null ? "" : (widget.loansData?.loanTitle)!;
    controllerLoanDescription.text = widget.loansData?.loanDescription == null ? "" : (widget.loansData?.loanDescription)!;

    controllerLoanPayer.text = widget.loansData?.loanPayer == null ? "" : (widget.loansData?.loanPayer)!;

    controllerLoanComplete.text = widget.loansData?.loanComplete == null ? "" : (widget.loansData?.loanComplete)!;
    controllerLoanPaid.text = widget.loansData?.loanPaid == null ? "" : (widget.loansData?.loanPaid)!;
    controllerLoanRemaining.text = widget.loansData?.loanRemaining == null ? "" : (widget.loansData?.loanRemaining)!;

    colorSelectorView.inputColor = Color(widget.loansData?.colorTag ?? Colors.white.value);

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    Navigator.pop(context, loanDataUpdated);

    return true;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Sans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: Scaffold(
        backgroundColor: ColorsResources.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
          child: Container (
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.white,
                    ColorsResources.primaryColorLighter,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp),
            ),
            child: Stack ( /*** Page Content ***/
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
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 93),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                        child:  Text(
                          StringsResources.featureLoansTitle(),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 23,
                            color: ColorsResources.dark,
                            shadows: [
                              Shadow(
                                blurRadius: 13,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(3, 3),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 19),
                        child: Text(
                          StringsResources.featureLoansDescription(),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorsResources.blueGreen,
                            shadows: [
                              Shadow(
                                blurRadius: 7,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(1.3, 1.3),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerLoanTitle,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeComplete,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.loansTitle(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.loansTitleHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 133,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerLoanDescription,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.top,
                                      maxLines: 5,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ColorsResources.applicationDarkGeeksEmpire
                                      ),
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeTitle,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.loansDescription(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.loansDescriptionHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerLoanPayer,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeComplete,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.loansPayer(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.loansPayerHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerLoanComplete,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeComplete,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.loansComplete(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.loansCompleteHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerLoanPaid,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (loanPaid) {

                                        try {

                                          int debtorCompleteDebt = int.parse(controllerLoanComplete.text.isEmpty ? "0" : controllerLoanComplete.text);

                                          int debtorPaidDebt = int.parse(loanPaid.isEmpty ? "0" : loanPaid);

                                          controllerLoanRemaining.text = (debtorCompleteDebt - debtorPaidDebt).toString();

                                        } on Exception {

                                        }

                                      },
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeComplete,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.loansPaid(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.loansPaidHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerLoanRemaining,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeComplete,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.loansRemaining(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.loansRemainingHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 91,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(13),
                                          topRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                          bottomRight: Radius.circular(13)
                                      ),
                                      border: Border(
                                          top: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          ),
                                          bottom: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          ),
                                          left: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          ),
                                          right: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          )
                                      ),
                                      color: ColorsResources.lightTransparent,
                                    ),
                                    child: SizedBox(
                                      height: 62,
                                      width: double.infinity,
                                      child: loanCalendarView,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 31,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      StringsResources.loansPeriod(),
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 37,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(51),
                                      color: ColorsResources.lightestBlue
                                    ),
                                    child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Align(
                                          alignment: AlignmentDirectional.center,
                                          child: Text(
                                            StringsResources.loansPeriodOneYear(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: ColorsResources.dark,
                                                decoration: TextDecoration.none
                                            ),
                                          )
                                        )
                                    )
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(51),
                                          color: ColorsResources.lightestBlue
                                      ),
                                      child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                              alignment: AlignmentDirectional.center,
                                              child: Text(
                                                StringsResources.loansPeriodSixMonth(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: ColorsResources.dark,
                                                    decoration: TextDecoration.none
                                                ),
                                              )
                                          )
                                      )
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(51),
                                          color: ColorsResources.lightestBlue
                                      ),
                                      child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                              alignment: AlignmentDirectional.center,
                                              child: Text(
                                                StringsResources.loansPeriodThreeMonth(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: ColorsResources.dark,
                                                    decoration: TextDecoration.none
                                                ),
                                              )
                                          )
                                      )
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Container(
                                      width: double.infinity,
                                      height: 37,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(51),
                                          color: ColorsResources.lightestBlue
                                      ),
                                      child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                              alignment: AlignmentDirectional.center,
                                              child: Text(
                                                StringsResources.loansPeriodOneMonth(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: ColorsResources.dark,
                                                    decoration: TextDecoration.none
                                                ),
                                              )
                                          )
                                      )
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 37,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      StringsResources.colorSelectorHint(),
                                      style: TextStyle(
                                          fontSize: 15
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 103,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: colorSelectorView,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
                Positioned(
                    top: 19,
                    left: 13,
                    child:  InkWell(
                      onTap: () {

                        Navigator.pop(context, loanDataUpdated);

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
                    bottom: 19,
                    left: 71,
                    right: 71,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(51.0),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: ColorsResources.applicationGeeksEmpire.withOpacity(0.5),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            bool noError = true;

                            if (controllerLoanTitle.text.isEmpty) {

                              setState(() {

                                warningNoticeTitle = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (controllerLoanComplete.text.isEmpty) {

                              setState(() {

                                warningNoticeComplete = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (noError) {

                              if (widget.loansData != null) {

                                if ((widget.loansData?.id)! != 0) {

                                  timeNow = (widget.loansData?.id)!;

                                }

                              }

                              var databaseInputs = LoansDatabaseInputs();

                              LoansData transactionData = LoansData(
                                  id: timeNow,

                                  loanTitle: controllerLoanTitle.text,
                                  loanDescription: controllerLoanDescription.text,

                                  loanPayer: controllerLoanPayer.text,

                                  loanDuePeriodType: loanPeriodType.toString(),
                                  loanDuePeriod: loanCalendarView.pickedDataTimeText.toString(),
                                  loanDuePeriodMillisecond: loanCalendarView.pickedDateTime.millisecondsSinceEpoch.toString(),

                                  loanComplete: controllerLoanComplete.text.isEmpty ? "0" : controllerLoanComplete.text,
                                  loanPaid: controllerLoanPaid.text.isEmpty ? "0" : controllerLoanPaid.text,
                                  loanRemaining: controllerLoanRemaining.text.isEmpty ? "0" : controllerLoanRemaining.text,

                                  colorTag: colorSelectorView.selectedColor.value
                              );

                              if (widget.loansData != null) {

                                if ((widget.loansData?.id)! != 0) {

                                  databaseInputs.updateChequeData(transactionData, LoansDatabaseInputs.databaseTableName, UserInformation.UserId);

                                }

                              } else {

                                databaseInputs.insertLoanData(transactionData, LoansDatabaseInputs.databaseTableName, UserInformation.UserId);

                              }

                              Fluttertoast.showToast(
                                  msg: StringsResources.updatedText(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorsResources.lightTransparent,
                                  textColor: ColorsResources.dark,
                                  fontSize: 16.0
                              );

                              loanDataUpdated = true;

                            }

                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(51),
                                    topRight: Radius.circular(51),
                                    bottomLeft: Radius.circular(51),
                                    bottomRight: Radius.circular(51)
                                ),
                                border: const Border(
                                    top: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    ),
                                    left: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    ),
                                    right: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    )
                                ),
                                gradient: LinearGradient(
                                    colors: [
                                      ColorsResources.primaryColor.withOpacity(0.3),
                                      ColorsResources.primaryColorLight.withOpacity(0.3),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: const [0.0, 1.0],
                                    transform: const GradientRotation(45),
                                    tileMode: TileMode.clamp
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsResources.dark.withOpacity(0.179),
                                    blurRadius: 13.0,
                                    spreadRadius: 0.3,
                                    offset: const Offset(3.0, 3.0),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Blur(
                                    blur: 3.0,
                                    borderRadius: BorderRadius.circular(51),
                                    alignment: AlignmentDirectional.center,
                                    blurColor: Colors.blue,
                                    colorOpacity: 0.0,
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 53,
                                    ),
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 53,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: ColoredBox(color: Colors.transparent)
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: AlignmentDirectional.center,
                                              child: Image(
                                                image: AssetImage("submit_icon.png"),
                                                height: 37,
                                                width: 37,
                                                color: ColorsResources.light,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Align(
                                                alignment: AlignmentDirectional.center,
                                                child: Text(
                                                  StringsResources.submitText(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      color: ColorsResources.darkTransparent,
                                                      shadows: [
                                                        Shadow(
                                                            color: ColorsResources.primaryColorDark,
                                                            blurRadius: 7.0,
                                                            offset: Offset(1, 1)
                                                        )
                                                      ]
                                                  ),
                                                ),
                                              )
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: ColoredBox(color: Colors.transparent)
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addLoansReminder(DateTime reminderTime, String loanTitle, String loanDescription, String loanPayer) async {

    bool eventAdded = await Add2Calendar.addEvent2Cal(Event(
        title: loanTitle,
        description: loanDescription,
        location: loanPayer,
        startDate: reminderTime,
        endDate: reminderTime,
        allDay: true,
        iosParams: IOSParams(
            reminder: Duration(days: 1)
        ),
        androidParams: AndroidParams(

        ),
        recurrence: Recurrence(
          frequency: Frequency.monthly,
          interval: 1,
          ocurrences: 3,
        )
    ));

    debugPrint("Event Added: ${eventAdded}");

  }

}