/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 7, 13, 0),
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
                                          color: ColorsResources.white,
                                          offset: Offset(0, 0),
                                          blurRadius: 11
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 51,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)
                                  ),
                                  border: const Border(
                                      top: BorderSide(
                                        color: ColorsResources.primaryColorDark,
                                        width: 1,
                                      ),
                                      bottom: BorderSide(
                                        color: ColorsResources.primaryColorDark,
                                        width: 1,
                                      ),
                                      left: BorderSide(
                                        color: ColorsResources.primaryColorDark,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: ColorsResources.primaryColorDark,
                                        width: 1,
                                      )
                                  ),
                                  color: ColorsResources.light.withOpacity(0.3)
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${totalEarning}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: ColorsResources.dark,
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
                                          color: ColorsResources.white,
                                          offset: Offset(0, 0),
                                          blurRadius: 11
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 51,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)
                                  ),
                                  border: const Border(
                                      top: BorderSide(
                                        color: ColorsResources.applicationGeeksEmpire,
                                        width: 1,
                                      ),
                                      bottom: BorderSide(
                                        color: ColorsResources.applicationGeeksEmpire,
                                        width: 1,
                                      ),
                                      left: BorderSide(
                                        color: ColorsResources.applicationGeeksEmpire,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: ColorsResources.applicationGeeksEmpire,
                                        width: 1,
                                      )
                                  ),
                                  color: ColorsResources.light.withOpacity(0.3)
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${totalBalance}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: ColorsResources.dark,
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
                                StringsResources.totalSpendingText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: ColorsResources.dark,
                                    fontSize: 13,
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
                          SizedBox(
                            width: double.infinity,
                            height: 51,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(23),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(23),
                                      bottomRight: Radius.circular(23)),
                                  border: const Border(
                                      top: BorderSide(
                                        color: ColorsResources.gameGeeksEmpire,
                                        width: 1,
                                      ),
                                      bottom: BorderSide(
                                        color: ColorsResources.gameGeeksEmpire,
                                        width: 1,
                                      ),
                                      left: BorderSide(
                                        color: ColorsResources.gameGeeksEmpire,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: ColorsResources.gameGeeksEmpire,
                                        width: 1,
                                      )
                                  ),
                                  color: ColorsResources.light.withOpacity(0.3)
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "${totalSpending}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: ColorsResources.dark,
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

  void retrieveTotalEarning() async {

    int calculatedEarning = 0;

    TransactionsDatabaseQueries transactionsDatabaseQueries = TransactionsDatabaseQueries();

    List<TransactionsData> allTransactions = await transactionsDatabaseQueries.getAllTransactions(TransactionsDatabaseInputs.databaseTableName);

    for (TransactionsData element in allTransactions) {

      if (element.transactionType == TransactionsData.TransactionType_Receive) {

        calculatedEarning += int.parse(element.amountMoney ?? "0");

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

    List<TransactionsData> allTransactions = await transactionsDatabaseQueries.getAllTransactions(TransactionsDatabaseInputs.databaseTableName);

    for (TransactionsData element in allTransactions) {

      if (element.transactionType == TransactionsData.TransactionType_Send) {

        calculatedSpending += int.parse(element.amountMoney ?? "0");

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