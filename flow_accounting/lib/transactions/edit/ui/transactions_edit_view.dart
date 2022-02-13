/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/23/22, 4:13 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/calendar/ui/calendar_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransactionsEditView extends StatefulWidget {

  final TransactionsData transactionsData;

  const TransactionsEditView({Key? key, required this.transactionsData}) : super(key: key);

  @override
  _TransactionsEditViewState createState() => _TransactionsEditViewState();
}
class _TransactionsEditViewState extends State<TransactionsEditView> {

  TextEditingController controllerMoneyAmount = TextEditingController();

  TextEditingController controllerTransactionSourceName = TextEditingController();
  TextEditingController controllerTransactionSourceBank = TextEditingController();
  TextEditingController controllerTransactionSourceCard = TextEditingController();

  TextEditingController controllerTransactionTargetName = TextEditingController();
  TextEditingController controllerTransactionTargetBank = TextEditingController();
  TextEditingController controllerTransactionTargetCard = TextEditingController();

  TextEditingController controllerBudget = TextEditingController();

  String transactionType = TransactionsData.TransactionType_Send;

  String budgetName = TransactionsData.TransactionBudgetName;

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

    CalendarView calendarView = CalendarView();
    calendarView.inputDateTime = widget.transactionsData.transactionTime;

    ColorSelectorView colorSelectorView = ColorSelectorView();
    colorSelectorView.inputColor = Color(widget.transactionsData.colorTag);

    controllerMoneyAmount.text = widget.transactionsData.amountMoney;

    controllerTransactionSourceName.text = widget.transactionsData.sourceUsername;
    controllerTransactionSourceBank.text = widget.transactionsData.sourceBankName;
    controllerTransactionSourceCard.text = widget.transactionsData.sourceCardNumber;

    controllerTransactionTargetName.text = widget.transactionsData.targetUsername;
    controllerTransactionTargetBank.text = widget.transactionsData.targetBankName;
    controllerTransactionTargetCard.text = widget.transactionsData.targetCardNumber;

    controllerBudget.text = widget.transactionsData.budgetName;

    if (widget.transactionsData.transactionType == TransactionsData.TransactionType_Send) {

      transactionType = StringsResources.transactionTypeSend;

    } else if (widget.transactionsData.transactionType == TransactionsData.TransactionType_Receive) {

      transactionType = StringsResources.transactionTypeReceive;

    } else {

      transactionType = StringsResources.transactionTypeSend;

    }

    return MaterialApp (
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
                          StringsResources.featureTransactionsTitle,
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
                          StringsResources.featureTransactionsDescription,
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
                                      controller: controllerMoneyAmount,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.transactionAmount,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.transactionAmountHint,
                                        hintStyle: TextStyle(
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
                        height: 99,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 4, 0, 0),
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
                                      child: calendarView,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(7, 0, 13, 0),
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
                                          filled: true,
                                          fillColor: ColorsResources.lightTransparent,
                                          focusColor: ColorsResources.dark
                                      ),
                                      value: transactionType,
                                      autovalidateMode: AutovalidateMode.always,
                                      validator: (value) => value == null ?
                                      StringsResources.transactionTypeHint : StringsResources.transactionTypeHint,
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

