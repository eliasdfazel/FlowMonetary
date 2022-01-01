import 'package:flow_accounting/interface/new_document.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String nameQuery = '';
  String typeQuery = '';

  @override
  Widget build(BuildContext context) {

    Widget titleSection = Container(
      padding: const EdgeInsets.fromLTRB(19, 51, 19, 13),
      child: Row(
        children: <Widget>[
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    typeQuery,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  nameQuery,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );

    initializeReportsOverview();

    return Scaffold(
      body: Column(
          children: [titleSection]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tapAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void initializeReportsOverview() async {

    var databaseQueries = DatabaseQueries();

    var databaseContents = await databaseQueries.queryFinancialReport(1);

    nameQuery = (await databaseQueries.extractFinancialReport(databaseContents)).name;
    typeQuery = (await databaseQueries.extractFinancialReport(databaseContents)).type.toString();

    setState(() {
      nameQuery;
      typeQuery;
    });

  }

  void tapAction() async {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );

  }
}