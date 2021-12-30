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
    ];

    return MaterialApp(
        home: Scaffold(appBar: AppBar(
          title: Text("Flutter GridView Demo"),
        ),
            body: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: SelectCard(choice: choices[index]),
                  );
                }
                )
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

    return Card(
        color: Colors.orange,
        child: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Icon(choice.icon, size:50.0, color: textStyle!.color)),
              Text(choice.title, style: textStyle),
            ]
        ),
        )
    );
  }
}