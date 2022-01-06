 import 'package:flutter/material.dart';

class NavigationProcess {

   void goTo(BuildContext context, StatefulWidget statefulWidget) async {

     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => statefulWidget),
     );

   }

 }