/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/13/22, 5:50 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:flow_accounting/budgets/database/io/inputs.dart';
import 'package:flow_accounting/budgets/database/io/queries.dart';
import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:flow_accounting/cheque/database/io/inputs.dart';
import 'package:flow_accounting/cheque/database/structures/table_structure.dart';
import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/io/queries.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/customers/database/io/inputs.dart';
import 'package:flow_accounting/customers/database/io/queries.dart';
import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:flow_accounting/home/interface/dashboard.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/calendar/ui/calendar_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/extensions/BankLogos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChequesInputView extends StatefulWidget {

  ChequesData? chequesData = ChequesData(
      id: 0,
      chequeTitle: "",
      chequeDescription: "",
      chequeNumber: "",
      chequeMoneyAmount: "0",
      chequeTransactionType: "",
      chequeSourceBankName: "",
      chequeSourceBankBranch: "",
      chequeTargetBankName: "",
      chequeIssueDate: "",
      chequeDueDate: "",
      chequeIssueMillisecond: "0",
      chequeDueMillisecond: "0",
      chequeSourceId: "",
      chequeSourceName: "",
      chequeSourceAccountNumber: "0",
      chequeTargetId: "",
      chequeTargetName: "",
      chequeTargetAccountNumber: "0",
      chequeDoneConfirmation: ChequesData.ChequesConfirmation_NOT,
      chequeRelevantCreditCard: "",
      chequeRelevantBudget: "",
      colorTag: ColorsResources.white.value
  );

  ChequesInputView({Key? key, this.chequesData}) : super(key: key);

  @override
  _ChequeInputViewState createState() => _ChequeInputViewState();
}
class _ChequeInputViewState extends State<ChequesInputView> {

  ChequesData? chequesData;

  CalendarView calendarIssueDateView = CalendarView(pickedDataTimeText: StringsResources.chequeIssueDate);
  CalendarView calendarDueDateView = CalendarView(pickedDataTimeText: StringsResources.chequeDueDate);

  ColorSelectorView colorSelectorView = ColorSelectorView();

  TextEditingController controllerChequeNumber = TextEditingController();

  TextEditingController controllerMoneyAmount = TextEditingController();

  TextEditingController controllerChequeTitle = TextEditingController();
  TextEditingController controllerChequeDescription = TextEditingController();

  TextEditingController controllerChequeSourceId = TextEditingController();
  TextEditingController controllerChequeSourceName = TextEditingController();
  TextEditingController controllerChequeBank = TextEditingController();
  TextEditingController controllerChequeBankBranch = TextEditingController();
  TextEditingController controllerChequeSourceAccount = TextEditingController();

  TextEditingController controllerChequeTargetId = TextEditingController();
  TextEditingController controllerChequeTargetName = TextEditingController();
  TextEditingController controllerChequeTargetBank = TextEditingController();
  TextEditingController controllerChequeTargetAccount = TextEditingController();

  TextEditingController controllerCreditCard = TextEditingController();
  TextEditingController controllerBudget = TextEditingController();

  String transactionType = ChequesData.TransactionType_Send;

  String budgetName = ChequesData.TransactionBudgetName;

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  bool chequeDataUpdated = false;

  String chequeConfirmation = ChequesData.ChequesConfirmation_NOT;
  bool chequeConfirmed = false;

  String? warningNotice;

