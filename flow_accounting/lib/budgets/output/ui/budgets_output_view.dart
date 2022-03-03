
import 'package:blur/blur.dart';
import 'package:flow_accounting/budgets/database/io/inputs.dart';
import 'package:flow_accounting/budgets/database/io/queries.dart';
import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:flow_accounting/budgets/input/ui/budgets_input_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/output/ui/transactions_output_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee/marquee.dart';

class BudgetsOutputView extends StatefulWidget {
  const BudgetsOutputView({Key? key}) : super(key: key);

  @override
  _BudgetOutputViewState createState() => _BudgetOutputViewState();
}
class _BudgetOutputViewState extends State<BudgetsOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<BudgetsData> allBudgets = [];
  List<Widget> allBudgetsItems = [];

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool colorSelectorInitialized = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    retrieveAllBudgets(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    colorSelectorView.selectedColorNotifier.addListener(() {

      filterByColorTag(context, allBudgets, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
    allListContentWidgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: colorSelectorView,
    ));
    allListContentWidgets.addAll(allBudgetsItems);

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

                                        sortBudgetsByBalance(context, allBudgets);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.sortBudgetAmountHigh,
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

                                        retrieveAllBudgets(context);

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

                                    searchBudgets(context, allBudgets, searchQuery);

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

                                          searchBudgets(context, allBudgets, searchQuery);

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

  Widget outputItem(BuildContext context, BudgetsData budgetsData) {

    String budgetName = budgetsData.budgetName;
    String budgetDescription = budgetsData.budgetDescription;

    String budgetBalance = budgetsData.budgetBalance;

    Color budgetColorTag = Color(budgetsData.colorTag);

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              deleteBudget(context, budgetsData);

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

              editBudget(context, budgetsData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.applicationGeeksEmpire,
            icon: Icons.edit_rounded,
            label: StringsResources.editText,
            autoClose: true,
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              NavigationProcess().goTo(context, TransactionsOutputView(initialSearchQuery: budgetName));

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.greenGray,
            icon: Icons.money_rounded,
            label: StringsResources.transactionAll,
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

              editBudget(context, budgetsData);

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
                              padding: const EdgeInsets.fromLTRB(27, 11, 13, 0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Marquee(
                                    text: budgetBalance,
                                    style: const TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 31,
                                      fontFamily: "Numbers",
                                    ),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    blankSpace: 199.0,
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
                                            budgetName,
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
                              padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                              child: Container(
                                color: Colors.transparent,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    budgetDescription,
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
              ),
            ),
          ),
        ),
      )
    );

  }

  void deleteBudget(BuildContext context, BudgetsData budgetsData) async {

    var databaseQueries = BudgetsDatabaseQueries();

    databaseQueries.queryDeleteBudget(budgetsData.id, BudgetsDatabaseInputs.databaseTableName);

    retrieveAllBudgets(context);

  }

  void editBudget(BuildContext context, BudgetsData budgetsData) async {

    bool budgetDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BudgetsInputView(budgetsData: budgetsData)),
    );

    debugPrint("Budget Data Update => ${budgetDataUpdated}");
    if (budgetDataUpdated) {

      retrieveAllBudgets(context);

    }

  }

  void retrieveAllBudgets(BuildContext context) async {

    if (allBudgetsItems.isNotEmpty) {

      allBudgetsItems.clear();

    }

    List<Widget> preparedAllBudgetsItem = [];

    var databaseQueries = BudgetsDatabaseQueries();

    allBudgets = await databaseQueries.getAllBudgets(BudgetsDatabaseInputs.databaseTableName);

    for (var element in allBudgets) {

      preparedAllBudgetsItem.add(outputItem(context, element));

    }

    colorSelectorInitialized = false;

    setState(() {

      allBudgetsItems = preparedAllBudgetsItem;

    });

  }

  void sortBudgetsByBalance(BuildContext context, List<BudgetsData> inputBudgetsList) {

    if (allBudgetsItems.isNotEmpty) {

      allBudgetsItems.clear();

    }
    inputBudgetsList.sort((a, b) => (a.budgetBalance).compareTo(b.budgetBalance));

    List<Widget> preparedAllTransactionsItem = [];

    for (var element in inputBudgetsList) {

      preparedAllTransactionsItem.add(outputItem(context, element));

    }

    setState(() {

      allBudgetsItems = preparedAllTransactionsItem;

    });

  }

  void filterByColorTag(BuildContext context,
      List<BudgetsData> inputTransactionsList, Color colorQuery) {

    List<BudgetsData> searchResult = [];

    for (var element in inputTransactionsList) {

      if (element.colorTag == colorQuery.value) {

        searchResult.add(element);

      }

      List<Widget> preparedAllTransactionsItem = [];

      for (var element in searchResult) {

        preparedAllTransactionsItem.add(outputItem(context, element));

      }

      setState(() {

        allBudgetsItems = preparedAllTransactionsItem;

      });

    }

  }

  void searchBudgets(BuildContext context,
      List<BudgetsData> inputBudgetsList, String searchQuery) {

    List<BudgetsData> searchResult = [];

    for (var element in inputBudgetsList) {

      if (element.budgetName.contains(searchQuery) ||
          element.budgetDescription.contains(searchQuery)
      ) {

        searchResult.add(element);

      }

      List<Widget> preparedAllBudgetsItem = [];

      for (var element in searchResult) {

        preparedAllBudgetsItem.add(outputItem(context, element));

      }

      setState(() {

        allBudgetsItems = preparedAllBudgetsItem;

      });

    }

  }

}