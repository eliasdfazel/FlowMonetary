/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp( home: TransactionsOutputView()));
}

class TransactionsOutputView extends StatefulWidget {
  const TransactionsOutputView({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<TransactionsOutputView> {

  TextEditingController textEditorControllerName = TextEditingController();
  TextEditingController textEditorControllerEmail = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // textEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: MaterialApp(
      home: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Demo'),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('Grid Item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('List Item $index'),
                    );
                  },
                ),
              ),
            ],
          )
      ),
    ));
  }

  void initializeReportsOverview() async {

    // var databaseQueries = DatabaseQueries();
    //
    // var databaseContents = await databaseQueries.queryFinancialReport(1);
    //
    // nameQuery = (await databaseQueries.extractFinancialReport(databaseContents)).sourceCardNumber;
    // typeQuery = (await databaseQueries.extractFinancialReport(databaseContents)).type.toString();
    //
    // setState(() {
    //   nameQuery;
    //   typeQuery;
    // });

  }
}