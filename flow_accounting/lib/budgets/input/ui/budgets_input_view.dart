/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/budgets/database/io/inputs.dart';
import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp( home: BudgetsView()));
}

class BudgetsView extends StatefulWidget {
  const BudgetsView({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<BudgetsView> {

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
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child:  Text(
                          'Transactions',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black87,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(3, 3),
                                blurRadius: 7,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          controller: textEditorControllerName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                            hintText: 'Enter Your Name',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextField(
                          obscureText: false,
                          controller: textEditorControllerEmail,
                          decoration: const InputDecoration(
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

                    var databaseInputs = BudgetDatabaseInputs();

                    databaseInputs.insertBudget(BudgetsData(id: DateTime.now().millisecondsSinceEpoch));

                    final snackBar = SnackBar(
                      content: Text("${textEditorControllerName.text} |  ${textEditorControllerEmail.text}"),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  },
                )
              ],
            )
        )
    );
  }
}