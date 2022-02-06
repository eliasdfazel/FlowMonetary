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
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/input/ui/transactions_input_view.dart';
import 'package:flow_accounting/transactions/output/ui/transactions_output_view.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';

import 'search_bar_view.dart';

class FeaturesOptionsData {

  String featuresTitle;
  String featuresDescription;

  StatefulWidget targetViewToSubmitData;
  StatefulWidget targetViewToPresentData;

  FeaturesOptionsData({
    required this.featuresTitle,
    required this.featuresDescription,
    required this.targetViewToSubmitData,
    required this.targetViewToPresentData
  });

}

class FeaturesOptionsView extends StatefulWidget {
  const FeaturesOptionsView({Key? key}) : super(key: key);

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

    SearchBarView searchBarView = SearchBarView(initialFeaturesStructure: initializeFeatures());

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
      child: Column(
        children: [
          searchBarView,
          Column(
            children: allFeaturesOptionsWidgets,
          )
        ]
      ),
    );
  }

  List<FeaturesStructure> initializeFeatures() {

    allFeaturesStructure.clear();

    allFeaturesStructure.add(FeaturesStructure(
      importantFeature: true,
      featuresTitle: StringsResources.featureTransactionsTitle,
      featuresDescription: StringsResources.featureTransactionsDescription,
      featureViewToSubmitData: const TransactionsInputView(),
      featureToPresentData: const TransactionsOutputView(),
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: false,
        featuresTitle: StringsResources.featureSellInvoicesTitle,
        featuresDescription: StringsResources.featureSellInvoicesDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: false,
        featuresTitle: StringsResources.featureBuyInvoicesTitle,
        featuresDescription: StringsResources.featureBuyInvoicesDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: true,
        featuresTitle: StringsResources.featureProductsTitle,
        featuresDescription: StringsResources.featureProductsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: true,
        featuresTitle: StringsResources.featureChequesTitle,
        featuresDescription: StringsResources.featureChequesDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: false,
        featuresTitle: StringsResources.featureDebtorsTitle,
        featuresDescription: StringsResources.featureDebtorsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: false,
        featuresTitle: StringsResources.featureCreditorsTitle,
        featuresDescription: StringsResources.featureCreditorsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: true,
        featuresTitle: StringsResources.featureCustomersTitle,
        featuresDescription: StringsResources.featureCustomersDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: false,
        featuresTitle: StringsResources.featureBudgetManagementsTitle,
        featuresDescription: StringsResources.featureBudgetManagementsDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));
    allFeaturesStructure.add(FeaturesStructure(
        importantFeature: false,
        featuresTitle: StringsResources.featureLoansTitle,
        featuresDescription: StringsResources.featureLoansDescription,
        featureViewToSubmitData: null,
        featureToPresentData: null
    ));

    return allFeaturesStructure;
  }

  void initializeFeaturesCheckpoint() {

    allFeaturesOptionsWidgets.clear();

    bool alreadyTwo = false;

    allFeaturesStructure.forEachIndexed((index, element) {

      if (element.importantFeature) {

        allFeaturesOptionsWidgets.add(featuresOptionsRow(
          /* featureOneTitle */ allFeaturesStructure[index].featuresTitle,
            /* featureTwoTitle */ null,
            /* featureOneDescription */ allFeaturesStructure[index].featuresDescription,
            /* featureTwoDescription */ null,
            /* featureOneTargetViewToSubmitData */ allFeaturesStructure[index].featureViewToSubmitData,
            /* featureTwoTargetViewToSubmitData */ null,
            /* featureOneTargetViewToPresentData */ allFeaturesStructure[index].featureToPresentData,
            /* featureTwoTargetViewToPresentData */ null,
            /* Context */ context
        ));

        alreadyTwo = false;

      } else {

        if (!alreadyTwo) {

          alreadyTwo = false;

          if ((index + 1) == (allFeaturesStructure.length - 1)) {

            alreadyTwo = true;

          } else {}

          allFeaturesOptionsWidgets.add(featuresOptionsRow(
              allFeaturesStructure[index].featuresTitle,
              allFeaturesStructure[index + 1].featuresTitle,
              allFeaturesStructure[index].featuresDescription,
              allFeaturesStructure[index + 1].featuresDescription,
              null,
              null,
              null,
              null,
              context
          ));

          alreadyTwo = true;

        }

      }

    });

  }

  void searchFeaturesCheckpoint() {

    allFeaturesStructure.forEachIndexed((index, element) {

      allFeaturesOptionsWidgets.add(featuresOptionsRow(
        /* featureOneTitle */ allFeaturesStructure[index].featuresTitle,
          /* featureTwoTitle */ null,
          /* featureOneDescription */ allFeaturesStructure[index].featuresDescription,
          /* featureTwoDescription */ null,
          /* featureOneTargetViewToSubmitData */ allFeaturesStructure[index].featureViewToSubmitData,
          /* featureTwoTargetViewToSubmitData */ null,
          /* featureOneTargetViewToPresentData */ allFeaturesStructure[index].featureToPresentData,
          /* featureTwoTargetViewToPresentData */ null,
          /* Context */ context
      ));

    });

  }

}

