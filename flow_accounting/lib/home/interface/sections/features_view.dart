/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:45 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

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

  List<Widget> allFeaturesOptionsWidgets = [];

  @override
  void initState() {

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        /* featureOneTitle */ StringsResources.featureTransactionsTitle,
        /* featureTwoTitle */ null,
        /* featureOneDescription */ StringsResources.featureTransactionsDescription,
        /* featureTwoDescription */ null,
        /* featureOneTargetViewToSubmitData */ const TransactionsInputView(),
        /* featureTwoTargetViewToSubmitData */ null,
        /* featureOneTargetViewToPresentData */ const TransactionsOutputView(),
        /* featureTwoTargetViewToPresentData */ null,
        /* Context */ context
    ));

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        StringsResources.featureSellInvoicesTitle,
        StringsResources.featureBuyInvoicesTitle,
        StringsResources.featureSellInvoicesDescription,
        StringsResources.featureBuyInvoicesDescription,
        null,
        null,
        null,
        null,
        context
    ));

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        StringsResources.featureProductsTitle,
        null,
        StringsResources.featureProductsDescription,
        null,
        null,
        null,
        null,
        null,
        context
    ));

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        StringsResources.featureChequesTitle,
        null,
        StringsResources.featureChequesDescription,
        null,
        null,
        null,
        null,
        null,
        context
    ));

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        StringsResources.featureDebtorsTitle,
        StringsResources.featureCreditorsTitle,
        StringsResources.featureDebtorsDescription,
        StringsResources.featureCreditorsDescription,
        null,
        null,
        null,
        null,
        context
    ));

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        StringsResources.featureCustomersTitle,
        null,
        StringsResources.featureCustomersDescription,
        null,
        null,
        null,
        null,
        null,
        context
    ));

    allFeaturesOptionsWidgets.add(featuresOptionsRow(
        StringsResources.featureBudgetManagementsTitle,
        StringsResources.featureLoansTitle,
        StringsResources.featureBudgetManagementsDescription,
        StringsResources.featureLoansDescription,
        null,
        null,
        null,
        null,
        context
    ));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
      child: Column(
        children: [
          SearchBarView(featuresOptionsView: this, allFeaturesOptionsWidgets: allFeaturesOptionsWidgets,),
          Column(
            children: allFeaturesOptionsWidgets,
          )
        ]
      ),
    );
  }

  void updateAvailableFeaturesOptions(
      List<Widget> availableFeaturesOptionsWidgets) {

    allFeaturesOptionsWidgets.clear();

    allFeaturesOptionsWidgets.addAll(availableFeaturesOptionsWidgets);

    setState(() {

      allFeaturesOptionsWidgets;

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
                              fontSize: 13,
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