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

    return SafeArea(child: MaterialApp(
      home: Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  const SliverAppBar(
                    pinned: true,
                    expandedHeight: 70.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Demo'),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.teal[100 * (index % 9)],
                          child: Text('Grid Item $index'),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                  SliverFixedExtentList(
                    itemExtent: 50.0,
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.lightBlue[100 * (index % 9)],
                          child: Text('List Item $index'),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                  top: 19,
                  left: 13,
                  child: InkWell(
                    onTap: () {

                      Navigator.pop(context);

                    },
                    child: const Image(
                      image: AssetImage("go_previous_icon.png"),
                      fit: BoxFit.scaleDown,
                      width: 41,
                      height: 41,
                    ),
                  )
              ),
            ],
          )
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


  }
}