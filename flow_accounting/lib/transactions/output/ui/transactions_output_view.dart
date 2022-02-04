
import 'package:blur/blur.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
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

  TextEditingController textEditorControllerQuery = TextEditingController();

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
          backgroundColor: ColorsResources.black,
          body: Padding(
          padding: const EdgeInsets.fromLTRB(1.1, 3, 1.1, 3),
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
                    ColorsResources.primaryColorLighter,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp),
            ),
            child: Stack(
              children: [
                const Opacity(
                  opacity: 0.07,
                  child: Image(
                    image: AssetImage("input_background_pattern.png"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                ListView(
                  padding: const EdgeInsets.fromLTRB(0, 73, 0, 0),
                  physics: const BouncingScrollPhysics(),
                  children: allTransactionsItems,
                ),
                Positioned(
                    top: 19,
                    left: 13,
                    child: InkWell(
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
                Positioned(
                    top: 19,
                    right: 13,
                    child: SizedBox(
                      height: 43,
                      width: 321,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 11,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 43,
                                    width: double.infinity,
                                    child: Blur(
                                      blur: 5,
                                      borderRadius: BorderRadius.circular(51),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorsResources.white.withOpacity(0.3),
                                                  ColorsResources.primaryColorLighter.withOpacity(0.3),
                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: const [0.0, 1.0],
                                                transform: const GradientRotation(45),
                                                tileMode: TileMode.clamp
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {

                                      sortTransactionsByMoneyAmount(allTransactions);

                                    },
                                    child: const SizedBox(
                                      height: 43,
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          StringsResources.sortMoneyAmountHigh,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: ColorsResources.applicationGeeksEmpire,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 11,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 43,
                                    width: double.infinity,
                                    child: Blur(
                                      blur: 5,
                                      borderRadius: BorderRadius.circular(51),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorsResources.white.withOpacity(0.3),
                                                  ColorsResources.primaryColorLighter.withOpacity(0.3),
                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: const [0.0, 1.0],
                                                transform: const GradientRotation(45),
                                                tileMode: TileMode.clamp
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {

                                      sortTransactionsByTime(allTransactions);

                                    },
                                    child: const SizedBox(
                                      height: 43,
                                      width: double.infinity,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          StringsResources.sortTimeNew,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: ColorsResources.applicationGeeksEmpire,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 43,
                                  width: 43,
                                  child: Blur(
                                    blur: 3,
                                    borderRadius: BorderRadius.circular(51),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                ColorsResources.white.withOpacity(0.3),
                                                ColorsResources.primaryColorLighter.withOpacity(0.3),
                                              ],
                                              begin: const FractionalOffset(0.0, 0.0),
                                              end: const FractionalOffset(1.0, 0.0),
                                              stops: const [0.0, 1.0],
                                              transform: const GradientRotation(45),
                                              tileMode: TileMode.clamp
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {

                                      retrieveAllTransactions();

                                    },
                                    child: const Icon(
                                        Icons.refresh_rounded,
                                        size: 31.0,
                                        color: ColorsResources.primaryColorDark
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Positioned(
                  bottom: 19,
                  left: 11,
                  right: 11,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 59,
                      width: 199,
                      child: Stack(
                        children: [
                          const Image(
                            image: AssetImage("search_shape.png"),
                            height: 59,
                            width: 213,
                            color: ColorsResources.primaryColorDark,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {

                                String searchQuery = textEditorControllerQuery.text;

                              },
                              child: const SizedBox(
                                height: 59,
                                width: 41,
                                child: Icon(
                                  Icons.search_rounded,
                                  size: 23,
                                  color: ColorsResources.darkTransparent,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                                width: 143,
                                height: 40,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: textEditorControllerQuery,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    maxLines: 1,
                                    cursorColor: ColorsResources.primaryColor,
                                    autocorrect: true,
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(51),
                                              topRight: Radius.circular(51),
                                              bottomLeft: Radius.circular(51),
                                              bottomRight: Radius.circular(51)
                                          ),
                                          gapPadding: 5
                                      ),
                                      hintText: StringsResources.searchTransactionsText,
                                      hintStyle: TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 13.0
                                      ),
                                      labelText: StringsResources.searchText,
                                      labelStyle: TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
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
        shadowColor: transactionTypeColor.withOpacity(0.7),
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

    if (allTransactionsItems.isNotEmpty) {

      allTransactionsItems.clear();

    }

    List<Widget> preparedAllTransactionsItem = [];

    var databaseQueries = DatabaseQueries();

    allTransactions = await databaseQueries.getAllTransactions(DatabaseInputs.databaseTableName);

    for (var element in allTransactions) {

      preparedAllTransactionsItem.add(outputItem(element));

    }

    setState(() {

      allTransactionsItems = preparedAllTransactionsItem;

    });

  }

  void sortTransactionsByTime(
      List<TransactionsData> inputTransactionsList) {

    if (allTransactionsItems.isNotEmpty) {

      allTransactionsItems.clear();

    }

    inputTransactionsList.sort((a, b) => (a.transactionTime).compareTo(b.transactionTime));

    List<Widget> preparedAllTransactionsItem = [];

    for (var element in inputTransactionsList) {

      preparedAllTransactionsItem.add(outputItem(element));

    }

    setState(() {

      allTransactionsItems = preparedAllTransactionsItem;

    });

  }

  void sortTransactionsByMoneyAmount(
      List<TransactionsData> inputTransactionsList) {

    if (allTransactionsItems.isNotEmpty) {

      allTransactionsItems.clear();

    }
    inputTransactionsList.sort((a, b) => (a.amountMoney).compareTo(b.amountMoney));

    List<Widget> preparedAllTransactionsItem = [];

    for (var element in inputTransactionsList) {

      preparedAllTransactionsItem.add(outputItem(element));

    }

    setState(() {

      allTransactionsItems = preparedAllTransactionsItem;

    });

  }

}