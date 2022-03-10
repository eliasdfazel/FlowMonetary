/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'interface/dashboard.dart';

class FlowDashboard extends StatefulWidget {
  const FlowDashboard({Key? key}) : super(key: key);

  @override
  State<FlowDashboard> createState() => _FlowDashboard();

}

class _FlowDashboard extends State<FlowDashboard> {

  String signedInUser = UserInformation.UserId;

  @override
  Widget build(BuildContext context) {

    return DashboardView(signedInUser: signedInUser);
  }

  void getSignedInUserId() async {

    setState(() {

      signedInUser;

    });

  }

}