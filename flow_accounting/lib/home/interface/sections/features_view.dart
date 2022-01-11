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
                  StringsResources.featureTransactionsTitle,
                  null,
                  null
              ),
              featuresOptionsItem(
                  StringsResources.featureTransactionsTitle,
                  StringsResources.featureTransactionsTitle,
                  null,
                  null
              ),
            ],
          )
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
        color: ColorsResources.gameGeeksEmpire,
      ),
    ),
  );
}