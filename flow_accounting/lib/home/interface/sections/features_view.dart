/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:45 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:collection/collection.dart';
import 'package:flow_accounting/budgets/input/ui/budgets_input_view.dart';
import 'package:flow_accounting/budgets/output/ui/budgets_output_view.dart';
import 'package:flow_accounting/customers/input/ui/customers_input_view.dart';
import 'package:flow_accounting/customers/output/ui/customers_output_view.dart';
import 'package:flow_accounting/home/interface/dashboard.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/input/ui/transactions_input_view.dart';
import 'package:flow_accounting/transactions/output/ui/transactions_output_view.dart';
import 'package:flutter/material.dart';

import 'search_bar_view.dart';

class FeaturesOptionsData {
  String featuresTitle;
  String featuresDescription;

  StatefulWidget targetViewToSubmitData;
  StatefulWidget targetViewToPresentData;

  FeaturesOptionsData(
      {required this.featuresTitle,
      required this.featuresDescription,
      required this.targetViewToSubmitData,
      required this.targetViewToPresentData});
}

class FeaturesOptionsView extends StatefulWidget {
  DashboardViewState dashboardView;

  FeaturesOptionsView({Key? key, required this.dashboardView})
      : super(key: key);

  @override
  State<FeaturesOptionsView> createState() => StateFeaturesOptionsView();
}
class StateFeaturesOptionsView extends State<FeaturesOptionsView> {
  List<FeaturesStructure> allFeaturesStructureUntouch = [];

  List<Widget> allFeaturesOptionsWidgetsUntouch = [];

  List<FeaturesStructure> allFeaturesStructure = [];

  List<Widget> allFeaturesOptionsWidgets = [];

