import 'package:flow_accounting/transactions/database/io/inputs.dart';
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



    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          controller: textEditorControllerName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: TextField(
                          obscureText: false,
                          controller: textEditorControllerEmail,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email Address',
                            hintText: 'Enter Email Address',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: const Text('Insert'),
                  onPressed: (){

                    var databaseInputs = DatabaseInputs();

                    databaseInputs.insertFinancialReport(FinancialReports(id: 666, name: textEditorControllerName.text, type: 1));

                    print(">>> >> > " + textEditorControllerName.text + " | " + textEditorControllerEmail.text);
                    
                  },
                )
              ],
            )
        )
    );
  }
}