import 'package:flutter/material.dart';

import 'main_interface.dart';

void main() {
  runApp(const FlowDashboard());
}

class FlowDashboard extends StatelessWidget {
  const FlowDashboard({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }

}

