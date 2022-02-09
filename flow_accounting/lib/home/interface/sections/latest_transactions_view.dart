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

    widget.latestTransactionsData.forEach((transactionData) {

      transactionItem.add(transactionSummaryItem(transactionData));

    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
      child: Column(
        children: [
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

  Widget transactionSummaryItem(TransactionsData transactionsData) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      child: Container(
          padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
          decoration: const BoxDecoration(
            color: ColorsResources.lightTransparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(51),
                topRight: Radius.circular(51),
                bottomLeft: Radius.circular(51),
                bottomRight: Radius.circular(51)),
            border: Border(
                top: BorderSide(
                  color: ColorsResources.light,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: ColorsResources.light,
                  width: 1,
                ),
                left: BorderSide(
                  color: ColorsResources.light,
                  width: 1,
                ),
                right: BorderSide(
                  color: ColorsResources.light,
                  width: 1,
                )
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "${transactionsData.transactionType} \$${transactionsData.amountMoney}",
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