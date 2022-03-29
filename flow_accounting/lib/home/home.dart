/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/29/22, 9:25 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'interface/dashboard.dart';

class FlowDashboard extends StatefulWidget {
  const FlowDashboard({Key? key}) : super(key: key);

  @override
  State<FlowDashboard> createState() => _FlowDashboard();

}

class _FlowDashboard extends State<FlowDashboard> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return DashboardView();
  }

}