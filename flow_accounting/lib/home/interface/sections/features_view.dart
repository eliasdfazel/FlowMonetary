import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';

class FeaturesOptionsView extends StatefulWidget {
  const FeaturesOptionsView({Key? key}) : super(key: key);

  @override
  State<FeaturesOptionsView> createState() => _FeaturesOptionsView();

}

class _FeaturesOptionsView extends State<FeaturesOptionsView> {

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

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              featuresOptionsItem(
                  StringsResources.featureTransactionsTitle,
                  StringsResources.featureTransactionsDescription,
                  null,
                  null
              ),
              featuresOptionsItem(
                  StringsResources.featureChequesTitle,
                  StringsResources.featureChequesDescription,
                  null,
                  null
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              featuresOptionsItem(
                  StringsResources.featureCustomersTitle,
                  StringsResources.featureCustomersDescription,
                  null,
                  null
              ),
              featuresOptionsItem(
                  StringsResources.featureProductsTitle,
                  StringsResources.featureProductsDescription,
                  null,
                  null
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              featuresOptionsItem(
                  StringsResources.featureSellInvoicesTitle,
                  StringsResources.featureSellInvoicesDescription,
                  null,
                  null
              ),
              featuresOptionsItem(
                  StringsResources.featureBuyInvoicesTitle,
                  StringsResources.featureBuyInvoicesDescription,
                  null,
                  null
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              featuresOptionsItem(
                  StringsResources.featureDebtorsTitle,
                  StringsResources.featureDebtorsDescription,
                  null,
                  null
              ),
              featuresOptionsItem(
                  StringsResources.featureCreditorsTitle,
                  StringsResources.featureCreditorsDescription,
                  null,
                  null
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              featuresOptionsItem(
                  StringsResources.featureBudgetManagementsTitle,
                  StringsResources.featureBudgetManagementsDescription,
                  null,
                  null
              ),
              featuresOptionsItem(
                  StringsResources.featureLoansTitle,
                  StringsResources.featureLoansDescription,
                  null,
                  null
              ),
            ],
          ),
        ],
      ),
    );
  }

}

Widget featuresOptionsItem(String featureTitle, String featureDescription,
    StatefulWidget? targetViewToSubmitData, StatefulWidget? targetViewToPresentData) {

  return Expanded(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Container (
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
          gradient: LinearGradient(
              colors: [
                ColorsResources.gameGeeksEmpire,
                ColorsResources.applicationGeeksEmpire,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              transform: GradientRotation(45),
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ColorsResources.primaryColorLightest,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(45),
                        tileMode: TileMode.clamp),
                  ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(featureTitle,
                      style: const TextStyle(fontSize: 19,shadows: [
                        Shadow(
                            color: ColorsResources.light,
                            offset: Offset(0, 0),
                            blurRadius: 7
                        )
                      ]),
                    ),
                  ),
                ),
              )
            ),
            SizedBox(
                height: 119,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ColorsResources.primaryColorLightest,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(45),
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(featureDescription,
                        style: const TextStyle(fontSize: 11,shadows: [
                          Shadow(
                              color: ColorsResources.light,
                              offset: Offset(0, 0),
                              blurRadius: 7
                          )
                        ]),
                      ),
                    ),
                  ),
                )
            ),
            SizedBox(
                height: 53,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                    gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ColorsResources.primaryColorLightest,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(45),
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(featureDescription,
                        style: const TextStyle(fontSize: 11,shadows: [
                          Shadow(
                              color: ColorsResources.light,
                              offset: Offset(0, 0),
                              blurRadius: 7
                          )
                        ]),
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    ),
  );
}