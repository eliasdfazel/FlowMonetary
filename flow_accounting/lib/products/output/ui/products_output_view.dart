
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/19/22, 7:11 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:ui';

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
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite/sqflite.dart';

class ProductsOutputView extends StatefulWidget {

  String? initialSearchQuery;

  ProductsOutputView({Key? key, this.initialSearchQuery}) : super(key: key);

  @override
  _ProductsOutputViewState createState() => _ProductsOutputViewState();
}
class _ProductsOutputViewState extends State<ProductsOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<ProductsData> allProducts = [];
  List<Widget> allProductsItems = [];

  TextEditingController controllerTransactionTitle = TextEditingController();

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool transactionDataUpdated = false;

  @override
  void initState() {

    if (widget.initialSearchQuery != null) {

      textEditorControllerQuery.text = widget.initialSearchQuery!;

      searchProductsInitially(context, widget.initialSearchQuery!);

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

      filterByColorTag(context, allProducts, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
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
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 179, 0, 79),
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

                                        sortProductByPrice(context, allProducts);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.productSortByPrice,
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

                                        sortProductsByProfit(context, allProducts);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.productSortByProfit,
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
                    top: 67,
                    left: 13,
                    right: 13,
                    child: colorSelectorView,
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

                                      searchProducts(context, allProducts, searchQuery);

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

                                            searchProducts(context, allProducts, searchQuery);

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
                                            hintText: StringsResources.searchHintText,
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

  Widget outputItem(BuildContext context, ProductsData productsData) {

    String percentProfit = productsData.productProfitPercent.replaceAll("%", "");
    double profitMargin = (int.parse(productsData.productPrice) * int.parse(percentProfit)) / 100;
    double sellingPrice = int.parse(productsData.productPrice) + profitMargin;

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              deleteTransaction(context, productsData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.gameGeeksEmpire,
            icon: Icons.delete_rounded,
            label: StringsResources.deleteText,
            autoClose: true,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(13, 7, 13, 13),
        child: PhysicalModel(
          color: ColorsResources.light,
          elevation: 7,
          shadowColor: Color(productsData.colorTag).withOpacity(0.7),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: InkWell(
            onTap: () {

              editProduct(context, productsData);

            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)
                ),
                color: ColorsResources.light,
              ),
              child: SizedBox(
                height: 303,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              height: 131,
                              width: double.infinity,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(17),
                                          child: ColoredBox(
                                            color: ColorsResources.lightestBlue.withOpacity(0.73),
                                            child: Image.file(
                                              File(productsData.productImageUrl),
                                              fit: BoxFit.cover,
                                              height: 131,
                                              width: double.infinity,
                                            ),
                                          )
                                      ),
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(51),
                                          child: ColoredBox(
                                            color: ColorsResources.lightestBlue.withOpacity(0.73),
                                            child: Image.file(
                                              File(productsData.productBrandLogoUrl),
                                              fit: BoxFit.cover,
                                              height: 31,
                                              width: 31,
                                            ),
                                          )
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: 33,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(51),
                                                    topRight: Radius.circular(51),
                                                    bottomLeft: Radius.circular(51),
                                                    bottomRight: Radius.circular(51)
                                                ),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color(productsData.colorTag).withOpacity(0.53),
                                                      ColorsResources.light.withOpacity(0.79),
                                                    ],
                                                    begin: FractionalOffset(0.0, 0.0),
                                                    end: FractionalOffset(1.0, 0.0),
                                                    stops: [0.0, 1.0],
                                                    transform: GradientRotation(45),
                                                    tileMode: TileMode.clamp
                                                ),
                                              ),
                                              height: 31,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                                child: Align(
                                                  alignment: AlignmentDirectional.center,
                                                  child: Text(
                                                    productsData.productBrand,
                                                    style: TextStyle(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        fontSize: 15,
                                                        shadows: [
                                                          Shadow(
                                                              color: ColorsResources.white,
                                                              blurRadius: 3,
                                                              offset: Offset(-1, -1)
                                                          ),
                                                          Shadow(
                                                              color: ColorsResources.dark.withOpacity(0.31),
                                                              blurRadius: 5,
                                                              offset: Offset(1, 1)
                                                          )
                                                        ]
                                                    ),
                                                  ),
                                                ),
                                              )
                                          )
                                      )
                                    ],
                                  )
                              )
                          ),
                          SizedBox(
                              height: 31,
                              width: double.infinity,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          productsData.productName,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: ColorsResources.applicationDarkGeeksEmpire,
                                              fontSize: 17,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.white,
                                                    blurRadius: 3,
                                                    offset: Offset(-1, -1)
                                                ),
                                                Shadow(
                                                    color: ColorsResources.dark.withOpacity(0.31),
                                                    blurRadius: 5,
                                                    offset: Offset(1, 1)
                                                )
                                              ]
                                          ),
                                        ),
                                      )
                                  )
                              )
                          ),
                          SizedBox(
                              height: 51,
                              width: double.infinity,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                                  child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          productsData.productDescription,
                                          textAlign: TextAlign.end,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: ColorsResources.darkTransparent,
                                              fontSize: 13
                                          ),
                                        ),
                                      )
                                  )
                              )
                          ),
                          SizedBox(
                              height: 41,
                              width: double.infinity,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${sellingPrice}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorsResources.black,
                                          fontSize: 17,
                                          shadows: [
                                            Shadow(
                                                color: ColorsResources.white,
                                                blurRadius: 3,
                                                offset: Offset(-1, -1)
                                            ),
                                            Shadow(
                                                color: ColorsResources.dark.withOpacity(0.31),
                                                blurRadius: 5,
                                                offset: Offset(1, 1)
                                            )
                                          ]
                                      ),
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    )
                ),
              )
            ),
          ),
        ),
      )
    );

  }

  void deleteTransaction(BuildContext context, ProductsData productsData) async {

    String databaseDirectory = await getDatabasesPath();

    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase}";

    bool productsDatabaseExist = await databaseExists(productDatabasePath);

    if (productsDatabaseExist) {

      var databaseQueries = ProductsDatabaseQueries();

      databaseQueries.queryDeleteProduct(productsData.id, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

      retrieveAllProducts(context);

      transactionDataUpdated = true;

    }

  }

  void editProduct(BuildContext context, ProductsData productsData) async {

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

    String databaseDirectory = await getDatabasesPath();

    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase}";

    bool productsDatabaseExist = await databaseExists(productDatabasePath);

    if (productsDatabaseExist) {

      List<Widget> preparedAllProductsItem = [];

      var databaseQueries = ProductsDatabaseQueries();

      allProducts = await databaseQueries.getAllProducts(ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

      for (var element in allProducts) {

        preparedAllProductsItem.add(outputItem(context, element));

      }

      setState(() {

        allProductsItems = preparedAllProductsItem;

      });

    }

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

      List<Widget> preparedAllProductsItem = [];

      for (var element in searchResult) {

        preparedAllProductsItem.add(outputItem(context, element));

      }

      setState(() {

        allProductsItems = preparedAllProductsItem;

      });

    }

  }

  void searchProducts(BuildContext context,
      List<ProductsData> inputTransactionsList, String searchQuery) {

    List<ProductsData> searchResult = [];

    for (var element in inputTransactionsList) {

      if (element.productName.contains(searchQuery) ||
          element.productDescription.contains(searchQuery) ||
          element.productBrand.contains(searchQuery) ||
          element.productCategory.contains(searchQuery) ||
          element.productPrice.contains(searchQuery) ||
          element.productProfitPercent.contains(searchQuery)) {

        searchResult.add(element);

      }

      List<Widget> preparedAllProductsItem = [];

      for (var element in searchResult) {

        preparedAllProductsItem.add(outputItem(context, element));

      }

      setState(() {

        allProductsItems = preparedAllProductsItem;

      });

    }

  }

  void searchProductsInitially(BuildContext context, String searchQuery) async {

    String databaseDirectory = await getDatabasesPath();

    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase}";

    bool productsDatabaseExist = await databaseExists(productDatabasePath);

    if (productsDatabaseExist) {

      List<ProductsData> searchResult = [];

      var databaseQueries = ProductsDatabaseQueries();

      allProducts = await databaseQueries.getAllProducts(ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

      for (var element in allProducts) {

        if (element.productName.contains(searchQuery) ||
            element.productDescription.contains(searchQuery) ||
            element.productBrand.contains(searchQuery) ||
            element.productCategory.contains(searchQuery) ||
            element.productPrice.contains(searchQuery) ||
            element.productProfitPercent.contains(searchQuery)) {

          searchResult.add(element);

        }

        List<Widget> preparedAllProductsItem = [];

        for (var element in searchResult) {

          preparedAllProductsItem.add(outputItem(context, element));

        }

        setState(() {

          allProductsItems = preparedAllProductsItem;

        });

      }

    }

  }

}