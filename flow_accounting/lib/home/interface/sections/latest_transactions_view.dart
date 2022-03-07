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
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flutter/material.dart';

class LatestTransactionsView extends StatefulWidget {

  List<TransactionsData> latestTransactionsData = [];

  LatestTransactionsView({Key? key, required this.latestTransactionsData}) : super(key: key);

  @override
  State<LatestTransactionsView> createState() => _LatestTransactionsView();

}
class _LatestTransactionsView extends State<LatestTransactionsView> {

  TextEditingController textEditorControllerQuery = TextEditingController();

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

    List<Widget> transactionItem = [];

    for (var transactionData in widget.latestTransactionsData) {

      transactionItem.add(transactionSummaryItem(transactionData));

    }

    Widget latestTransactionsContent = const Divider(height: 1);

    if (transactionItem.isNotEmpty) {

      latestTransactionsContent = Padding(
        padding: const EdgeInsets.fromLTRB(13, 13, 13, 3),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(13, 3, 13, 0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  StringsResources.transactionLatest,
                  style: TextStyle(
                      color: ColorsResources.applicationGeeksEmpire,
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
                      ]
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 57,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  scrollDirection: Axis.horizontal,
                  children: transactionItem,
                ),
              ),
            )
          ],
        ),
      );

    }

    return latestTransactionsContent;
  }

  Widget transactionSummaryItem(TransactionsData transactionsData) {

    Color transactionColor = ColorsResources.light;

    if (transactionsData.transactionType == TransactionsData.TransactionType_Receive) {

      transactionColor = ColorsResources.green;

    } else if (transactionsData.transactionType == TransactionsData.TransactionType_Send) {

      transactionColor = ColorsResources.red;

    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Container(
          padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
          decoration: BoxDecoration(
            color: transactionColor.withOpacity(0.113),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
                bottomLeft: Radius.circular(13),
                bottomRight: Radius.circular(13)),
            border: Border(
                top: BorderSide(
                  color: transactionColor,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: transactionColor,
                  width: 1,
                ),
                left: BorderSide(
                  color: transactionColor,
                  width: 1,
                ),
                right: BorderSide(
                  color: transactionColor,
                  width: 1,
                )
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "${transactionsData.transactionType} ${transactionsData.amountMoney}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(3, 3),
                    blurRadius: 7,
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

}