                                          transactionType = TransactionsData.TransactionType_Receive;

                                        } else if (value.toString() == StringsResources.transactionTypeSend) {

                                          transactionType = TransactionsData.TransactionType_Send;

                                        }

                                      },

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

                                          return await getCustomersNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(title: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              suggestion,
                                              style: const TextStyle(
                                                  color: ColorsResources.darkTransparent,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ));
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerTransactionTargetName.text = suggestion.toString();

                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerTransactionTargetName,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionTargetName,
                                            labelStyle: TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionTargetNameHint,
                                            hintStyle: TextStyle(
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

                                          return await getCustomersNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(title: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              suggestion,
                                              style: const TextStyle(
                                                  color: ColorsResources.darkTransparent,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ));
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerTransactionSourceName.text = suggestion.toString();

                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerTransactionSourceName,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionSourceName,
                                            labelStyle: TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionSourceNameHint,
                                            hintStyle: TextStyle(
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

                                          return ListTile(title: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              suggestion,
                                              style: const TextStyle(
                                                  color: ColorsResources.darkTransparent,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ));
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerTransactionSourceBank.text = suggestion.toString();

                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerTransactionSourceBank,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionSourceBank,
                                            labelStyle: TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionSourceBankHint,
                                            hintStyle: TextStyle(
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

                                          return ListTile(title: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              suggestion,
                                              style: const TextStyle(
                                                  color: ColorsResources.darkTransparent,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ));
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerTransactionTargetBank.text = suggestion.toString();

                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerTransactionTargetBank,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionTargetBank,
                                            labelStyle: TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionTargetBankHint,
                                            hintStyle: TextStyle(
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
                                    child: TextField(
                                      controller: controllerTransactionSourceCard,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.transactionSourceCard,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.transactionSourceCardHint,
                                        hintStyle: TextStyle(
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
                        height: 7,
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
                                      controller: controllerTransactionTargetCard,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.transactionTargetCard,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.transactionTargetCardHint,
                                        hintStyle: TextStyle(
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
                                    child: TypeAheadField<String>(
                                        suggestionsCallback: (pattern) async {

                                          return await getBudgetNames();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(title: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              suggestion,
                                              style: const TextStyle(
                                                  color: ColorsResources.darkTransparent,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ));
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerBudget.text = suggestion.toString();
                                          budgetName = suggestion.toString();

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
                                          decoration: const InputDecoration(
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(13),
                                                    topRight: Radius.circular(13),
                                                    bottomLeft: Radius.circular(13),
                                                    bottomRight: Radius.circular(13)
                                                ),
                                                gapPadding: 5
                                            ),
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.transactionBudgetName,
                                            labelStyle: TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.transactionBudgetNameHint,
                                            hintStyle: TextStyle(
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

                          int timeNow = DateTime.now().millisecondsSinceEpoch;

                          var databaseInputs = TransactionsDatabaseInputs();

                          TransactionsData transactionData = TransactionsData(
                            id: timeNow,

                            amountMoney: controllerMoneyAmount.text,
                            transactionType: transactionType,
                            transactionTime: calendarView.pickedDataTimeText,

                            sourceUsername: controllerTransactionSourceName.text,
                            sourceBankName: controllerTransactionSourceBank.text,
                            sourceCardNumber: controllerTransactionSourceCard.text,

                            targetUsername: controllerTransactionTargetName.text,
                            targetBankName: controllerTransactionTargetBank.text,
                            targetCardNumber: controllerTransactionTargetCard.text,

                            colorTag: colorSelectorView.selectedColor.value,

                            budgetName: budgetName,
                          );

                          databaseInputs.updateTransactionData(transactionData, TransactionsDatabaseInputs.databaseTableName);

                          Fluttertoast.showToast(
                              msg: StringsResources.updatedText,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorsResources.lightTransparent,
                              textColor: ColorsResources.dark,
                              fontSize: 16.0
                          );

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
                                        StringsResources.editText,
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

  Future<List<String>> getCustomersNames() async {

    String mySelf = StringsResources.mySelfText;

    List<String> listOfNames = [];
    listOfNames.add(mySelf);
    listOfNames.addAll(["Test", "Aban", "Elias", "One", "Mr. Fazel", "Geeks Empire"]);

    return listOfNames;
  }

  Future<List<String>> getBanksNames() async {

    return StringsResources.listOfBanksIran;
  }

  Future<List<String>> getBudgetNames() async {

    String noBudget = StringsResources.noBudgetText;

    List<String> listOfBudgets = [];
    listOfBudgets.add(noBudget);
    listOfBudgets.addAll(["آکواریم", "شرکت", "خانه", "گربه"]);

    return listOfBudgets;
  }

}