  @override
  void initState() {

    if (widget.chequesData != null) {

      controllerChequeNumber.text = widget.chequesData!.chequeNumber;

      controllerMoneyAmount.text = widget.chequesData!.chequeMoneyAmount;

      controllerChequeTitle.text = widget.chequesData!.chequeTitle;
      controllerChequeDescription.text = widget.chequesData!.chequeDescription;

      controllerChequeSourceId.text = widget.chequesData!.chequeSourceId;
      controllerChequeSourceName.text = widget.chequesData!.chequeSourceName;
      controllerChequeBank.text = widget.chequesData!.chequeSourceBankName;
      controllerChequeBankBranch.text = widget.chequesData!.chequeSourceBankBranch;
      controllerChequeSourceAccount.text = widget.chequesData!.chequeSourceAccountNumber;


      controllerChequeTargetId.text = widget.chequesData!.chequeTargetId;
      controllerChequeTargetName.text = widget.chequesData!.chequeTargetName;
      controllerChequeTargetBank.text = widget.chequesData!.chequeTargetBankName;
      controllerChequeTargetAccount.text = widget.chequesData!.chequeTargetAccountNumber;

      controllerCreditCard.text = widget.chequesData!.chequeRelevantCreditCard;
      controllerBudget.text = widget.chequesData!.chequeRelevantBudget;

      calendarIssueDateView.inputDateTime = widget.chequesData!.chequeIssueDate;
      calendarIssueDateView.pickedDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.chequesData!.chequeIssueMillisecond));
      calendarIssueDateView.pickedDataTimeYear = calendarIssueDateView.pickedDateTime.year.toString();
      calendarIssueDateView.pickedDataTimeMonth = calendarIssueDateView.pickedDateTime.month.toString();

