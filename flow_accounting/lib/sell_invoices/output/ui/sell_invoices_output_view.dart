
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
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/products/input/ui/products_input_view.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/sell_invoices/database/io/inputs.dart';
import 'package:flow_accounting/sell_invoices/database/io/queries.dart';
import 'package:flow_accounting/sell_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/sell_invoices/input/ui/sell_invoices_input_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee/marquee.dart';
import 'package:sqflite/sqflite.dart';

class SellInvoicesOutputView extends StatefulWidget {
  const SellInvoicesOutputView({Key? key}) : super(key: key);

  @override
  _SellInvoicesOutputViewState createState() => _SellInvoicesOutputViewState();
}
class _SellInvoicesOutputViewState extends State<SellInvoicesOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<SellInvoicesData> allSellInvoices = [];
  List<Widget> allSellInvoicesItems = [];

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool colorSelectorInitialized = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    retrieveAllSellInvoices(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    colorSelectorView.selectedColorNotifier.addListener(() {

      filterByColorTag(context, allSellInvoices, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
    allListContentWidgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: colorSelectorView,
    ));
    allListContentWidgets.addAll(allSellInvoicesItems);

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
                      top: 19,
                      right: 13,
                      child: SizedBox(
                        height: 43,
                        width: 321,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              flex: 11,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                              ),
                            ),
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

                                        sortSellInvoicesByAmount(context, allSellInvoices);

                                      },
                                      child: SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.invoicesAmountHigh(),
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

                                        retrieveAllSellInvoices(context);

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
                        child: Transform.scale(
                          scale: 1.1,
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

                                      searchSellInvoices(context, allSellInvoices, searchQuery);

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

                                            searchSellInvoices(context, allSellInvoices, searchQuery);

                                          },
                                          decoration: InputDecoration(
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
                                            hintText: StringsResources.searchHintText(),
                                            hintStyle: TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 13.0
                                            ),
                                            labelText: StringsResources.searchText(),
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

  Widget outputItem(BuildContext context, SellInvoicesData sellInvoicesData) {

    Color budgetColorTag = Color(sellInvoicesData.colorTag);

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              deleteSellInvoices(context, sellInvoicesData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.gameGeeksEmpire,
            icon: Icons.delete_rounded,
            label: StringsResources.deleteText(),
            autoClose: true,
          ),
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              editSellInvoices(context, sellInvoicesData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.applicationGeeksEmpire,
            icon: Icons.edit_rounded,
            label: StringsResources.editText(),
            autoClose: true,
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) async {

              ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

              ProductsData productsData = await productsDatabaseQueries.querySpecificProductById(sellInvoicesData.soldProductId, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

              NavigationProcess().goTo(context, ProductsInputView(productsData: productsData));

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.greenGray,
            icon: Icons.shopping_bag_rounded,
            label: StringsResources.invoicesProduct(),
            autoClose: true,
          ),
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) async {

              returningInvoicesProcess();

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.greenGray,
            icon: Icons.shopping_bag_rounded,
            label: StringsResources.returnInvoice(),
            autoClose: true,
          ),
        ],
      ),
      child: Padding(
        padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
        child: PhysicalModel(
          color: ColorsResources.light,
          elevation: 7,
          shadowColor: budgetColorTag.withOpacity(0.79),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: InkWell(
            onTap: () {

              editSellInvoices(context, sellInvoicesData);

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
                              padding: const EdgeInsets.fromLTRB(27, 17, 13, 0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Marquee(
                                    text: sellInvoicesData.soldProductPrice,
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
                              )
                            )
                          ),
                          SizedBox(
                              height: 39,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(37, 11, 19, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            sellInvoicesData.sellInvoiceNumber,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 19,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            sellInvoicesData.sellInvoiceDateText,
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: ColorsResources.darkTransparent,
                                              fontSize: 14,
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
                              padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          sellInvoicesData.soldProductName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: ColorsResources.dark.withOpacity(0.537),
                                              fontSize: 15
                                          ),
                                        )
                                    )
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            sellInvoicesData.soldProductQuantity,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ColorsResources.dark.withOpacity(0.537),
                                                fontSize: 15
                                            ),
                                          )
                                      )
                                  ),
                                ],
                              )
                            )
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
                                      budgetColorTag.withOpacity(0.7),
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
                      )
                    ],
                  )
              )
            )
          )
        )
      )
    );

  }

  void deleteSellInvoices(BuildContext context, SellInvoicesData sellInvoicesData) async {

    String databaseDirectory = await getDatabasesPath();

    String sellInvoiceDatabasePath = "${databaseDirectory}/${SellInvoicesDatabaseInputs.sellInvoicesDatabase()}";

    bool sellInvoicesDatabaseExist = await databaseExists(sellInvoiceDatabasePath);

    if (sellInvoicesDatabaseExist) {

      var databaseQueries = SellInvoicesDatabaseQueries();

      databaseQueries.queryDeleteSellInvoice(
          sellInvoicesData.id, SellInvoicesDatabaseInputs.databaseTableName,
          UserInformation.UserId);

      retrieveAllSellInvoices(context);

    }

  }

  void editSellInvoices(BuildContext context, SellInvoicesData sellInvoicesData) async {

    bool sellInvoiceDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SellInvoicesInputView(sellInvoicesData: sellInvoicesData)),
    );

    debugPrint("Sell Invoices Data Update => ${sellInvoiceDataUpdated}");
    if (sellInvoiceDataUpdated) {

      retrieveAllSellInvoices(context);

    }

  }

  void retrieveAllSellInvoices(BuildContext context) async {

    if (allSellInvoicesItems.isNotEmpty) {

      allSellInvoicesItems.clear();

    }

    String databaseDirectory = await getDatabasesPath();

    String sellInvoicesDatabasePath = "${databaseDirectory}/${SellInvoicesDatabaseInputs.sellInvoicesDatabase()}";

    bool sellInvoiceDatabaseExist = await databaseExists(sellInvoicesDatabasePath);

    if (sellInvoiceDatabaseExist) {

      List<Widget> preparedAllSellInvoicesItem = [];

      var databaseQueries = SellInvoicesDatabaseQueries();

      allSellInvoices = await databaseQueries.getAllSellInvoices(SellInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

      for (var element in allSellInvoices) {

        preparedAllSellInvoicesItem.add(outputItem(context, element));

      }

      colorSelectorInitialized = false;

      setState(() {

        allSellInvoicesItems = preparedAllSellInvoicesItem;

      });

    }

  }

  void sortSellInvoicesByAmount(BuildContext context, List<SellInvoicesData> inputSellInvoicesDataList) {

    if (allSellInvoicesItems.isNotEmpty) {

      allSellInvoicesItems.clear();

    }
    inputSellInvoicesDataList.sort((a, b) => (a.soldProductPrice).compareTo(b.soldProductPrice));

    List<Widget> preparedAllSellInvoicesItem = [];

    for (var element in inputSellInvoicesDataList) {

      preparedAllSellInvoicesItem.add(outputItem(context, element));

    }

    setState(() {

      allSellInvoicesItems = preparedAllSellInvoicesItem;

    });

  }

  void filterByColorTag(BuildContext context,
      List<SellInvoicesData> inputSellInvoicesList, Color colorQuery) {

    List<SellInvoicesData> searchResult = [];

    for (var element in inputSellInvoicesList) {

      if (element.colorTag == colorQuery.value) {

        searchResult.add(element);

      }

      List<Widget> preparedAllSellInvoicesItem = [];

      for (var element in searchResult) {

        preparedAllSellInvoicesItem.add(outputItem(context, element));

      }

      setState(() {

        allSellInvoicesItems = preparedAllSellInvoicesItem;

      });

    }

  }

  void searchSellInvoices(BuildContext context,
      List<SellInvoicesData> inputSellInvoicesList, String searchQuery) {

    List<SellInvoicesData> searchResult = [];

    for (var element in inputSellInvoicesList) {

      if (element.sellInvoiceNumber.contains(searchQuery) ||
          element.sellInvoiceDateText.contains(searchQuery) ||
          element.sellInvoiceDescription.contains(searchQuery) ||
          element.soldProductId.contains(searchQuery) ||
          element.soldProductName.contains(searchQuery) ||
          element.soldProductQuantity.contains(searchQuery) ||
          element.soldProductPrice.contains(searchQuery) ||
          element.soldProductEachPrice.contains(searchQuery) ||
          element.soldProductPriceDiscount.contains(searchQuery) ||
          element.paidTo.contains(searchQuery) ||
          element.soldTo.contains(searchQuery) ||
          element.sellPreInvoice.contains(searchQuery)
      ) {

        searchResult.add(element);

      }

      List<Widget> preparedAllSellInvoicesItem = [];

      for (var element in searchResult) {

        preparedAllSellInvoicesItem.add(outputItem(context, element));

      }

      setState(() {

        allSellInvoicesItems = preparedAllSellInvoicesItem;

      });

    }

  }

  void returningInvoicesProcess() {

    // Change Product Stock
    // Change Relevant Credit Card Balance

  }

}