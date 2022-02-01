import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/extensions/CreditCardNumber.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

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

    String transactionCardNumber = transactionsData.sourceCardNumber;

    String transactionName = transactionsData.sourceUsername;
    String transactionBank = transactionsData.sourceBankName;

    switch (transactionsData.transactionType) {
      case TransactionsData.TransactionType_Send: {

        transactionTypeMark = TransactionsData.TransactionType_Send;
        transactionTypeColor = Colors.red;

        transactionName = transactionsData.targetUsername;

        break;
      }
      case TransactionsData.TransactionType_Receive: {

        transactionTypeMark = TransactionsData.TransactionType_Receive;
        transactionTypeColor = Colors.green;

        transactionName = transactionsData.sourceUsername;

        break;
      }
    }

    return Padding(
      padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
      child: PhysicalModel(
        color: ColorsResources.light,
        elevation: 7,
        shadowColor: transactionTypeColor,
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(17)),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                  bottomLeft: Radius.circular(17),
                  bottomRight: Radius.circular(17)
              ),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.white,
                    ColorsResources.light,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp
              ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 59,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 11, 13, 0),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Marquee(
                                      text: transactionsData.amountMoney,
                                      style: const TextStyle(
                                        color: ColorsResources.dark,
                                        fontSize: 31,
                                        fontFamily: "Numbers",
                                      ),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      blankSpace: 173.0,
                                      velocity: 37.0,
                                      pauseAfterRound: const Duration(milliseconds: 500),
                                      showFadingOnlyWhenScrolling: true,
                                      startPadding: 13.0,
                                      accelerationDuration: const Duration(milliseconds: 500),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration: const Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 39,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 11, 13, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              transactionName,
                                              style: TextStyle(
                                                color: ColorsResources.dark.withOpacity(0.579),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              transactionBank,
                                              style: TextStyle(
                                                color: ColorsResources.dark.withOpacity(0.579),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            )
                          ],
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
                        padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                        child: Container(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              prepareCreditCard(transactionCardNumber),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                        child: Container(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                transactionsData.transactionTime,
                                style: TextStyle(
                                    color: ColorsResources.dark.withOpacity(0.59),
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
      ),
    );
  }

  void retrieveAllTransactions() async {

    List<Widget> preparedAllTransactionsItem = [];

    var databaseQueries = DatabaseQueries();

    var databaseContents = await databaseQueries.getAllTransactions(DatabaseInputs.databaseTableName);

    for (var element in databaseContents) {

      preparedAllTransactionsItem.add(outputItem(element));

    }

    setState(() {

      allTransactionsItems = preparedAllTransactionsItem;

    });

  }

}