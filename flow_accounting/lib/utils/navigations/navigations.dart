 /*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flutter/material.dart';

class NavigationProcess {

   void goTo(BuildContext context, StatefulWidget statefulWidget) async {

     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) => statefulWidget),
     );

   }

 }