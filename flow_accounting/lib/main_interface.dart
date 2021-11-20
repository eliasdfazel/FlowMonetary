import 'package:flow_accounting/database/operations/inputs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.fromLTRB(19, 51, 19, 13),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
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

    return Scaffold(
      body: Column(children: [titleSection]),
      floatingActionButton: FloatingActionButton(
        onPressed: tapAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  int aCounter = 0;

  void tapAction() {

    var databaseInputs = DatabaseInputs();


    aCounter = aCounter * 2;

    setState(() {
      aCounter++;
    });
  }
}
