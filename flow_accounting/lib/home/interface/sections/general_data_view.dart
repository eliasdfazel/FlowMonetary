/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/14/22, 6:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/general_data/ui/general_information_charts.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';

class GeneralDataView extends StatefulWidget {
  const GeneralDataView({Key? key}) : super(key: key);

  @override
  State<GeneralDataView> createState() => _GeneralDataView();

}
class _GeneralDataView extends State<GeneralDataView> {

  int totalEarning = 0;

  int totalBalance = 0;

  int totalSpending = 0;

  @override
  void initState() {

    retrieveTotalEarning();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget generalDataContent = const Divider(
      height: 1,
      color: Colors.transparent,
    );

    if (totalEarning > 0) {

      generalDataContent = Padding(
        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 73,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 21,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  StringsResources.totalEarningText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 13,
                                      shadows: [
                                        Shadow(
                                            color: ColorsResources.darkTransparent,
                                            blurRadius: 11,
                                            offset: Offset(1.0, 1.0)
                                        ),
                                        Shadow(
                                            color: ColorsResources.light,
                                            blurRadius: 11,
                                            offset: Offset(-1.0, -1.0)
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 51,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(23),
                                    bottomLeft: Radius.circular(23),
                                    topRight: Radius.circular(7),
                                    bottomRight: Radius.circular(23)
                                ),
                                child: Material(
                                  shadowColor: Colors.transparent,
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: ColorsResources.green.withOpacity(0.3),
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () {

                                      NavigationProcess().goTo(context, const GeneralFinancialCharts());

                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(23),
                                              topRight: Radius.circular(7),
                                              bottomLeft: Radius.circular(23),
                                              bottomRight: Radius.circular(23)
                                          ),
                                          border: Border(
                                              top: BorderSide(
                                                color: ColorsResources.green.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: ColorsResources.green.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              left: BorderSide(
                                                color: ColorsResources.green.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              right: BorderSide(
                                                color: ColorsResources.green.withOpacity(0.3),
                                                width: 1,
                                              )
                                          ),
                                          color: ColorsResources.green.withOpacity(0.13)
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${totalEarning}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: ColorsResources.applicationDarkGeeksEmpire,
                                              fontSize: 17,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.white,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 11
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 21,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  StringsResources.totalBalanceText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 13,
                                      shadows: [
                                        Shadow(
                                            color: ColorsResources.darkTransparent,
                                            blurRadius: 11,
                                            offset: Offset(1.0, 1.0)
                                        ),
                                        Shadow(
                                            color: ColorsResources.light,
                                            blurRadius: 11,
                                            offset: Offset(-1.0, -1.0)
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 51,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(23),
                                    bottomLeft: Radius.circular(23),
                                    topRight: Radius.circular(7),
                                    bottomRight: Radius.circular(23)
                                ),
                                child: Material(
                                  shadowColor: Colors.transparent,
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: ColorsResources.applicationGeeksEmpire.withOpacity(0.3),
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () {

                                      NavigationProcess().goTo(context, const GeneralFinancialCharts());

                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(23),
                                              topRight: Radius.circular(7),
                                              bottomLeft: Radius.circular(23),
                                              bottomRight: Radius.circular(23)
                                          ),
                                          border: Border(
                                              top: BorderSide(
                                                color: ColorsResources.applicationGeeksEmpire.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: ColorsResources.applicationGeeksEmpire.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              left: BorderSide(
                                                color: ColorsResources.applicationGeeksEmpire.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              right: BorderSide(
                                                color: ColorsResources.applicationGeeksEmpire.withOpacity(0.3),
                                                width: 1,
                                              )
                                          ),
                                          color: ColorsResources.applicationGeeksEmpire.withOpacity(0.13)
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${totalBalance}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: ColorsResources.applicationDarkGeeksEmpire,
                                              fontSize: 19,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.white,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 11
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 21,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  StringsResources.totalSpendingText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 13,
                                      shadows: [
                                        Shadow(
                                            color: ColorsResources.darkTransparent,
                                            blurRadius: 11,
                                            offset: Offset(1.0, 1.0)
                                        ),
                                        Shadow(
                                            color: ColorsResources.light,
                                            blurRadius: 11,
                                            offset: Offset(-1.0, -1.0)
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 51,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(23),
                                    bottomLeft: Radius.circular(23),
                                    topRight: Radius.circular(7),
                                    bottomRight: Radius.circular(23)
                                ),
                                child: Material(
                                  shadowColor: Colors.transparent,
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: ColorsResources.red.withOpacity(0.3),
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () {

                                      Future.delayed(const Duration(milliseconds: 777), (){

                                        NavigationProcess().goTo(context, const GeneralFinancialCharts());

                                      });

                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(23),
                                              topRight: Radius.circular(7),
                                              bottomLeft: Radius.circular(23),
                                              bottomRight: Radius.circular(23)),
                                          border: Border(
                                              top: BorderSide(
                                                color: ColorsResources.red.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              bottom: BorderSide(
                                                color: ColorsResources.red.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              left: BorderSide(
                                                color: ColorsResources.red.withOpacity(0.3),
                                                width: 1,
                                              ),
                                              right: BorderSide(
                                                color: ColorsResources.red.withOpacity(0.3),
                                                width: 1,
                                              )
                                          ),
                                          color: ColorsResources.red.withOpacity(0.13)
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${totalSpending}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: ColorsResources.applicationDarkGeeksEmpire,
                                              fontSize: 17,
                                              shadows: [
                                                Shadow(
                                                    color: ColorsResources.white,
                                                    offset: Offset(0, 0),
                                                    blurRadius: 11
                                                )
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

    }

    return generalDataContent;
  }

  void retrieveTotalEarning() async {

    int calculatedEarning = 0;

    TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

    List<TransactionsData> allTransactions = await transactionsDatabaseQueries.getAllTransactions(TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);

    for (TransactionsData element in allTransactions) {

      if (element.transactionType == TransactionsData.TransactionType_Receive) {

        calculatedEarning += int.parse(element.amountMoney);

      }

    }

    setState(() {

      totalEarning = calculatedEarning;

    });

    retrieveTotalSpending();

  }

  void retrieveTotalSpending() async {

    int calculatedSpending = 0;

    TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

    List<TransactionsData> allTransactions = await transactionsDatabaseQueries.getAllTransactions(TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);

    for (TransactionsData element in allTransactions) {

      if (element.transactionType == TransactionsData.TransactionType_Send) {

        calculatedSpending += int.parse(element.amountMoney);

      }

    }

    setState(() {

      totalSpending = calculatedSpending;

    });

    retrieveTotalBalance();

  }

  void retrieveTotalBalance() async {

    setState(() {

      totalBalance = totalEarning - totalSpending;

    });

  }

}