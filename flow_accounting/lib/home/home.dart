import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'interface/home_interface.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: FlowDashboard()));

}

class FlowDashboard extends StatelessWidget {

  const FlowDashboard({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return const HomePage(applicationName: 'Flow Accounting');
  }

}