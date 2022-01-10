import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'interface/home_interface.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: FlowDashboard()));

}

class FlowDashboard extends StatefulWidget {
  const FlowDashboard({Key? key}) : super(key: key);

  @override
  State<FlowDashboard> createState() => _FlowDashboard();

}

class _FlowDashboard extends State<FlowDashboard> {

  @override
  Widget build(BuildContext context) {

    return const HomePage(applicationName: 'Flow Accounting');
  }

}