
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
import 'package:flow_accounting/buy_invoices/database/io/inputs.dart';
import 'package:flow_accounting/buy_invoices/database/io/queries.dart';
import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/buy_invoices/input/ui/buy_invoices_input_view.dart';
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee/marquee.dart';
import 'package:sqflite/sqflite.dart';

class BuyInvoicesOutputView extends StatefulWidget {
  const BuyInvoicesOutputView({Key? key}) : super(key: key);

  @override
  _BuyInvoiceViewState createState() => _BuyInvoiceViewState();
}
class _BuyInvoiceViewState extends State<BuyInvoicesOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<BuyInvoicesData> allBuyInvoices = [];
  List<Widget> allBuyInvoicesItems = [];

  Widget invoiceCompleteReturned = Container();

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool colorSelectorInitialized = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    retrieveAllBuyInvoices(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    colorSelectorView.selectedColorNotifier.addListener(() {

      filterByColorTag(context, allBuyInvoices, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
    allListContentWidgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: colorSelectorView,
    ));
    allListContentWidgets.addAll(allBuyInvoicesItems);

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

                                        sortBuyInvoicesByAmount(context, allBuyInvoices);

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

                                        retrieveAllBuyInvoices(context);

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

                                      searchBuyInvoices(context, allBuyInvoices, searchQuery);

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

                                            searchBuyInvoices(context, allBuyInvoices, searchQuery);

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

  Widget outputItem(BuildContext context, BuyInvoicesData buyInvoicesData) {

    if (buyInvoicesData.invoiceReturned == BuyInvoicesData.BuyInvoice_Returned) {

      invoiceCompleteReturned = Container(
        height: 151,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(17),
              topRight: Radius.circular(17),
              bottomLeft: Radius.circular(17),
              bottomRight: Radius.circular(17)
          ),
          color: ColorsResources.lightRed.withOpacity(0.57),
        ),
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            StringsResources.returnedInvoice(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorsResources.red,
              fontSize: 27,
              fontWeight: FontWeight.bold
            ),
          )
        )
      );

    }

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              deleteBuyInvoices(context, buyInvoicesData);

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

              editBuyInvoices(context, buyInvoicesData);

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

              returningInvoicesProcess(buyInvoicesData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.black,
            icon: Icons.assignment_return_rounded,
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
          shadowColor: Color(buyInvoicesData.colorTag).withOpacity(0.79),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: InkWell(
            onTap: () {

              editBuyInvoices(context, buyInvoicesData);

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
                                    text: buyInvoicesData.boughtProductPrice,
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
                                            buyInvoicesData.buyInvoiceNumber,
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
                                            buyInvoicesData.buyInvoiceDateText,
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
                              padding: const EdgeInsets.fromLTRB(31, 0, 19, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          buyInvoicesData.buyInvoiceDescription,
                                          textAlign: TextAlign.right,
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
                                      Color(buyInvoicesData.colorTag).withOpacity(0.7),
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
                      invoiceCompleteReturned
                    ],
                  )
              )
            )
          )
        )
      )
    );

  }

  void deleteBuyInvoices(BuildContext context, BuyInvoicesData buyInvoicesData) async {

    String databaseDirectory = await getDatabasesPath();

    String buyInvoiceDatabasePath = "${databaseDirectory}/${BuyInvoicesDatabaseInputs.buyInvoicesDatabase()}";

    bool buyInvoicesDatabaseExist = await databaseExists(buyInvoiceDatabasePath);

    if (buyInvoicesDatabaseExist) {

      var databaseQueries = BuyInvoicesDatabaseQueries();

      databaseQueries.queryDeleteBuyInvoice(
          buyInvoicesData.id, BuyInvoicesDatabaseInputs.databaseTableName,
          UserInformation.UserId);

      retrieveAllBuyInvoices(context);

    }

  }

  void editBuyInvoices(BuildContext context, BuyInvoicesData buyInvoicesData) async {

    bool buyInvoiceDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BuyInvoicesInputView(buyInvoicesData: buyInvoicesData)),
    );

    debugPrint("Buy Invoices Data Update => ${buyInvoiceDataUpdated}");
    if (buyInvoiceDataUpdated) {

      retrieveAllBuyInvoices(context);

    }

  }

  void retrieveAllBuyInvoices(BuildContext context) async {

    if (allBuyInvoicesItems.isNotEmpty) {

      allBuyInvoicesItems.clear();

    }

    String databaseDirectory = await getDatabasesPath();

    String buyInvoicesDatabasePath = "${databaseDirectory}/${BuyInvoicesDatabaseInputs.buyInvoicesDatabase()}";

    bool buyInvoiceDatabaseExist = await databaseExists(buyInvoicesDatabasePath);

    if (buyInvoiceDatabaseExist) {

      List<Widget> preparedAllBuyInvoicesItem = [];

      var databaseQueries = BuyInvoicesDatabaseQueries();

      allBuyInvoices = await databaseQueries.getAllBuyInvoices(BuyInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

      for (var element in allBuyInvoices) {

        preparedAllBuyInvoicesItem.add(outputItem(context, element));

      }

      colorSelectorInitialized = false;

      setState(() {

        allBuyInvoicesItems = preparedAllBuyInvoicesItem;

      });

    }

  }

  void sortBuyInvoicesByAmount(BuildContext context, List<BuyInvoicesData> inputBuyInvoicesDataList) {

    if (allBuyInvoicesItems.isNotEmpty) {

      allBuyInvoicesItems.clear();

    }
    inputBuyInvoicesDataList.sort((a, b) => (a.boughtProductPrice).compareTo(b.boughtProductPrice));

    List<Widget> preparedAllBuyInvoicesItem = [];

    for (var element in inputBuyInvoicesDataList) {

      preparedAllBuyInvoicesItem.add(outputItem(context, element));

    }

    setState(() {

      allBuyInvoicesItems = preparedAllBuyInvoicesItem;

    });

  }

  void filterByColorTag(BuildContext context,
      List<BuyInvoicesData> inputBuyInvoicesList, Color colorQuery) {

    List<BuyInvoicesData> searchResult = [];

    for (var element in inputBuyInvoicesList) {

      if (element.colorTag == colorQuery.value) {

        searchResult.add(element);

      }

      List<Widget> preparedAllBuyInvoicesItem = [];

      for (var element in searchResult) {

        preparedAllBuyInvoicesItem.add(outputItem(context, element));

      }

      setState(() {

        allBuyInvoicesItems = preparedAllBuyInvoicesItem;

      });

    }

  }

  void searchBuyInvoices(BuildContext context,
      List<BuyInvoicesData> inputBuyInvoicesList, String searchQuery) {

    List<BuyInvoicesData> searchResult = [];

    for (var element in inputBuyInvoicesList) {

      if (element.buyInvoiceNumber.contains(searchQuery) ||
          element.buyInvoiceDateText.contains(searchQuery) ||
          element.buyInvoiceDescription.contains(searchQuery) ||
          element.boughtProductId.contains(searchQuery) ||
          element.boughtProductName.contains(searchQuery) ||
          element.boughtProductQuantity.contains(searchQuery) ||
          element.boughtProductPrice.contains(searchQuery) ||
          element.boughtProductEachPrice.contains(searchQuery) ||
          element.boughtProductPriceDiscount.contains(searchQuery) ||
          element.paidBy.contains(searchQuery) ||
          element.boughtFrom.contains(searchQuery) ||
          element.buyPreInvoice.contains(searchQuery)
      ) {

        searchResult.add(element);

      }

      List<Widget> preparedAllBuyInvoicesItem = [];

      for (var element in searchResult) {

        preparedAllBuyInvoicesItem.add(outputItem(context, element));

      }

      setState(() {

        allBuyInvoicesItems = preparedAllBuyInvoicesItem;

      });

    }

  }

  void returningInvoicesProcess(BuyInvoicesData buyInvoicesData) async {

    var buyInvoicesDatabaseInputs = BuyInvoicesDatabaseInputs();

    buyInvoicesData.invoiceReturned = BuyInvoicesData.BuyInvoice_Returned;

    buyInvoicesDatabaseInputs.updateInvoiceData(buyInvoicesData, BuyInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);


    String databaseDirectory = await getDatabasesPath();

    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase()}";

    bool productsDatabaseExist = await databaseExists(productDatabasePath);

    if (productsDatabaseExist) {

      ProductsDatabaseInputs productsDatabaseInputs = ProductsDatabaseInputs();

      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      var allIds = buyInvoicesData.boughtProductId.split(",");

      var allNames = buyInvoicesData.boughtProductName.split(",");

      var allQuantities = buyInvoicesData.boughtProductQuantity.split(",");

      var allQuantitiesTypes = buyInvoicesData.productQuantityType.split(",");

      var allEachPrice = buyInvoicesData.boughtProductEachPrice.split(",");

      var index = 0;

      allIds.forEach((element) async {

        var aProduct = await productsDatabaseQueries.querySpecificProductById(element, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

        aProduct.productQuantity = aProduct.productQuantity + int.parse(allQuantities[index]);

        await productsDatabaseInputs.updateProductData(aProduct, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

        index++;

      });

    }

  }

}