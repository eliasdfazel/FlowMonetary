/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */


import 'package:flutter/material.dart';

class LatestTransactionsView extends StatefulWidget {

  LatestTransactionsView({Key? key}) : super(key: key);

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

    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 73,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                scrollDirection: Axis.horizontal,
                children: [

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget transactionSummaryItem() {

    return Container(

    );
  }

}