/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:50 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/home/interface/sections/latest_transactions_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_cards_list_view.dart';
import 'sections/features_view.dart';
import 'sections/general_data_view.dart';
import 'sections/top_bar_view.dart';

class HomePage extends StatefulWidget {

  final String applicationName;

  const HomePage({Key? key, required this.applicationName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

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
                                latestTransactionsData: retrieveLatestTransactions()
                            ),
                            const GeneralDataView(),
                            CreditCardsListView(
                              allCreditCardsData: prepareCreditCardsData(),
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
        ));
  }

  List<TransactionsData> retrieveLatestTransactions() {

    List<TransactionsData> latestTransactions = [];

    //Get From Database
    latestTransactions.add(TransactionsData(
      id: 1,
      amountMoney: "500",
      transactionType: TransactionsData.TransactionType_Receive,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.black.value,
      budgetName: "خانه",
    ));
    latestTransactions.add(TransactionsData(
      id: 2,
      amountMoney: "1100",
      transactionType: TransactionsData.TransactionType_Receive,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.black.value,
      budgetName: "خانه",
    ));
    latestTransactions.add(TransactionsData(
      id: 3,
      amountMoney: "9990",
      transactionType: TransactionsData.TransactionType_Receive,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.greenGray.value,
      budgetName: "مغازه",
    ));
    latestTransactions.add(TransactionsData(
      id: 4,
      amountMoney: "330",
      transactionType: TransactionsData.TransactionType_Send,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.gameGeeksEmpire.value,
      budgetName: "گربه",
    ));
    latestTransactions.add(TransactionsData(
      id: 5,
      amountMoney: "550",
      transactionType: TransactionsData.TransactionType_Send,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.black.value,
      budgetName: "آکواریوم",
    ));
    latestTransactions.add(TransactionsData(
      id: 6,
      amountMoney: "300",
      transactionType: TransactionsData.TransactionType_Receive,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.black.value,
      budgetName: "خانه",
    ));
    latestTransactions.add(TransactionsData(
      id: 7,
      amountMoney: "900",
      transactionType: TransactionsData.TransactionType_Receive,
      sourceBankName: "EnBank",
      sourceCardNumber: "1111222233334458",
      sourceUsername: "Elias",
      targetBankName: "Saderat",
      targetCardNumber: "9999888877776541",
      targetUsername: "Aban",
      transactionTime: "13:19 - 8/7/2013",
      colorTag: ColorsResources.primaryColor.value,
      budgetName: "خانه",
    ));

    return latestTransactions;
  }

  List<CreditCardsData> prepareCreditCardsData() {

    //Get From Database

    return [
      CreditCardsData(
          id: 1,
          cardNumber: "6274121210306479",
          cardExpiry: "07-05",
          cardHolderName: "آبان آبسالان",
          cvv: "456",
          bankName: "اقتصاد نوین",
          cardBalance: "17777"
      ),
      CreditCardsData(
          id: 2,
          cardNumber: "6074121210306479",
          cardExpiry: "01-04",
          cardHolderName: "آبان آبسالان",
          cvv: "456",
          bankName: "اقتصاد نوین",
          cardBalance: "27777"
      ),
      CreditCardsData(
          id: 3,
          cardNumber: "5374121210306479",
          cardExpiry: "04-08",
          cardHolderName: "آبان آبسالان",
          cvv: "456",
          bankName: "اقتصاد نوین",
          cardBalance: "37777"
      )
    ];
  }

}