      calendarDueDateView.inputDateTime = widget.chequesData!.chequeDueDate;
      calendarDueDateView.pickedDateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.chequesData!.chequeDueMillisecond));
      calendarDueDateView.pickedDataTimeYear = calendarDueDateView.pickedDateTime.year.toString();
      calendarDueDateView.pickedDataTimeMonth = calendarDueDateView.pickedDateTime.month.toString();

      colorSelectorView.inputColor = Color(widget.chequesData?.colorTag ?? Colors.white.value);

      transactionType = widget.chequesData!.chequeTransactionType;

      budgetName = widget.chequesData!.chequeRelevantBudget;

      chequeConfirmation = widget.chequesData!.chequeDoneConfirmation;

      if (chequeConfirmation == ChequesData.ChequesConfirmation_NOT) {

        chequeConfirmed = false;

      } else if (chequeConfirmation == ChequesData.ChequesConfirmation_Done) {

        chequeConfirmed = true;

      }

    }

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    UpdatedData.UpdatedDataType = UpdatedData.LatestTransactions;

    Navigator.pop(context, chequeDataUpdated);

    return true;
  }

  @override
  Widget build(BuildContext context) {

    Widget chequeConfirmationView = const Divider(height: 0, color: Colors.transparent);

    if (widget.chequesData != null) {

      if (widget.chequesData!.id > 0) {

        chequeConfirmationView = Padding(
          padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(flex: 9, child: Divider(height: 1, color: Colors.transparent)),
              Expanded(
                flex: 13,
                child: SizedBox(
                  height: 73,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(7, 13, 7, 13),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(51),
                              topRight: Radius.circular(51),
                              bottomLeft: Radius.circular(51),
                              bottomRight: Radius.circular(51)
                          ),
                          border: Border.all(
                            color: ColorsResources.dark.withOpacity(0.1),
                            width: 3,
                          ),
                          gradient: LinearGradient(
                              colors: [
                                ColorsResources.white.withOpacity(0.91),
                                ColorsResources.lightestBlue.withOpacity(0.91),
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              transform: GradientRotation(45),
                              tileMode: TileMode.clamp
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(51.0),
                          child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: ColorsResources.applicationGeeksEmpire.withOpacity(0.5),
                              splashFactory: InkRipple.splashFactory,
                              onTap: () {

                                setState(() {

                                  chequeConfirmed = !chequeConfirmed;

                                });

                              },
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(13, 0, 17, 0),
                                    child: Text(
                                      StringsResources.chequeConfirmation,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: ColorsResources.applicationDarkGeeksEmpire
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 73,
                  width: 73,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      child: Transform.scale(
                        scale: 1.93,
                        child: Checkbox(
                          tristate: true,
                          checkColor: ColorsResources.applicationLightGeeksEmpire,
                          fillColor: MaterialStateProperty.all(ColorsResources.dark.withOpacity(0.1)),
                          visualDensity: VisualDensity.comfortable,
                          shape: CircleBorder(),
                          splashRadius: 37,
                          value: chequeConfirmed,
                          onChanged: (bool? confirmed) {

                            setState(() {

                              chequeConfirmed = confirmed ?? false;

                            });

                            if (chequeConfirmed) {

                              chequeConfirmation = ChequesData.ChequesConfirmation_Done;

                            } else if (!chequeConfirmed) {

                              chequeConfirmation = ChequesData.ChequesConfirmation_NOT;

                            }

                            if (chequesData != null) {

                              processBudgetBalance(chequesData!);

                              processCreditCardsBalance(chequesData!);

                              processAddTransaction(chequesData!);

                            }

                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      }

    }

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
                      chequeConfirmationView,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                        child:  Text(
                          StringsResources.featureChequesTitle,
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
                          StringsResources.featureChequesDescription,
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
                                      controller: controllerChequeTitle,
                                      textAlign: TextAlign.right,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.titleText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.titleText,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
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
                                      controller: controllerChequeDescription,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.descriptionText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.descriptionText,
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
                                      controller: controllerChequeNumber,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.chequeNumber,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.chequeNumberHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
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
                                      controller: controllerMoneyAmount,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.transactionAmount,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.chequeAmountHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
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
                                padding: const EdgeInsets.fromLTRB(13, 0, 7, 0),
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
                                      child: calendarDueDateView,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 13, 0),
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
                                      child: calendarIssueDateView,
                                    ),
                                  ),
                                ),
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
                                      controller: controllerChequeSourceAccount,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.chequeSourceAccount,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 15.0
                                        ),
                                        hintText: StringsResources.chequeSourceAccountHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
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
                                      controller: controllerChequeTargetAccount,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.chequeTargetAccount,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 15.0
                                        ),
                                        hintText: StringsResources.chequeTargetAccountHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
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
                                  padding: const EdgeInsets.fromLTRB(7, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerChequeTargetId,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.chequeTargetId,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 15.0
                                        ),
                                        hintText: StringsResources.chequeTargetIdHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 7, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerChequeSourceId,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.chequeSourceId,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 15.0
                                        ),
                                        hintText: StringsResources.chequeSourceIdHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
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
                                    child: TypeAheadField<CustomersData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getCustomersNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                      flex: 11,
                                                      child:  Padding(
                                                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                        child: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Text(
                                                            suggestion.customerName,
                                                            style: const TextStyle(
                                                                color: ColorsResources.darkTransparent,
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child: AspectRatio(
                                                        aspectRatio: 1,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Color(suggestion.colorTag)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(51),
                                                              child: Image.file(
                                                                File(suggestion.customerImagePath),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerChequeTargetName.text = suggestion.customerName.toString();

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return const Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText)
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerChequeTargetName,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
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
                                            errorText: warningNotice,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionTargetName,
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionTargetNameHint,
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 17.0
                                            ),
                                          ),
                                        )
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TypeAheadField<CustomersData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getCustomersNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                      flex: 11,
                                                      child:  Padding(
                                                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                        child: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Text(
                                                            suggestion.customerName,
                                                            style: const TextStyle(
                                                                color: ColorsResources.darkTransparent,
                                                                fontSize: 15
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child: AspectRatio(
                                                        aspectRatio: 1,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Color(suggestion.colorTag)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(51),
                                                              child: Image.file(
                                                                File(suggestion.customerImagePath),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerChequeSourceName.text = suggestion.customerName.toString();

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return const Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText)
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerChequeSourceName,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
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
                                            errorText: warningNotice,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionSourceName,
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionSourceNameHint,
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 17.0
                                            ),
                                          ),
                                        )
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
                                    child: TypeAheadField<String>(
                                        suggestionsCallback: (pattern) async {

                                          return await getBanksNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 11,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                      child: Directionality(
                                                        textDirection: TextDirection.rtl,
                                                        child: Text(
                                                          suggestion,
                                                          style: const TextStyle(
                                                              color: ColorsResources.darkTransparent,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child:  AspectRatio(
                                                        aspectRatio: 1,
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: ColorsResources.light
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(51),
                                                              child: Image.network(
                                                                generateBankLogoUrl(suggestion),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerChequeTargetBank.text = suggestion.toString();

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return const Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText)
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerChequeTargetBank,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
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
                                            errorText: warningNotice,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionTargetBank,
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionTargetBankHint,
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 17.0
                                            ),
                                          ),
                                        )
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TypeAheadField<String>(
                                        suggestionsCallback: (pattern) async {

                                          return await getBanksNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 11,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                    child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Text(
                                                        suggestion,
                                                        style: const TextStyle(
                                                            color: ColorsResources.darkTransparent,
                                                            fontSize: 15
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child:  AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: ColorsResources.light
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(51),
                                                            child: Image.network(
                                                              generateBankLogoUrl(suggestion),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                ),
                                              ],
                                            )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerChequeBank.text = suggestion.toString();

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return const Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText)
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerChequeBank,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
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
                                            errorText: warningNotice,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionSourceBank,
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionSourceBankHint,
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 17.0
                                            ),
                                          ),
                                        )
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
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 25),
                                  child: Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextField(
                                        controller: controllerChequeBankBranch,
                                        textAlign: TextAlign.right,
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
                                          errorText: warningNotice,
                                          filled: true,
                                          fillColor: ColorsResources.lightTransparent,
                                          labelText: StringsResources.chequeBankBranch,
                                          labelStyle: const TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 17.0
                                          ),
                                          hintText: StringsResources.chequeBankBranch,
                                          hintStyle: const TextStyle(
                                              color: ColorsResources.darkTransparent,
                                              fontSize: 17.0
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(7, 0, 13, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                          alignment: AlignmentDirectional.topCenter,
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: DropdownButtonFormField(
                                              isDense: true,
                                              elevation: 7,
                                              focusColor: ColorsResources.applicationDarkGeeksEmpire,
                                              dropdownColor: ColorsResources.light,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  filled: true,
                                                  fillColor: ColorsResources.lightTransparent,
                                                  focusColor: ColorsResources.dark
                                              ),
                                              value: StringsResources.transactionTypeSend,
                                              items: <String> [
                                                StringsResources.transactionTypeSend,
                                                StringsResources.transactionTypeReceive
                                              ].map<DropdownMenuItem<String>>((String value) {

                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: SizedBox(
                                                    height: 27,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                                      child: Align(
                                                        alignment:
                                                        AlignmentDirectional.center,
                                                        child: Text(
                                                          value,
                                                          style: const TextStyle(
                                                            color: ColorsResources.darkTransparent,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {

                                                if (value.toString() == StringsResources.transactionTypeReceive) {

                                                  transactionType = ChequesData.TransactionType_Receive;

                                                } else if (value.toString() == StringsResources.transactionTypeSend) {

                                                  transactionType = ChequesData.TransactionType_Send;

                                                }

                                              },
                                            ),
                                          )
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 7, 0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              StringsResources.transactionTypeHint,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: ColorsResources.applicationGeeksEmpire,
                                                  fontSize: 12
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
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
                                    child: TypeAheadField<CreditCardsData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getCreditCards();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(title: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              suggestion.cardNumber,
                                              style: const TextStyle(
                                                  color: ColorsResources.darkTransparent,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ));
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerCreditCard.text = suggestion.cardNumber.toString();

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return const Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText)
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerCreditCard,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(16)
                                          ],
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
                                            errorText: warningNotice,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.chequeCard,
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.chequeCardHint,
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 17.0
                                            ),
                                          ),
                                        )
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
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TypeAheadField<BudgetsData>(
                                suggestionsCallback: (pattern) async {

                                  return await getBudgetNames();
                                },
                                itemBuilder: (context, suggestion) {

                                  return ListTile(title: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: SizedBox(
                                        height: 51,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Color(suggestion.colorTag)
                                                    ),
                                                    child: const Padding(
                                                      padding: EdgeInsets.fromLTRB(1.7, 1.7, 1.7, 1.7),
                                                      child: Image(
                                                        image: AssetImage("coins_icon.png"),
                                                        height: 51,
                                                        width: 51,
                                                        color: ColorsResources.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                            Expanded(
                                              flex: 11,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                child: Text(
                                                  suggestion.budgetName,
                                                  style: const TextStyle(
                                                      color: ColorsResources.darkTransparent,
                                                      fontSize: 15
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ));
                                },
                                onSuggestionSelected: (suggestion) {

                                  controllerBudget.text = suggestion.budgetName.toString();
                                  budgetName = suggestion.budgetName.toString();

                                },
                                errorBuilder: (context, suggestion) {

                                  return const Padding(
                                      padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                      child: Text(StringsResources.nothingText)
                                  );
                                },
                                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                    elevation: 7,
                                    color: ColorsResources.light,
                                    shadowColor: ColorsResources.darkTransparent,
                                    borderRadius: BorderRadius.circular(17)
                                ),
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: controllerBudget,
                                  autofocus: false,
                                  maxLines: 1,
                                  cursorColor: ColorsResources.primaryColor,
                                  keyboardType: TextInputType.text,
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
                                    errorText: warningNotice,
                                    filled: true,
                                    fillColor: ColorsResources.lightTransparent,
                                    labelText: StringsResources.transactionBudgetName,
                                    labelStyle: const TextStyle(
                                        color: ColorsResources.dark,
                                        fontSize: 17.0
                                    ),
                                    hintText: StringsResources.transactionBudgetNameHint,
                                    hintStyle: const TextStyle(
                                        color: ColorsResources.darkTransparent,
                                        fontSize: 17.0
                                    ),
                                  ),
                                )
                            ),
                          ),
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
                          children: const [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      StringsResources.colorSelectorHint,
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

                        UpdatedData.UpdatedDataType = UpdatedData.LatestTransactions;

                        Navigator.pop(context, chequeDataUpdated);

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

                          if (controllerChequeNumber.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeSourceAccount.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeTargetAccount.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerMoneyAmount.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeTitle.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeDescription.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeSourceId.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeSourceName.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeBank.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeBankBranch.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeSourceAccount.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeTargetId.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeTargetName.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeTargetBank.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerChequeTargetAccount.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerBudget.text.isEmpty) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (controllerCreditCard.text.length < 16) {

                            setState(() {

                              warningNotice = StringsResources.errorText;

                            });

                            noError = false;

                          }

                          if (noError) {

                            var databaseInputs = ChequesDatabaseInputs();

                            if (widget.chequesData != null) {

                              if ((widget.chequesData?.id)! != 0) {

                                timeNow = (widget.chequesData?.id)!;

                              }

                            }

                            chequesData = ChequesData(
                              id: timeNow,

                              chequeTitle: controllerChequeTitle.text,
                              chequeDescription: controllerChequeDescription.text,

                              chequeNumber: controllerChequeNumber.text,

                              chequeMoneyAmount: controllerMoneyAmount.text,

                              chequeTransactionType: transactionType,

                              chequeSourceBankName: controllerChequeBank.text,
                              chequeSourceBankBranch: controllerChequeBankBranch.text,

                              chequeTargetBankName: controllerChequeTargetBank.text,

                              chequeIssueDate: calendarIssueDateView.pickedDataTimeText ?? "",
                              chequeDueDate: calendarDueDateView.pickedDataTimeText ?? "",

                              chequeIssueMillisecond: calendarIssueDateView.pickedDateTime.millisecondsSinceEpoch.toString(),
                              chequeDueMillisecond: calendarDueDateView.pickedDateTime.millisecondsSinceEpoch.toString(),

                              chequeSourceId: controllerChequeSourceId.text,
                              chequeSourceName: controllerChequeSourceName.text,
                              chequeSourceAccountNumber: controllerChequeSourceAccount.text,

                              chequeTargetId: controllerChequeTargetId.text,
                              chequeTargetName: controllerChequeTargetName.text,
                              chequeTargetAccountNumber: controllerChequeTargetAccount.text,

                              chequeDoneConfirmation: chequeConfirmation,

                              chequeRelevantCreditCard: controllerCreditCard.text,
                              chequeRelevantBudget: controllerBudget.text,

                              colorTag: colorSelectorView.selectedColor.value,
                            );

                            databaseInputs.insertChequeData(chequesData!, ChequesDatabaseInputs.databaseTableName, UserInformation.UserId);

                            addChequeReminder(
                                calendarDueDateView.pickedDateTime,
                                controllerChequeTitle.text,
                                controllerChequeDescription.text,
                                "${controllerChequeBank.text} - ${controllerChequeBankBranch.text}"
                            );

                            Fluttertoast.showToast(
                                msg: StringsResources.updatedText,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorsResources.lightTransparent,
                                textColor: ColorsResources.dark,
                                fontSize: 16.0
                            );

                            chequeDataUpdated = true;

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
                                const SizedBox(
                                    width: double.infinity,
                                    height: 53,
                                    child: Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        StringsResources.submitText,
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

  Future<List<CustomersData>> getCustomersNames() async {

    List<CustomersData> listOfCustomers = [];

    CustomersDatabaseQueries customersDatabaseQueries = CustomersDatabaseQueries();

    var retrievedCustomers = await customersDatabaseQueries.getAllCustomers(CustomersDatabaseInputs.databaseTableName, UserInformation.UserId);

    if (retrievedCustomers.isNotEmpty) {

      listOfCustomers.addAll(retrievedCustomers);

    }

    return listOfCustomers;
  }

  Future<List<String>> getBanksNames() async {

    return StringsResources.listOfBanksIran;
  }

  Future<List<BudgetsData>> getBudgetNames() async {

    List<BudgetsData> listOfBudgets = [];

    BudgetsDatabaseQueries budgetsDatabaseQueries = BudgetsDatabaseQueries();

    var retrievedBudgets = await budgetsDatabaseQueries.getAllBudgets(BudgetsDatabaseInputs.databaseTableName, UserInformation.UserId);

    if (retrievedBudgets.isNotEmpty) {

      listOfBudgets.addAll(retrievedBudgets);

    }

    return listOfBudgets;
  }

  Future<List<CreditCardsData>> getCreditCards() async {

    List<CreditCardsData> listOfCreditCards = [];

    CreditCardsDatabaseQueries creditCardsDatabaseQueries = CreditCardsDatabaseQueries();

    var retrievedCreditCards = await creditCardsDatabaseQueries.getAllCreditCards(CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

    if (retrievedCreditCards.isNotEmpty) {

      listOfCreditCards.addAll(retrievedCreditCards);

    }

    return listOfCreditCards;
  }

  Future processCreditCardsBalance(ChequesData chequesData) async {

    if (chequesData.chequeTransactionType == ChequesData.TransactionType_Send) {

      var creditCardsDatabaseQueries = CreditCardsDatabaseQueries();

      var sourceCreditCardData = await creditCardsDatabaseQueries.extractTransactionsQuery(
          await creditCardsDatabaseQueries.querySpecificCreditCardByCardNumber(controllerChequeSourceAccount.text, CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId)
      );

      var newCardBalance = (int.parse(sourceCreditCardData.cardBalance) - int.parse(chequesData.chequeMoneyAmount)).toString();

      var creditCardsDatabaseInputs = CreditCardsDatabaseInputs();

      creditCardsDatabaseInputs.updateCreditCardsData(
        CreditCardsData(
            id: sourceCreditCardData.id,
            cardNumber: sourceCreditCardData.cardNumber,
            cardExpiry: sourceCreditCardData.cardExpiry,
            cardHolderName: sourceCreditCardData.cardHolderName,
            cvv: sourceCreditCardData.cvv,
            bankName: sourceCreditCardData.bankName,
            cardBalance: newCardBalance,
            colorTag: sourceCreditCardData.colorTag
        ),
        CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId
      );

    } else if (transactionType == ChequesData.TransactionType_Receive) {

      var creditCardsDatabaseQueries = CreditCardsDatabaseQueries();

      var sourceCreditCardData = await creditCardsDatabaseQueries.extractTransactionsQuery(
          await creditCardsDatabaseQueries.querySpecificCreditCardByCardNumber(controllerChequeTargetAccount.text, CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId)
      );

      var newCardBalance = (int.parse(sourceCreditCardData.cardBalance) + int.parse(chequesData.chequeMoneyAmount)).toString();

      var creditCardsDatabaseInputs = CreditCardsDatabaseInputs();

      creditCardsDatabaseInputs.updateCreditCardsData(
          CreditCardsData(
              id: sourceCreditCardData.id,
              cardNumber: sourceCreditCardData.cardNumber,
              cardExpiry: sourceCreditCardData.cardExpiry,
              cardHolderName: sourceCreditCardData.cardHolderName,
              cvv: sourceCreditCardData.cvv,
              bankName: sourceCreditCardData.bankName,
              cardBalance: newCardBalance,
              colorTag: sourceCreditCardData.colorTag
          ),
          CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId
      );

    }

  }

  Future processBudgetBalance(ChequesData chequesData) async {

    if (chequesData.chequeTransactionType == ChequesData.TransactionType_Send) {

      var budgetsDatabaseQueries = BudgetsDatabaseQueries();

      var budgetData = await budgetsDatabaseQueries.extractBudgetsQuery(
          await budgetsDatabaseQueries.querySpecificBudgetsByName(controllerChequeSourceAccount.text, CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId)
      );

      var newBudgetBalance = (int.parse(budgetData.budgetBalance) - int.parse(chequesData.chequeMoneyAmount)).toString();

      var budgetsDatabaseInputs = BudgetsDatabaseInputs();

      budgetsDatabaseInputs.updateBudgetData(
          BudgetsData(
              id: budgetData.id,
              budgetName: budgetData.budgetName,
              budgetDescription: budgetData.budgetDescription,
              budgetBalance: newBudgetBalance,
              colorTag: budgetData.colorTag
          ),
          CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId
      );

    } else if (transactionType == ChequesData.TransactionType_Receive) {

      var budgetsDatabaseQueries = BudgetsDatabaseQueries();

      var budgetData = await budgetsDatabaseQueries.extractBudgetsQuery(
          await budgetsDatabaseQueries.querySpecificBudgetsByName(controllerChequeSourceAccount.text, CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId)
      );

      var newBudgetBalance = (int.parse(budgetData.budgetBalance) + int.parse(chequesData.chequeMoneyAmount)).toString();

      var budgetsDatabaseInputs = BudgetsDatabaseInputs();

      budgetsDatabaseInputs.updateBudgetData(
          BudgetsData(
              id: budgetData.id,
              budgetName: budgetData.budgetName,
              budgetDescription: budgetData.budgetDescription,
              budgetBalance: newBudgetBalance,
              colorTag: budgetData.colorTag
          ),
          CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId
      );

    }

  }

  Future processAddTransaction(ChequesData chequesData) async {

    String transactionType = TransactionsData.TransactionType_Send;

    if (chequesData.chequeTransactionType == ChequesData.TransactionType_Send) {

      transactionType = TransactionsData.TransactionType_Send;

    } else if (transactionType == ChequesData.TransactionType_Receive) {

      transactionType = TransactionsData.TransactionType_Receive;

    }

    TransactionsData transactionsData = TransactionsData(
        id: chequesData.id,
        transactionTitle: chequesData.chequeTitle,
        transactionDescription: chequesData.chequeDescription,
        sourceCardNumber: chequesData.chequeSourceAccountNumber,
        targetCardNumber: chequesData.chequeTargetAccountNumber,
        sourceBankName: chequesData.chequeSourceBankName,
        targetBankName: chequesData.chequeTargetBankName,
        sourceUsername: chequesData.chequeSourceName,
        targetUsername: chequesData.chequeTargetName,
        amountMoney: chequesData.chequeMoneyAmount,
        transactionType: transactionType,
        transactionTimeMillisecond: int.parse(chequesData.chequeDueMillisecond),
        transactionTime: chequesData.chequeDueDate,
        transactionTimeYear: DateTime(int.parse(chequesData.chequeDueMillisecond)).year.toString(),
        transactionTimeMonth: DateTime(int.parse(chequesData.chequeDueMillisecond)).month.toString(),
        colorTag: chequesData.colorTag,
        budgetName: chequesData.chequeRelevantBudget
    );

    TransactionsDatabaseInputs transactionsDatabaseInputs = TransactionsDatabaseInputs();

    transactionsDatabaseInputs.insertTransactionData(transactionsData, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);

  }

  Future addChequeReminder(DateTime reminderTime, String chequeTitle, String chequeDescription, String bankNameBranch) async {

    Add2Calendar.addEvent2Cal(Event(
        title: chequeTitle,
        description: chequeDescription,
        location: bankNameBranch,
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
          endDate: reminderTime,
        )
    ));

  }

}
