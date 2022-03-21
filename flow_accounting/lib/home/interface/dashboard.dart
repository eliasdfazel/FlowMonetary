/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/21/22, 10:01 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/io/queries.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/home/interface/sections/latest_transactions_view.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_cards_list_view.dart';
import 'sections/features_view.dart';
import 'sections/general_data_view.dart';
import 'sections/top_bar_view.dart';

class DashboardView extends StatefulWidget {

  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => DashboardViewState();
}
class DashboardViewState extends State<DashboardView> {

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

    BackButtonInterceptor.add(aInterceptor);

  }

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');

    return true;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea (
        child: MaterialApp (
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName(),
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
                          ColorsResources.light,
                          ColorsResources.lightestBlue,
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
                            ColorsResources.blueGrayLight,
                            ColorsResources.applicationDarkGeeksEmpire,
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
                            ColorsResources.yellow.withOpacity(0.3),
                            ColorsResources.yellow.withOpacity(0.5),
                            ColorsResources.yellow.withOpacity(0.5),
                          ],
                          heightPercentages: [0.13, 0.57, 0.79],
                          durations: [13000, 21000, 19000],
                          blur: const MaskFilter.blur(BlurStyle.outer, 5.3),
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
                  padding: const EdgeInsets.fromLTRB(1.1, 3, 1.1, 7.3),
                  child: Container (
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                    ),
                    child: Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(7, 3, 7, 73),
                          scrollDirection: Axis.vertical,
                          children: [ // List Of All Contents
                            const TopBarView(),
                            const GeneralDataView(),
                            CreditCardsListView(
                              allCreditCardsData: allCreditCards,
                            ),
                            LatestTransactionsView(
                                latestTransactionsData: someLatestTransactions
                            ),
                            FeaturesOptionsView(dashboardView: this),
                          ]
                      ),
                    ),
                  ),
                ),
                // Support
                Positioned(
                  left: 19,
                  bottom: 19,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: ColorsResources.black,
                            blurRadius: 5,
                            offset: Offset(1.7, 1.7)
                        ),
                        BoxShadow(
                            color: ColorsResources.white,
                            blurRadius: 5,
                            offset: Offset(-1.7, -1.7)
                        ),
                        BoxShadow(
                            color: ColorsResources.lightBlue.withOpacity(0.7),
                            blurRadius: 7,
                            offset: Offset(1, -1)
                        ),
                        BoxShadow(
                            color: ColorsResources.blue.withOpacity(0.7),
                            blurRadius: 7,
                            offset: Offset(-1, 1)
                        ),
                      ]
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(51),
                        child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorsResources.dark,
                                  Colors.black
                                ],
                                tileMode: TileMode.clamp,
                                transform: GradientRotation(45),
                              )
                            ),
                            child: Material(
                                shadowColor: Colors.transparent,
                                color: Colors.transparent,
                                child: InkWell(
                                    splashColor: ColorsResources.lightBlue,
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () async {

                                      await launch(StringsResources.instagramLink());

                                    },
                                    child: Align(
                                        alignment: AlignmentDirectional.center,
                                        child: Image(
                                          image: AssetImage("support_icon.png"),
                                          height: 51,
                                          width: 51,
                                        )
                                    )
                                )
                            )
                        )
                    )
                  )
                )
              ],
            ),
          ),
        ),
    );
  }

  void retrieveLatestTransactions() async {

    String databaseDirectory = await getDatabasesPath();

    String transactionDatabasePath = "${databaseDirectory}/${TransactionsDatabaseInputs.transactionsDatabase}";

    bool transactionDatabaseExist = await databaseExists(transactionDatabasePath);

    if (transactionDatabaseExist) {

      TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

      List<TransactionsData> latestTransactions = await transactionsDatabaseQueries.getAllTransactions(TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);

      if (latestTransactions.length > 10) {

        latestTransactions = latestTransactions.sublist(0, 10);

      }

      latestTransactions.sort(((a, b) => (a.transactionTime).compareTo(b.transactionTime)));

      setState(() {

        someLatestTransactions = latestTransactions;

      });

    }

    prepareCreditCardsData();

  }

  void prepareCreditCardsData() async {

    String databaseDirectory = await getDatabasesPath();

    String creditCardDatabasePath = "${databaseDirectory}/${CreditCardsDatabaseInputs.creditCardDatabase}";

    bool creditCardDatabaseExist = await databaseExists(creditCardDatabasePath);

    if (creditCardDatabaseExist) {

      CreditCardsDatabaseQueries databaseQueries = CreditCardsDatabaseQueries();

      List<CreditCardsData> listOfAllCreditCards = await databaseQueries.getAllCreditCards(CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

      setState(() {

        allCreditCards = listOfAllCreditCards;

      });

    }

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

class UpdatedData {
  static String UpdatedDataType = LatestTransactions;

  static const String GeneralBalance = "GeneralBalance";
  static const String GeneralEarning = "GeneralEarning";
  static const String GeneralSpending = "GeneralSpending";

  static const String LatestTransactions = "LatestTransactions";
  static const String CreditCards = "CreditCards";

}