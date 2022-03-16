
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/16/22, 8:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:flow_accounting/home/interface/dashboard.dart';
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/products/input/ui/products_input_view.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/input/ui/transactions_input_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/extensions/CreditCardNumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee/marquee.dart';

class ProductsOutputView extends StatefulWidget {

  String? initialSearchQuery;

  ProductsOutputView({Key? key, this.initialSearchQuery}) : super(key: key);

  @override
  _ProductsOutputViewState createState() => _ProductsOutputViewState();
}
class _ProductsOutputViewState extends State<ProductsOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<ProductsData> allTransactions = [];
  List<Widget> allProductsItems = [];

  TextEditingController controllerTransactionTitle = TextEditingController();

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool transactionDataUpdated = false;

  @override
  void initState() {

    if (widget.initialSearchQuery != null) {

      textEditorControllerQuery.text = widget.initialSearchQuery!;

      searchTransactionsInitially(context, widget.initialSearchQuery!);

    } else {

      retrieveAllProducts(context);

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

    Navigator.pop(context, transactionDataUpdated);

    return true;
  }

  @override
  Widget build(BuildContext context) {

    colorSelectorView.selectedColorNotifier.addListener(() {

      filterByColorTag(context, allTransactions, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
    allListContentWidgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: colorSelectorView,
    ));
    allListContentWidgets.addAll(allProductsItems);

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
                      ColorsResources.white,
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

                          UpdatedData.UpdatedDataType = UpdatedData.LatestTransactions;

                          Navigator.pop(context, transactionDataUpdated);

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
                      top: 19,
                      right: 13,
                      child: SizedBox(
                        height: 43,
                        width: 321,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 11,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 43,
                                      width: double.infinity,
                                      child: Blur(
                                        blur: 5,
                                        borderRadius: BorderRadius.circular(51),
                                        blurColor: Colors.white.withOpacity(0.3),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    ColorsResources.white.withOpacity(0.3),
                                                    ColorsResources.primaryColorLighter.withOpacity(0.3),
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
                                    InkWell(
                                      onTap: () {

                                        sortProductByPrice(context, allTransactions);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.sortTransactionAmountHigh,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: ColorsResources.applicationGeeksEmpire,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 11,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 43,
                                      width: double.infinity,
                                      child: Blur(
                                        blur: 5,
                                        borderRadius: BorderRadius.circular(51),
                                        blurColor: Colors.white.withOpacity(0.3),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    ColorsResources.white.withOpacity(0.3),
                                                    ColorsResources.primaryColorLighter.withOpacity(0.3),
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
                                    InkWell(
                                      onTap: () {

                                        sortProductsByProfit(context, allTransactions);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.sortTimeNew,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: ColorsResources.applicationGeeksEmpire,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 43,
                                    width: 43,
                                    child: Blur(
                                      blur: 3,
                                      borderRadius: BorderRadius.circular(51),
                                      blurColor: Colors.white.withOpacity(0.3),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorsResources.white.withOpacity(0.3),
                                                  ColorsResources.primaryColorLighter.withOpacity(0.3),
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
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {

                                        retrieveAllProducts(context);

                                      },
                                      child: const Icon(
                                          Icons.refresh_rounded,
                                          size: 31.0,
                                          color: ColorsResources.primaryColorDark
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 19,
                    left: 11,
                    right: 11,
                    child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 73,
                          width: 219,
                          child: Stack(
                            children: [
                              const Image(
                                image: AssetImage("search_shape.png"),
                                height: 73,
                                width: 213,
                                color: ColorsResources.primaryColorDark,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {

                                    String searchQuery = textEditorControllerQuery.text;

                                    searchTransactions(context, allTransactions, searchQuery);

                                  },
                                  child: const SizedBox(
                                    height: 71,
                                    width: 53,
                                    child: Icon(
                                      Icons.search_rounded,
                                      size: 23,
                                      color: ColorsResources.darkTransparent,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                    width: 153,
                                    height: 47,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextField(
                                        controller: textEditorControllerQuery,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        maxLines: 1,
                                        cursorColor: ColorsResources.primaryColor,
                                        autocorrect: true,
                                        autofocus: false,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (searchQuery) {

                                          searchTransactions(context, allTransactions, searchQuery);

                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(51),
                                                  topRight: Radius.circular(51),
                                                  bottomLeft: Radius.circular(51),
                                                  bottomRight: Radius.circular(51)
                                              ),
                                              gapPadding: 5
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(51),
                                                  topRight: Radius.circular(51),
                                                  bottomLeft: Radius.circular(51),
                                                  bottomRight: Radius.circular(51)
                                              ),
                                              gapPadding: 5
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(51),
                                                  topRight: Radius.circular(51),
                                                  bottomLeft: Radius.circular(51),
                                                  bottomRight: Radius.circular(51)
                                              ),
                                              gapPadding: 5
                                          ),
                                          hintText: StringsResources.searchTransactionsText,
                                          hintStyle: TextStyle(
                                              color: ColorsResources.darkTransparent,
                                              fontSize: 13.0
                                          ),
                                          labelText: StringsResources.searchText,
                                          labelStyle: TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 15.0
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget outputItem(BuildContext context, TransactionsData transactionsData) {

    String transactionTypeMark = TransactionsData.TransactionType_Send;
    Color transactionTypeColor = ColorsResources.dark;

    String transactionCardNumber = transactionsData.sourceCardNumber;

    String transactionName = transactionsData.sourceUsername;
    String transactionBank = transactionsData.sourceBankName;

    Color transactionColorTag = Color(transactionsData.colorTag);

    switch (transactionsData.transactionType) {
      case TransactionsData.TransactionType_Send: {

        transactionTypeMark = TransactionsData.TransactionType_Send;
        transactionTypeColor = Colors.red;

        transactionName = transactionsData.targetUsername;

        break;
      }
      case TransactionsData.TransactionType_Receive: {

        transactionTypeMark = TransactionsData.TransactionType_Receive;
        transactionTypeColor = Colors.green;

        transactionName = transactionsData.sourceUsername;

        break;
      }
    }

    if (transactionsData.transactionDescription.isNotEmpty) {

      controllerTransactionTitle.text = transactionsData.transactionDescription;

    } else {

      controllerTransactionTitle.text = transactionsData.transactionTitle;

    }

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              deleteTransaction(context, transactionsData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.gameGeeksEmpire,
            icon: Icons.delete_rounded,
            label: StringsResources.deleteText,
            autoClose: true,
          ),
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              editTransaction(context, transactionsData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.applicationGeeksEmpire,
            icon: Icons.edit_rounded,
            label: StringsResources.editText,
            autoClose: true,
          ),
        ],
      ),
      child: Padding(
        padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
        child: PhysicalModel(
          color: ColorsResources.light,
          elevation: 7,
          shadowColor: transactionColorTag.withOpacity(0.7),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: InkWell(
            onTap: () {

              editTransaction(context, transactionsData);

            },
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 99,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 19,
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
                                          padding: const EdgeInsets.fromLTRB(27,
                                              11, 13, 0),
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Marquee(
                                                text: transactionsData.amountMoney,
                                                style: const TextStyle(
                                                  color: ColorsResources.dark,
                                                  fontSize: 31,
                                                  fontFamily: "Numbers",
                                                ),
                                                scrollAxis: Axis.horizontal,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                blankSpace: 173.0,
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
                                            padding: const EdgeInsets.fromLTRB(13, 11, 13, 0),
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
                                                        transactionName,
                                                        style: TextStyle(
                                                          color: ColorsResources.dark.withOpacity(0.579),
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Directionality(
                                                    textDirection: TextDirection.rtl,
                                                    child: Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Text(
                                                        transactionBank,
                                                        style: TextStyle(
                                                          color: ColorsResources.dark.withOpacity(0.579),
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: SizedBox(
                                        height: 27,
                                        width: 79,
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(17),
                                                  bottomLeft: Radius.circular(17),
                                                  bottomRight: Radius.circular(0)
                                              ),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    ColorsResources.light,
                                                    transactionColorTag.withOpacity(0.7),
                                                  ],
                                                  begin: const FractionalOffset(0.0, 0.0),
                                                  end: const FractionalOffset(1.0, 0.0),
                                                  stops: const [0.0, 1.0],
                                                  transform: const GradientRotation(-45),
                                                  tileMode: TileMode.clamp
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                transactionsData.budgetName,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: ColorsResources.dark,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: transactionTypeColor.withOpacity(0.3),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      transactionTypeMark,
                                      style: TextStyle(
                                          color: transactionTypeColor,
                                          fontSize: 65
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 9, 7, 9),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: controllerTransactionTitle,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          cursorColor: ColorsResources.primaryColor,
                          style: const TextStyle(
                            fontSize: 13,
                            color: ColorsResources.applicationDarkGeeksEmpire
                          ),
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            enabled: false,
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
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsResources.white, width: 1.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13),
                                    bottomLeft: Radius.circular(13),
                                    bottomRight: Radius.circular(13)
                                ),
                                gapPadding: 5
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsResources.white, width: 1.0),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13),
                                    bottomLeft: Radius.circular(13),
                                    bottomRight: Radius.circular(13)
                                ),
                                gapPadding: 5
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: ColorsResources.white, width: 1.0),
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

                            labelText: StringsResources.descriptionText,
                            labelStyle: TextStyle(
                              color: ColorsResources.dark,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold
                            ),
                            hintText: StringsResources.descriptionText,
                            hintStyle: TextStyle(
                              color: ColorsResources.dark,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 51,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 13,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                            child: Container(
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  prepareCreditCard(transactionCardNumber),
                                  style: const TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                            child: Container(
                              color: Colors.transparent,
                              child: Align(
                                alignment: Alignment.center,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    transactionsData.transactionTime,
                                    style: TextStyle(
                                        color: ColorsResources.dark.withOpacity(0.59),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );

  }

  void deleteTransaction(BuildContext context, ProductsData productsData) async {

    var databaseQueries = ProductsDatabaseQueries();

    databaseQueries.queryDeleteProduct(productsData.id, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

    retrieveAllProducts(context);

    transactionDataUpdated = true;

  }

  void editTransaction(BuildContext context, ProductsData productsData) async {

    bool productDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductsInputView(productsData: productsData)),
    );

    debugPrint("Transaction Data Update => ${productDataUpdated}");
    if (productDataUpdated) {

      productDataUpdated = true;

      retrieveAllProducts(context);

    }

  }

  void retrieveAllProducts(BuildContext context) async {

    if (allProductsItems.isNotEmpty) {

      allProductsItems.clear();

    }

    List<Widget> preparedAllTransactionsItem = [];

    var databaseQueries = ProductsDatabaseQueries();

    allTransactions = await databaseQueries.getAllProducts(ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

    for (var element in allTransactions) {

      preparedAllTransactionsItem.add(outputItem(context, element));

    }

    setState(() {

      allProductsItems = preparedAllTransactionsItem;

    });

  }

  void sortProductsByProfit(BuildContext context,
      List<ProductsData> inputTransactionsList) {

    if (allProductsItems.isNotEmpty) {

      allProductsItems.clear();

    }

    inputTransactionsList.sort((a, b) => (a.productProfitPercent).compareTo(b.productProfitPercent));

    List<Widget> preparedAllProductsItem = [];

    for (var element in inputTransactionsList) {

      preparedAllProductsItem.add(outputItem(context, element));

    }

    setState(() {

      allProductsItems = preparedAllProductsItem;

    });

  }

  void sortProductByPrice(BuildContext context,
      List<ProductsData> inputTransactionsList) {

    if (allProductsItems.isNotEmpty) {

      allProductsItems.clear();

    }
    inputTransactionsList.sort((a, b) => (a.productPrice).compareTo(b.productPrice));

    List<Widget> preparedAllProductsItem = [];

    for (var element in inputTransactionsList) {

      preparedAllProductsItem.add(outputItem(context, element));

    }

    setState(() {

      allProductsItems = preparedAllProductsItem;

    });

  }

  void filterByColorTag(BuildContext context,
      List<ProductsData> inputProductsList, Color colorQuery) {

    List<ProductsData> searchResult = [];

    for (var element in inputProductsList) {

      if (element.colorTag == colorQuery.value) {

        searchResult.add(element);

      }

      List<Widget> preparedAllTransactionsItem = [];

      for (var element in searchResult) {

        preparedAllTransactionsItem.add(outputItem(context, element));

      }

      setState(() {

        allProductsItems = preparedAllTransactionsItem;

      });

    }

  }

  void searchTransactions(BuildContext context,
      List<ProductsData> inputTransactionsList, String searchQuery) {

    List<ProductsData> searchResult = [];

    for (var element in inputTransactionsList) {

      if (element.transactionTitle.contains(searchQuery) ||
          element.transactionDescription.contains(searchQuery) ||
          element.transactionTime.contains(searchQuery) ||
          element.sourceUsername.contains(searchQuery) ||
          element.sourceBankName.contains(searchQuery) ||
          element.sourceCardNumber.contains(searchQuery) ||
          element.targetUsername.contains(searchQuery) ||
          element.targetBankName.contains(searchQuery) ||
          element.targetCardNumber.contains(searchQuery) ||
          element.budgetName.contains(searchQuery)) {

        searchResult.add(element);

      }

      List<Widget> preparedAllTransactionsItem = [];

      for (var element in searchResult) {

        preparedAllTransactionsItem.add(outputItem(context, element));

      }

      setState(() {

        allProductsItems = preparedAllTransactionsItem;

      });

    }

  }

  void searchTransactionsInitially(BuildContext context, String searchQuery) async {

    List<ProductsData> searchResult = [];

    var databaseQueries = ProductsDatabaseQueries();

    allTransactions = await databaseQueries.getAllProducts(ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

    for (var element in allTransactions) {

      if (element.transactionTime.contains(searchQuery) ||
          element.sourceUsername.contains(searchQuery) ||
          element.sourceBankName.contains(searchQuery) ||
          element.sourceCardNumber.contains(searchQuery) ||
          element.targetUsername.contains(searchQuery) ||
          element.targetBankName.contains(searchQuery) ||
          element.targetCardNumber.contains(searchQuery) ||
          element.budgetName.contains(searchQuery)) {

        searchResult.add(element);

      }

      List<Widget> preparedAllTransactionsItem = [];

      for (var element in searchResult) {

        preparedAllTransactionsItem.add(outputItem(context, element));

      }

      setState(() {

        allProductsItems = preparedAllTransactionsItem;

      });

    }

  }

}