Widget featuresOptionsRow(
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
      featureOneTitle,
      featureOneDescription,
      featureOneTargetViewToSubmitData,
      featureOneTargetViewToPresentData,
      context
  );

  Widget secondWidget = Container(
    color: Colors.transparent,
  );

  if (featureTwoTitle != null && featureTwoDescription != null) {

    secondWidget = featuresOptionsItem(
        featureTwoTitle,
        featureTwoDescription,
        featureTwoTargetViewToSubmitData,
        featureTwoTargetViewToPresentData,
        context
    );

  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      firstWidget,
      secondWidget,
    ],
  );
}

Widget featuresOptionsItem(String featureTitle,
    String featureDescription,
    StatefulWidget? targetViewToSubmitData,
    StatefulWidget? targetViewToPresentData,
    BuildContext context) {

  return Expanded(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Container (
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
              bottomLeft: Radius.circular(13),
              bottomRight: Radius.circular(13)),
          color: ColorsResources.primaryColorLightest,
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
        child: Column(
          children: [
            SizedBox(
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius
                        .circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
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
                    padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
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
                                    blurRadius: 7
                                )
                              ]
                          ),
                        ),
                      ),
                    )
                  ),
                )
            ),
            SizedBox(
                height: 119,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const  BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
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
                    padding: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          featureDescription,
                          style: const TextStyle(
                              fontSize: 12,
                              color: ColorsResources.blueGreen,
                              shadows: [
                                Shadow(
                                    color: ColorsResources.light,
                                    offset: Offset(0, 0),
                                    blurRadius: 7
                                )
                              ]
                          ),
                        ),
                      ),
                    )
                  ),
                )
            ),
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

                              Future.delayed(const Duration(milliseconds: 199), () {

                                if (targetViewToPresentData != null) {

                                  NavigationProcess().goTo(context, targetViewToPresentData);

                                }

                              });

                            },
                            child: const Text(
                              StringsResources.presentText,
                              style: TextStyle(fontSize: 13,shadows: [
                                Shadow(
                                    color: ColorsResources.light,
                                    offset: Offset(0, 0),
                                    blurRadius: 7
                                )
                              ]),
                            ),
                            height: 79,
                            minWidth: double.infinity,
                            color: ColorsResources.light,
                            splashColor: ColorsResources.primaryColor,
                            textColor: ColorsResources.applicationDarkGeeksEmpire,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13),
                                    bottomLeft: Radius.circular(13),
                                    bottomRight: Radius.circular(0)
                                )
                            ),
                          )
                      ),
                      const Expanded(
                        flex: 1,
                        child: ColoredBox(color: Colors.transparent,),
                      ),
                      Expanded(
                          flex: 31,
                          child: MaterialButton(
                            onPressed: () {

                              Future.delayed(const Duration(milliseconds: 199), () {

                                if (targetViewToSubmitData != null) {

                                  NavigationProcess().goTo(context, targetViewToSubmitData);

                                }
                              });

                            },
                            child: const Text(
                              StringsResources.submitText,
                              style: TextStyle(fontSize: 13,shadows: [
                                Shadow(
                                    color: ColorsResources.light,
                                    offset: Offset(0, 0),
                                    blurRadius: 7
                                )
                              ]),
                            ),
                            height: 79,
                            minWidth: double.infinity,
                            color: ColorsResources.light,
                            splashColor: ColorsResources.primaryColor,
                            textColor: ColorsResources.applicationDarkGeeksEmpire,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(13)
                                )
                            ),
                          )
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    ),
  );
}

class FeaturesStructure {

  final bool importantFeature;

  final String featuresTitle;
  final String featuresDescription;

  final StatefulWidget? featureViewToSubmitData;
  final StatefulWidget? featureToPresentData;

  FeaturesStructure({
    required this.importantFeature,
    required this.featuresTitle,
    required this.featuresDescription,
    required this.featureViewToSubmitData,
    required this.featureToPresentData,
  });

}