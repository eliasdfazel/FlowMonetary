/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/2/22, 10:04 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:blur/blur.dart';
import 'package:flow_accounting/customers/database/io/inputs.dart';
import 'package:flow_accounting/customers/database/io/queries.dart';
import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:flow_accounting/customers/input/ui/customers_input_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomersOutputView extends StatefulWidget {
  const CustomersOutputView({Key? key}) : super(key: key);

  @override
  _CustomersOutputViewState createState() => _CustomersOutputViewState();
}
class _CustomersOutputViewState extends State<CustomersOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<CustomersData> allCustomers = [];
  List<Widget> allCustomersItems = [];

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool colorSelectorInitialized = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    retrieveAllCustomers(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    colorSelectorView.selectedColorNotifier.addListener(() {

      filterByColorTag(context, allCustomers, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
    allListContentWidgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: colorSelectorView,
    ));
    allListContentWidgets.addAll(allCustomersItems);

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

                                        sortCustomersByAge(context, allCustomers);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.sortCustomerAge,
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

                                        retrieveAllCustomers(context);

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

                                    searchCustomers(context, allCustomers, searchQuery);

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

                                          searchCustomers(context, allCustomers, searchQuery);

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

  Widget outputItem(BuildContext context, CustomersData customersData) {

    String customerName = customersData.customerName;
    String customerDescription = customersData.customerDescription;

    String customerBirthday = customersData.customerBirthday;

    String customerEmail = customersData.customerEmailAddress;
    String customerPhoneNumber = customersData.customerPhoneNumber;

    Widget customerImageWidget = const Opacity(
      opacity: 0.7,
      child: Image(
        image: AssetImage("unknown_user.png"),
        fit: BoxFit.cover,
      ),
    );

    if (customersData.customerImagePath.isNotEmpty) {

      customerImageWidget = Image.file(
        File(customersData.customerImagePath),
        fit: BoxFit.cover,
      );

    }

    Color customerColorTag = Color(customersData.colorTag);

    return Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (BuildContext context) {

                deleteCustomer(context, customersData);

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

                editCustomer(context, customersData);

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
            shadowColor: customerColorTag.withOpacity(0.79),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(17)),
            child: InkWell(
              onTap: () {

                editCustomer(context, customersData);

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
                                height: 133,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(19, 11, 19, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 15,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              height: 31,
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(11, 0, 13, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      customerName,
                                                      style: const TextStyle(
                                                        color: ColorsResources.dark,
                                                        fontSize: 19,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 91,
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(11, 3, 13, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text(
                                                      customerDescription,
                                                      maxLines: 4,
                                                      style: const TextStyle(
                                                        color: ColorsResources.darkTransparent,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(51),
                                                child: ColoredBox(
                                                  color: customerColorTag,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(51),
                                                      child: customerImageWidget,
                                                    ),
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
                            ),
                            SizedBox(
                              height: 35,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(35, 0, 19, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 23,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          customerBirthday,
                                          textAlign: TextAlign.right,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorsResources.dark.withOpacity(0.597),
                                              fontSize: 13
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          " :${StringsResources.customerBirthdayText}",
                                          textAlign: TextAlign.right,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorsResources.dark.withOpacity(0.597),
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 39,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(35, 0, 19, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                            child: Text(
                                              customerEmail,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: ColorsResources.blueGreen,
                                                  fontSize: 15
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            customerPhoneNumber,
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: ColorsResources.blueGreen,
                                                fontSize: 15
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
                                        customerColorTag.withOpacity(0.7),
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
                ),
              ),
            ),
          ),
        )
    );

  }

  void deleteCustomer(BuildContext context, CustomersData customersData) async {

    var databaseQueries = CustomersDatabaseQueries();

    databaseQueries.queryDeleteCustomer(customersData.id, CustomersDatabaseInputs.databaseTableName);

    retrieveAllCustomers(context);

  }

  void editCustomer(BuildContext context, CustomersData customersData) async {

    bool budgetDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomersInputView(customersData: customersData)),
    );

    debugPrint("Budget Data Update => ${budgetDataUpdated}");
    if (budgetDataUpdated) {

      retrieveAllCustomers(context);

    }

  }

  void retrieveAllCustomers(BuildContext context) async {

    if (allCustomersItems.isNotEmpty) {

      allCustomersItems.clear();

    }

    List<Widget> preparedAllBudgetsItem = [];

    var databaseQueries = CustomersDatabaseQueries();

    allCustomers = await databaseQueries.getAllCustomers(CustomersDatabaseInputs.databaseTableName);

    for (var element in allCustomers) {

      preparedAllBudgetsItem.add(outputItem(context, element));

    }

    colorSelectorInitialized = false;

    setState(() {

      allCustomersItems = preparedAllBudgetsItem;

    });

  }

  void sortCustomersByAge(BuildContext context, List<CustomersData> inputCustomersList) {

    if (allCustomersItems.isNotEmpty) {

      allCustomersItems.clear();

    }
    inputCustomersList.sort((a, b) => (a.customerAge).compareTo(b.customerAge));

    List<Widget> preparedAllCustomersItem = [];

    for (var element in inputCustomersList) {

      preparedAllCustomersItem.add(outputItem(context, element));

    }

    setState(() {

      allCustomersItems = preparedAllCustomersItem;

    });

  }

  void filterByColorTag(BuildContext context,
      List<CustomersData> inputTransactionsList, Color colorQuery) {

    List<CustomersData> searchResult = [];

    for (var element in inputTransactionsList) {

      if (element.colorTag == colorQuery.value) {

        searchResult.add(element);

      }

      List<Widget> preparedAllCustomersItem = [];

      for (var element in searchResult) {

        preparedAllCustomersItem.add(outputItem(context, element));

      }

      setState(() {

        allCustomersItems = preparedAllCustomersItem;

      });

    }

  }

  void searchCustomers(BuildContext context,
      List<CustomersData> inputBudgetsList, String searchQuery) {

    List<CustomersData> searchResult = [];

    for (var element in inputBudgetsList) {

      if (element.customerName.contains(searchQuery) ||
          element.customerDescription.contains(searchQuery) ||
          element.customerBirthday.contains(searchQuery) ||
          element.customerAge.contains(searchQuery) ||
          element.customerCountry.contains(searchQuery) ||
          element.customerCity.contains(searchQuery) ||
          element.customerStreetAddress.contains(searchQuery) ||
          element.customerEmailAddress.contains(searchQuery) ||
          element.customerPhoneNumber.contains(searchQuery) ||
          element.customerJob.contains(searchQuery) ||
          element.customerMaritalStatus.contains(searchQuery)) {

        searchResult.add(element);

      }

      List<Widget> preparedAllTransactionsItem = [];

      for (var element in searchResult) {

        preparedAllTransactionsItem.add(outputItem(context, element));

      }

      setState(() {

        allCustomersItems = preparedAllTransactionsItem;

      });

    }

  }

}