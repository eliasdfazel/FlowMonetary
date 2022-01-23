import 'package:blur/blur.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp( home: TransactionsOutputView()));
}

class TransactionsOutputView extends StatefulWidget {
  const TransactionsOutputView({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<TransactionsOutputView> {

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
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17)
                  ),
                  gradient: LinearGradient(
                      colors: [
                        ColorsResources.grayLight.withOpacity(0.5),
                        ColorsResources.greenGrayLight.withOpacity(0.5),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      transform: GradientRotation(45),
                      tileMode: TileMode.clamp
                  ),
                ),
                child: Text(
                  StringsResources.submitText,
                ).frosted(
                  blur: 7.0,
                  borderRadius: BorderRadius.circular(17),
                  padding: EdgeInsets.fromLTRB(11, 5, 11, 5),
                ),
              )
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
    //
    // setState(() {
    //   nameQuery;
    //   typeQuery;
    // });

  }
}