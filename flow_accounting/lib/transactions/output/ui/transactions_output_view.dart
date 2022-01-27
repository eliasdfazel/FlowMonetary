import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/io/queries.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
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
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget> [
                SliverFixedExtentList(
                  itemExtent: 50.0,
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {

                    return outputItem(index, allTransactions[index]);

                  }, childCount:  allTransactions.length),
                ),
              ],
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

  Widget outputItem(int itemIndex, TransactionsData transactionsData) {

    return Container(
      child: Text(transactionsData.id.toString()),
    );
  }

  void retrieveAllTransactions() async {

    var databaseQueries = DatabaseQueries();

    var databaseContents = await databaseQueries.getAllTransactions(DatabaseInputs.databaseTableName);

    setState(() {

      allTransactions = databaseContents;

    });

    // nameQuery = (await databaseQueries.extractFinancialReport(databaseContents)).sourceCardNumber;
    // typeQuery = (await databaseQueries.extractFinancialReport(databaseContents)).type.toString();


  }
}