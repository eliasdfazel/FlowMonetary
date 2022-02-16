/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:50 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/io/queries.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/home/interface/sections/latest_transactions_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_cards_list_view.dart';
import 'sections/features_view.dart';
import 'sections/general_data_view.dart';
import 'sections/top_bar_view.dart';

class DashboardView extends StatefulWidget {

  final String applicationName;

  const DashboardView({Key? key, required this.applicationName}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardView();
}
class _DashboardView extends State<DashboardView> {


  List<TransactionsData> someLatestTransactions = [];

  List<CreditCardsData> allCreditCards = [];

  @override
  void initState(){

    retrieveLatestTransactions();

    super.initState();

    WidgetsBinding.instance?.addObserver(
        LifecycleEventHandler(resumeCallBack: () async => setState(() {
          debugPrint("Dashboard Resumed");


        }))
    );

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea (
        child: MaterialApp (
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName,
          color: ColorsResources.black,
          theme: ThemeData(
            fontFamily: 'Sans',
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColorLight),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            }),
          ),
          home: Scaffold(
            backgroundColor: ColorsResources.black,
            body: Stack(
              children: [
                // Gradient Background
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                    gradient: LinearGradient(
                        colors: [
                          ColorsResources.grayLight,
                          ColorsResources.greenGrayLight,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(45),
                        tileMode: TileMode.clamp
                    ),
                  ),
                ),
                // Wave
                SizedBox(
                  width: double.infinity,
                  height: 179,
                  child: RotatedBox (
                    quarterTurns: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.0),
                      child: WaveWidget(
                        config: CustomConfig(
                          colors: [
                            ColorsResources.greenGrayLight,
                            ColorsResources.blueGreen,
                            ColorsResources.black,
                          ],
                          heightPercentages: [0.13, 0.57, 0.79],
                          durations: [13000, 21000, 19000],
                          blur: const MaskFilter.blur(BlurStyle.normal, 3.1),
                        ),
                        backgroundColor: Colors.transparent,
                        size: const Size(double.infinity, 300),
                        waveAmplitude: 7,
                        duration: 1000,
                        isLoop: true,
                      ),
                    ),
                  ),
                ),
                // Wave Line
                SizedBox(
                  width: double.infinity,
                  height: 179,
                  child: RotatedBox (
                    quarterTurns: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(17.0),
                      child: WaveWidget(
                        config: CustomConfig(
                          colors: [
                            ColorsResources.primaryColorLighter,
                            ColorsResources.primaryColorLight,
                            ColorsResources.primaryColorLight,
                          ],
                          heightPercentages: [0.13, 0.57, 0.79],
                          durations: [13000, 21000, 19000],
                          blur: const MaskFilter.blur(BlurStyle.outer, 3.7),
                        ),
                        backgroundColor: Colors.transparent,
                        size: const Size(double.infinity, 300),
                        waveAmplitude: 7,
                        duration: 1000,
                        isLoop: true,
                      ),
                    ),
                  ),
                ),
                // Rounded Borders
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                      border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 7,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 7,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 7,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                            width: 7,
                          )
                      ),
                      color: Colors.transparent
                  ),
                ),
                // All Contents
                Padding(
                  padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/7.3),
                  child: Container (
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                    ),
                    child: Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                          scrollDirection: Axis.vertical,
                          children: [ // List Of All Contents
                            const TopBarView(),
                            LatestTransactionsView(
                                latestTransactionsData: someLatestTransactions
                            ),
                            const GeneralDataView(),
                            CreditCardsListView(
                              allCreditCardsData: allCreditCards,
                            ),
                            const FeaturesOptionsView(),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  void retrieveLatestTransactions() async {

    TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

    List<TransactionsData> latestTransactions = await transactionsDatabaseQueries.getAllTransactions(TransactionsDatabaseInputs.databaseTableName);

    if (latestTransactions.length > 10) {

      latestTransactions = latestTransactions.sublist(0, 10);

    }

    setState(() {

      someLatestTransactions = latestTransactions;

    });

    prepareCreditCardsData();

  }

  void prepareCreditCardsData() async {

    CreditCardsDatabaseQueries databaseQueries = CreditCardsDatabaseQueries();

    List<CreditCardsData> listOfAllCreditCards = await databaseQueries.getAllCreditCards(CreditCardsDatabaseInputs.databaseTableName);

    setState(() {

      allCreditCards = listOfAllCreditCards;

    });

  }

}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:

        break;
    }
  }
}