import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: TransactionsView()));

}

class TransactionsView extends StatefulWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {

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

    return SafeArea (child: MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(fontFamily: 'Sans'),
      home: Scaffold(
        backgroundColor: ColorsResources.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
          child: Container (
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.white,
                    ColorsResources.primaryColorLighter,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp),
            ),
            child: Column ( /*** Page Content ***/
              children: [
                Expanded(child: ListView(children: [
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
                ])),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: const Text('Insert'),
                  onPressed: () {

                    var databaseInputs = DatabaseInputs();

                    final snackBar = SnackBar(
                      content: Text("${textEditorControllerName.text} |  ${textEditorControllerEmail.text}"),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {

                          // databaseInputs.insertFinancialReport(TransactionsData(id: 666, sourceCardNumber: textEditorControllerName.text, type: 1));

                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  },
                )
              ],
            ),
          ),),
      ),
    ));
  }
}

/*Positioned(
                          bottom: 13,
                          left: 10.0,
                          right: 10.0,
                          child: SizedBox(
                            width: 150,
                            height: 53,
                            child: MaterialButton(
                              elevation: 7,
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: const Text('Insert'),
                              onPressed: () {


                              },
                            ),
                          )
                      )*/