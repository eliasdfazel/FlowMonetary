import 'package:flow_accounting/transactions/database/io/operations/inputs.dart';
import 'package:flow_accounting/transactions/database/structures/financial_reports.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp( home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {

  TextEditingController textEditorController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // textEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter TextField Example'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: textEditorController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    obscureText: false,
                    controller: textEditorController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      hintText: 'Enter Email Address',
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: const Text('Saved'),
                  onPressed: (){

                    var databaseInputs = DatabaseInputs();

                    databaseInputs.insertFinancialReport(FinancialReports(id:
                    666, name: textEditorController.text, type: 1));

                    print(">>> >> > " + textEditorController.text);
                    
                  },
                )
              ],
            )
        )
    );
  }
}