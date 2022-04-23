/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/11/22, 2:27 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/buy_invoices/database/io/inputs.dart';
import 'package:flow_accounting/buy_invoices/database/io/queries.dart';
import 'package:flow_accounting/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/buy_invoices/input/ui/buy_invoices_input_view.dart';
import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/io/queries.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/home/interface/sections/latest_transactions_view.dart';
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/products/input/ui/products_input_view.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/sell_invoices/database/io/queries.dart';
import 'package:flow_accounting/sell_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/sell_invoices/input/ui/sell_invoices_input_view.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_cards_list_view.dart';
import 'sections/features_view.dart';
import 'sections/general_data_view.dart';
import 'sections/top_bar_view.dart';

class FlowDashboard extends StatefulWidget {

  const FlowDashboard({Key? key}) : super(key: key);

  @override
  State<FlowDashboard> createState() => FlowDashboardState();
}
class FlowDashboardState extends State<FlowDashboard> {

  LocalAuthentication localAuthentication = LocalAuthentication();

  List<TransactionsData> someLatestTransactions = [];

  List<CreditCardsData> allCreditCards = [];

  @override
  void initState() {

    retrieveLatestTransactions();

    super.initState();
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
                // Support
                Positioned(
                  left: 19,
                  bottom: 19,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(51),
                            topRight: Radius.circular(51),
                            bottomLeft: Radius.circular(19),
                            bottomRight: Radius.circular(51)),
                        boxShadow: [
                        BoxShadow(
                            color: ColorsResources.blue.withOpacity(0.79),
                            spreadRadius: 0.9,
                            blurRadius: 7,
                            offset: Offset(0, 1.9)
                        ),
                        BoxShadow(
                            color: ColorsResources.blue,
                            spreadRadius: 0.3,
                            blurRadius: 0.3,
                            offset: Offset(0, 1.5)
                        ),
                      ]
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(51),
                          topRight: Radius.circular(51),
                          bottomLeft: Radius.circular(19),
                          bottomRight: Radius.circular(51)
                        ),
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
                            child: Tooltip(
                                triggerMode: TooltipTriggerMode.longPress,
                                message: StringsResources.supportHint(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(51),
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorsResources.black,
                                      ColorsResources.primaryColorDark
                                    ],
                                    transform: const GradientRotation(45),
                                  ),
                                ),
                                height: 31,
                                padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                                preferBelow: false,
                                textStyle: const TextStyle(
                                  color: ColorsResources.light,
                                  fontSize: 13,
                                ),
                                showDuration: const Duration(seconds: 3),
                                waitDuration: const Duration(seconds: 5),
                                child: Material(
                                    shadowColor: Colors.transparent,
                                    color: Colors.transparent,
                                    child: InkWell(
                                        splashColor: ColorsResources.lightBlue,
                                        splashFactory: InkRipple.splashFactory,
                                        onTap: () async {

                                          await launch(StringsResources.supportLink());

                                        },
                                        child: Align(
                                            alignment: AlignmentDirectional.center,
                                            child: SizedBox(
                                                height: 51,
                                                width: 51,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                  child: Image(
                                                    image: AssetImage("support_icon.png"),
                                                    color: ColorsResources.lightestBlue,
                                                  ),
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                  )
                ),
                // Barcode
                Positioned(
                    right: 19,
                    bottom: 19,
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(51),
                                topRight: Radius.circular(51),
                                bottomLeft: Radius.circular(51),
                                bottomRight: Radius.circular(19)),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorsResources.blue.withOpacity(0.79),
                                  spreadRadius: 0.9,
                                  blurRadius: 7,
                                  offset: Offset(0, 1.9)
                              ),
                              BoxShadow(
                                  color: ColorsResources.blue,
                                  spreadRadius: 0.3,
                                  blurRadius: 0.3,
                                  offset: Offset(0, 1.5)
                              ),
                            ]
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(51),
                                topRight: Radius.circular(51),
                                bottomLeft: Radius.circular(51),
                                bottomRight: Radius.circular(19)
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black,
                                        ColorsResources.dark,
                                      ],
                                      tileMode: TileMode.clamp,
                                      transform: GradientRotation(45),
                                    )
                                ),
                                child: Tooltip(
                                    triggerMode: TooltipTriggerMode.longPress,
                                    message: StringsResources.barcodeScannerHint(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(51),
                                      gradient: const LinearGradient(
                                        colors: [
                                          ColorsResources.black,
                                          ColorsResources.primaryColorDark
                                        ],
                                        transform: const GradientRotation(45),
                                      ),
                                    ),
                                    height: 31,
                                    padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                                    preferBelow: false,
                                    textStyle: const TextStyle(
                                      color: ColorsResources.light,
                                      fontSize: 13,
                                    ),
                                    showDuration: const Duration(seconds: 3),
                                    waitDuration: const Duration(seconds: 5),
                                    child: Material(
                                        shadowColor: Colors.transparent,
                                        color: Colors.transparent,
                                        child: InkWell(
                                            splashColor: ColorsResources.lightBlue,
                                            splashFactory: InkRipple.splashFactory,
                                            onTap: () {

                                              invokeBarcodeScanner();

                                            },
                                            child: Align(
                                                alignment: AlignmentDirectional.center,
                                                child: SizedBox(
                                                    height: 51,
                                                    width: 51,
                                                    child: Padding(
                                                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                        child: Padding(
                                                            padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                                                            child: Image(
                                                              image: AssetImage("qr_scan_icon.png"),
                                                              color: ColorsResources.lightestBlue,
                                                              fit: BoxFit.cover,
                                                            )
                                                        )
                                                    )
                                                )
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

    String transactionDatabasePath = "${databaseDirectory}/${TransactionsDatabaseInputs.transactionsDatabase()}";

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

    String creditCardDatabasePath = "${databaseDirectory}/${CreditCardsDatabaseInputs.creditCardDatabase()}";

    bool creditCardDatabaseExist = await databaseExists(creditCardDatabasePath);

    if (creditCardDatabaseExist) {

      CreditCardsDatabaseQueries databaseQueries = CreditCardsDatabaseQueries();

      List<CreditCardsData> listOfAllCreditCards = await databaseQueries.getAllCreditCards(CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

      setState(() {

        allCreditCards = listOfAllCreditCards;

      });

    }

  }

  void invokeBarcodeScanner() async {

    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#0095ff",
        StringsResources.cancelText(),
        true,
        ScanMode.QR
    );

    if (barcodeScanResult.contains("Product_")) {

      String productId = barcodeScanResult.replaceAll("Product_", "");

      //Get Specific Product Data then Pass It to Edit
      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      ProductsData scannedProductData = await productsDatabaseQueries.querySpecificProductById(productId, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

      Future.delayed(Duration(milliseconds: 753), () {

        NavigationProcess().goTo(context, ProductsInputView(productsData: scannedProductData,));

      });

      debugPrint("Product Id Detected ${productId}");

    } else if (barcodeScanResult.contains("BuyInvoices_")) {

      String buyInvoiceId = barcodeScanResult.replaceAll("BuyInvoices_", "");

      BuyInvoicesDatabaseQueries buyInvoicesDatabaseQueries = BuyInvoicesDatabaseQueries();

      BuyInvoicesData scannedBuyInvoicesData = await buyInvoicesDatabaseQueries.querySpecificBuyInvoiceById(buyInvoiceId, BuyInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);


      Future.delayed(Duration(milliseconds: 753), () {

        NavigationProcess().goTo(context, BuyInvoicesInputView(buyInvoicesData: scannedBuyInvoicesData));

      });

      debugPrint("Buy Invoice Id Detected ${buyInvoiceId}");

    } else if (barcodeScanResult.contains("SellInvoices_")) {

      String sellInvoiceId = barcodeScanResult.replaceAll("SellInvoices_", "");

      SellInvoicesDatabaseQueries sellInvoicesDatabaseQueries = SellInvoicesDatabaseQueries();

      SellInvoicesData scannedSellInvoicesData = await sellInvoicesDatabaseQueries.querySpecificSellInvoiceById(sellInvoiceId, BuyInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

      Future.delayed(Duration(milliseconds: 753), () {

        NavigationProcess().goTo(context, SellInvoicesInputView(sellInvoicesData: scannedSellInvoicesData));

      });

      debugPrint("Buy Invoice Id Detected ${sellInvoiceId}");

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