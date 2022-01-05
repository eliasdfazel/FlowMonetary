import 'package:flow_accounting/resources/colors.dart';
import 'package:flow_accounting/resources/strings.dart';
import 'package:flow_accounting/transactions/input/ui/transactions_input_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    initializeReportsOverview();

    return SafeArea (child: MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsPalette.black,
      theme: ThemeData(fontFamily: 'Sans'),
      home: Scaffold(
        backgroundColor: ColorsPalette.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
          child: Container (
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
              gradient: LinearGradient(
                  colors: [
                    ColorsPalette.white,
                    ColorsPalette.primaryColorLighter,
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
                            Strings.applicationName,
                            textDirection: TextDirection.rtl,
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


                  },
                )
              ],
            ),
          ),),
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

  void tapAction() async {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TransactionsView()),
    );

  }
}