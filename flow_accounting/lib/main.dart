import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'main_interface.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.pinkAccent,
    statusBarColor: Colors.cyanAccent,
  ));

  runApp(const FlowDashboard());
}

class FlowDashboard extends StatelessWidget {
  const FlowDashboard({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flow Accounting',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColorDark: Colors.blue,
        backgroundColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(title: 'Flow Monetary'),
    );
  }

}