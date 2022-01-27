import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/extensions/CreditCardNumber.dart';
import 'package:flutter/material.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: TransactionsOutputView()));

}

class TransactionsOutputView extends StatefulWidget {
  const TransactionsOutputView({Key? key}) : super(key: key);

  @override
  _TransactionsOutputView createState() => _TransactionsOutputView();
}
class _TransactionsOutputView extends State<TransactionsOutputView> {

  List<TransactionsData> allTransactions = [];
  List<Widget> allTransactionsItems = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    retrieveAllTransactions();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Sans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(0, 73, 0, 0),
              physics: const BouncingScrollPhysics(),
              children: allTransactionsItems,
            ),
            Positioned(
                top: 19,
                left: 13,
                child:  InkWell(
                  onTap: () {

                    Navigator.pop(context);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: ColorsResources.blueGrayLight.withOpacity(0.7),
                              blurRadius: 7,
                              spreadRadius: 0.1,
                              offset: const Offset(0.0, 3.7)
                          )
                        ]
                    ),
                    child: const Image(
                      image: AssetImage("go_previous_icon.png"),
                      fit: BoxFit.scaleDown,
                      width: 41,
                      height: 41,
                    ),
                  ),
                )
            ),
          ],
        )
      ),
    ));
  }

  Widget outputItem(TransactionsData transactionsData) {

    String transactionTypeMark = TransactionsData.TransactionType_Send;
    Color transactionTypeColor = ColorsResources.dark;

    switch (transactionsData.transactionType) {
      case TransactionsData.TransactionType_Send: {

        transactionTypeMark = TransactionsData.TransactionType_Send;
        transactionTypeColor = Colors.red;

        break;
      }
      case TransactionsData.TransactionType_Receive: {

        transactionTypeMark = TransactionsData.TransactionType_Receive;
        transactionTypeColor = Colors.green;

        break;
      }
    }

    return Padding(
      padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(17),
                topRight: Radius.circular(17),
                bottomLeft: Radius.circular(17),
                bottomRight: Radius.circular(17)
            ),
            gradient: const LinearGradient(
                colors: [
                  ColorsResources.white,
                  ColorsResources.light,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                transform: GradientRotation(45),
                tileMode: TileMode.clamp),
            boxShadow: [
              BoxShadow(
                  color: Color(transactionsData.colorTag),
                  blurRadius: 7,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.normal,
                  offset: const Offset(0.0, 7.0)
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 99,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 19,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 7, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: transactionTypeColor.withOpacity(0.3),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                transactionTypeMark,
                                style: TextStyle(
                                    color: transactionTypeColor,
                                    fontSize: 65
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 51,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 13,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                        child: Container(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              prepareCreditCard(transactionsData.sourceCardNumber),
                              style: const TextStyle(
                                  color: ColorsResources.dark,
                                  fontSize: 17
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Container(
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.center,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              transactionsData.transactionTime,
                              style: const TextStyle(
                                color: ColorsResources.dark,
                                fontSize: 11,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void retrieveAllTransactions() async {

    List<Widget> preparedAllTransactionsItem = [];

    var databaseQueries = DatabaseQueries();

    var databaseContents = await databaseQueries.getAllTransactions(DatabaseInputs.databaseTableName);

    databaseContents.forEach((element) {

      preparedAllTransactionsItem.add(outputItem(element));

    });

    setState(() {

      allTransactionsItems = preparedAllTransactionsItem;

    });

  }

}