  @override
  void initState() {
    initializeFeatures();
    allFeaturesStructureUntouch = allFeaturesStructure;

    initializeFeaturesCheckpoint();
    allFeaturesOptionsWidgetsUntouch = allFeaturesOptionsWidgets;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchBarView searchBarView =
        SearchBarView(initialFeaturesStructure: initializeFeatures());

    searchBarView.resetFeaturesList.addListener(() {
      initializeFeatures();

      initializeFeaturesCheckpoint();

      setState(() {
        allFeaturesOptionsWidgets;
      });
    });

    searchBarView.searchableFeaturesList.addListener(() {
      allFeaturesStructure.clear();
      allFeaturesOptionsWidgets.clear();

      allFeaturesStructure.addAll(searchBarView.searchableFeaturesList.value);

      searchFeaturesCheckpoint();

      setState(() {
        allFeaturesOptionsWidgets;
      });
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
      child: Column(children: [
        searchBarView,
        Column(
          children: allFeaturesOptionsWidgets,
        )
      ]),
    );
  }

  List<FeaturesStructure> initializeFeatures() {
    allFeaturesStructure.clear();

    allFeaturesStructure.add(FeaturesStructure(
      featureColor: ColorsResources.lightestPurple,
      importantFeature: true,
      featuresTitle: StringsResources.featureTransactionsTitle,
      featuresDescription: StringsResources.featureTransactionsDescription,
      featureViewToSubmitData: const TransactionsInputView(),
      featureToPresentData: TransactionsOutputView(),
    ));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestBlue,
        importantFeature: false,
        featuresTitle: StringsResources.featureSellInvoicesTitle,
        featuresDescription: StringsResources.featureSellInvoicesDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestBlue,
        importantFeature: false,
        featuresTitle: StringsResources.featureBuyInvoicesTitle,
        featuresDescription: StringsResources.featureBuyInvoicesDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestOrange,
        importantFeature: true,
        featuresTitle: StringsResources.featureProductsTitle,
        featuresDescription: StringsResources.featureProductsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestCyan,
        importantFeature: true,
        featuresTitle: StringsResources.featureChequesTitle,
        featuresDescription: StringsResources.featureChequesDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestRed,
        importantFeature: false,
        featuresTitle: StringsResources.featureDebtorsTitle,
        featuresDescription: StringsResources.featureDebtorsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestRed,
        importantFeature: false,
        featuresTitle: StringsResources.featureCreditorsTitle,
        featuresDescription: StringsResources.featureCreditorsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestGreen,
        importantFeature: true,
        featuresTitle: StringsResources.featureCustomersTitle,
        featuresDescription: StringsResources.featureCustomersDescription,
        featureViewToSubmitData: CustomersInputView(),
        featureToPresentData: const CustomersOutputView()));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestYellow,
        importantFeature: false,
        featuresTitle: StringsResources.featureBudgetManagementsTitle,
        featuresDescription:
            StringsResources.featureBudgetManagementsDescription,
        featureViewToSubmitData: BudgetsInputView(),
        featureToPresentData: const BudgetsOutputView()));
    allFeaturesStructure.add(FeaturesStructure(
        featureColor: ColorsResources.lightestYellow,
        importantFeature: false,
        featuresTitle: StringsResources.featureLoansTitle,
        featuresDescription: StringsResources.featureLoansDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null));

    return allFeaturesStructure;
  }

  void initializeFeaturesCheckpoint() {
    allFeaturesOptionsWidgets.clear();

    bool alreadyTwo = false;

    allFeaturesStructure.forEachIndexed((index, element) {
      if (element.importantFeature) {
        allFeaturesOptionsWidgets.add(featuresOptionsRow(
            /* featureBackgroundColor */
            allFeaturesStructure[index].featureColor,
            /* featureOneTitle */
            allFeaturesStructure[index].featuresTitle,
            /* featureTwoTitle */
            null,
            /* featureOneDescription */
            allFeaturesStructure[index].featuresDescription,
            /* featureTwoDescription */
            null,
            /* featureOneTargetViewToSubmitData */
            allFeaturesStructure[index].featureViewToSubmitData,
            /* featureTwoTargetViewToSubmitData */
            null,
            /* featureOneTargetViewToPresentData */
            allFeaturesStructure[index].featureToPresentData,
            /* featureTwoTargetViewToPresentData */
            null,
            /* Context */
            context));

        alreadyTwo = false;
      } else {
        if (!alreadyTwo) {
          alreadyTwo = false;

          if ((index + 1) == (allFeaturesStructure.length - 1)) {
            alreadyTwo = true;
          } else {}

          allFeaturesOptionsWidgets.add(featuresOptionsRow(
              allFeaturesStructure[index].featureColor,
              allFeaturesStructure[index].featuresTitle,
              allFeaturesStructure[index + 1].featuresTitle,
              allFeaturesStructure[index].featuresDescription,
              allFeaturesStructure[index + 1].featuresDescription,
              allFeaturesStructure[index].featureViewToSubmitData,
              allFeaturesStructure[index + 1].featureViewToSubmitData,
              allFeaturesStructure[index].featureToPresentData,
              allFeaturesStructure[index + 1].featureToPresentData,
              context));

          alreadyTwo = true;
        }
      }
    });
  }

  void searchFeaturesCheckpoint() {
    allFeaturesStructure.forEachIndexed((index, element) {
      allFeaturesOptionsWidgets.add(featuresOptionsRow(
          /* featureBackgroundColor */
          allFeaturesStructure[index].featureColor,
          /* featureOneTitle */
          allFeaturesStructure[index].featuresTitle,
          /* featureTwoTitle */
          null,
          /* featureOneDescription */
          allFeaturesStructure[index].featuresDescription,
          /* featureTwoDescription */
          null,
          /* featureOneTargetViewToSubmitData */
          allFeaturesStructure[index].featureViewToSubmitData,
          /* featureTwoTargetViewToSubmitData */
          null,
          /* featureOneTargetViewToPresentData */
          allFeaturesStructure[index].featureToPresentData,
          /* featureTwoTargetViewToPresentData */
          null,
          /* Context */
          context));
    });
  }

  Widget featuresOptionsRow(
      Color backgroundColor,
      String featureOneTitle,
      String? featureTwoTitle,
      String featureOneDescription,
      String? featureTwoDescription,
      StatefulWidget? featureOneTargetViewToSubmitData,
      StatefulWidget? featureTwoTargetViewToSubmitData,
      StatefulWidget? featureOneTargetViewToPresentData,
      StatefulWidget? featureTwoTargetViewToPresentData,
      BuildContext context) {
    
    Widget firstWidget = featuresOptionsItem(
        backgroundColor,
        featureOneTitle,
        featureOneDescription,
        featureOneTargetViewToSubmitData,
        featureOneTargetViewToPresentData,
        context);

    Widget secondWidget = Container(
      color: Colors.transparent,
    );

    if (featureTwoTitle != null && featureTwoDescription != null) {
      secondWidget = featuresOptionsItem(
          backgroundColor,
          featureTwoTitle,
          featureTwoDescription,
          featureTwoTargetViewToSubmitData,
          featureTwoTargetViewToPresentData,
          context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        firstWidget,
        secondWidget,
      ],
    );
  }

  Widget featuresOptionsItem(
      Color backgroundColor,
      String featureTitle,
      String featureDescription,
      StatefulWidget? targetViewToSubmitData,
      StatefulWidget? targetViewToPresentData,
      BuildContext context) {

    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
                bottomRight: Radius.circular(13)),
            color: ColorsResources.light,
            boxShadow: [
              BoxShadow(
                color: ColorsResources.dark.withOpacity(0.3),
                blurRadius: 13.0,
                spreadRadius: 0.3,
                offset: const Offset(7.0, 7.0),
              ),
              const BoxShadow(
                color: ColorsResources.white,
                blurRadius: 12.0,
                spreadRadius: 0.5,
                offset: Offset(-5.0, -5.0),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13)),
              color: backgroundColor.withOpacity(0.3),
            ),
            child: Column(
              children: [
                SizedBox(
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        gradient: LinearGradient(
                            colors: [
                              ColorsResources.white.withOpacity(0.3),
                              ColorsResources.light,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: const [0.0, 1.0],
                            transform: const GradientRotation(45),
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                featureTitle,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: ColorsResources.dark,
                                    shadows: [
                                      Shadow(
                                          color: ColorsResources.light,
                                          offset: Offset(0, 0),
                                          blurRadius: 7)
                                    ]),
                              ),
                            ),
                          )),
                    )),
                SizedBox(
                    height: 119,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        gradient: LinearGradient(
                            colors: [
                              ColorsResources.white.withOpacity(0.3),
                              ColorsResources.light.withOpacity(0.3),
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: const [0.0, 1.0],
                            transform: const GradientRotation(45),
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(11, 7, 11, 0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                featureDescription,
                                maxLines: 5,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: ColorsResources.blueGreen,
                                    shadows: [
                                      Shadow(
                                          color: ColorsResources.light,
                                          offset: Offset(0, 0),
                                          blurRadius: 7
                                      )
                                    ]),
                              ),
                            ),
                          )),
                    )),
                SizedBox(
                    height: 53,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(3, 1, 3, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 31,
                              child: MaterialButton(
                                onPressed: () {
                                  Future.delayed(
                                      const Duration(milliseconds: 199),
                                          () async {
                                        if (targetViewToPresentData != null) {
                                          bool dataUpdated = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                targetViewToPresentData),
                                          );

                                          debugPrint("Data Update => ${dataUpdated}");
                                          if (dataUpdated) {
                                            switch (UpdatedData.UpdatedDataType) {
                                              case UpdatedData.GeneralBalance:
                                                {
                                                  break;
                                                }
                                              case UpdatedData.GeneralEarning:
                                                {
                                                  break;
                                                }
                                              case UpdatedData.GeneralSpending:
                                                {
                                                  break;
                                                }
                                              case UpdatedData.LatestTransactions:
                                                {
                                                  widget.dashboardView.retrieveLatestTransactions();

                                                  break;
                                                }
                                              case UpdatedData.CreditCards:
                                                {
                                                  break;
                                                }
                                            }
                                          }
                                        }
                                      });
                                },
                                child: const Text(
                                  StringsResources.presentText,
                                  style: TextStyle(fontSize: 13, shadows: [
                                    Shadow(
                                        color: ColorsResources.light,
                                        offset: Offset(0, 0),
                                        blurRadius: 7)
                                  ]),
                                ),
                                height: 79,
                                minWidth: double.infinity,
                                color: ColorsResources.light,
                                splashColor: ColorsResources.primaryColorLight,
                                textColor:
                                ColorsResources.applicationDarkGeeksEmpire,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(0))),
                              )),
                          const Expanded(
                            flex: 1,
                            child: ColoredBox(
                              color: Colors.transparent,
                            ),
                          ),
                          Expanded(
                              flex: 31,
                              child: MaterialButton(
                                onPressed: () {
                                  Future.delayed(
                                      const Duration(milliseconds: 199),
                                          () async {
                                        if (targetViewToSubmitData != null) {
                                          bool dataUpdated = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                targetViewToSubmitData),
                                          );

                                          debugPrint("Data Update => ${dataUpdated}");
                                          if (dataUpdated) {
                                            switch (UpdatedData.UpdatedDataType) {
                                              case UpdatedData.GeneralBalance:
                                                {
                                                  break;
                                                }
                                              case UpdatedData.GeneralEarning:
                                                {
                                                  break;
                                                }
                                              case UpdatedData.GeneralSpending:
                                                {
                                                  break;
                                                }
                                              case UpdatedData.LatestTransactions:
                                                {
                                                  widget.dashboardView
                                                      .retrieveLatestTransactions();

                                                  break;
                                                }
                                              case UpdatedData.CreditCards:
                                                {
                                                  break;
                                                }
                                            }
                                          }
                                        }
                                      });
                                },
                                child: const Text(
                                  StringsResources.submitText,
                                  style: TextStyle(fontSize: 13, shadows: [
                                    Shadow(
                                        color: ColorsResources.light,
                                        offset: Offset(0, 0),
                                        blurRadius: 7)
                                  ]),
                                ),
                                height: 79,
                                minWidth: double.infinity,
                                color: ColorsResources.light,
                                splashColor: ColorsResources.primaryColorLight,
                                textColor:
                                ColorsResources.applicationDarkGeeksEmpire,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(13))),
                              ))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturesStructure {
  final Color featureColor;

  final bool importantFeature;

  final String featuresTitle;
  final String featuresDescription;

  final StatefulWidget? featureViewToSubmitData;
  final StatefulWidget? featureToPresentData;

  FeaturesStructure({
    required this.featureColor,
    required this.importantFeature,
    required this.featuresTitle,
    required this.featuresDescription,
    required this.featureViewToSubmitData,
    required this.featureToPresentData,
  });
}
