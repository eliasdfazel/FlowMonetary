/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

void main() {runApp(MyApp());}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<Choice> choices = <Choice>[
      const Choice(title: 'Home', icon: Icons.home),
      const Choice(title: 'Contact', icon: Icons.contacts),
      const Choice(title: 'Map', icon: Icons.map),
      const Choice(title: 'Phone', icon: Icons.phone),
      const Choice(title: 'Camera', icon: Icons.camera_alt),
      const Choice(title: 'Setting', icon: Icons.settings),
      const Choice(title: 'Album', icon: Icons.photo_album),
      const Choice(title: 'WiFi', icon: Icons.wifi),
      const Choice(title: 'Home', icon: Icons.home),
      const Choice(title: 'Contact', icon: Icons.contacts),
      const Choice(title: 'Map', icon: Icons.map),
      const Choice(title: 'Phone', icon: Icons.phone),
      const Choice(title: 'Camera', icon: Icons.camera_alt),
      const Choice(title: 'Setting', icon: Icons.settings),
      const Choice(title: 'Album', icon: Icons.photo_album),
      const Choice(title: 'WiFi', icon: Icons.wifi),
      const Choice(title: 'Home', icon: Icons.home),
      const Choice(title: 'Contact', icon: Icons.contacts),
      const Choice(title: 'Map', icon: Icons.map),
      const Choice(title: 'Phone', icon: Icons.phone),
      const Choice(title: 'Camera', icon: Icons.camera_alt),
      const Choice(title: 'Setting', icon: Icons.settings),
      const Choice(title: 'Album', icon: Icons.photo_album),
      const Choice(title: 'WiFi', icon: Icons.wifi),
      const Choice(title: 'Home', icon: Icons.home),
      const Choice(title: 'Contact', icon: Icons.contacts),
      const Choice(title: 'Map', icon: Icons.map),
      const Choice(title: 'Phone', icon: Icons.phone),
      const Choice(title: 'Camera', icon: Icons.camera_alt),
      const Choice(title: 'Setting', icon: Icons.settings),
      const Choice(title: 'Album', icon: Icons.photo_album),
      const Choice(title: 'WiFi', icon: Icons.wifi),
    ];

    return MaterialApp(
        home: Scaffold(appBar: AppBar(
          title: const Text("Flutter GridView Demo"),
        ),
            body: Stack(
              children: [
                GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(choices.length, (index) {
                      return Center(
                        child: SelectCard(choice: choices[index]),
                      );
                    })
                ),
                Blur(
                  blurColor: ColorsResources.primaryColorTransparent,
                  blur: 7.0,
                  borderRadius: BorderRadius.all(Radius.circular(51)),
                  overlay: SizedBox(
                    width: 300,
                    height: 300,
                    child: Text("Blurry View"),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                  ),
                )
              ],
            )
        )
    );
  }

}



class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {

    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    return GestureDetector(
      onTap: () {

        print(">>> " + choice.title);

      },
      child: Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Icon(choice.icon, size:50.0, color: textStyle!.color)),
              Text(choice.title, style: textStyle),
            ]
        ),),
      ),
    );
  }
}