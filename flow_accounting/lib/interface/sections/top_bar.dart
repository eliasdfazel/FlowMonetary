import 'package:flow_accounting/resources/IconsResources.dart';
import 'package:flow_accounting/resources/colors.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {



      },
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Padding(
          padding: EdgeInsets.fromLTRB(3, 1, 3, 0),
          child: Column(
            children: [
              Expanded(child: Icon(IconsResources.share, size:50.0, color: ColorsResources.black))
            ],
          ),
        )
        ,
      ),
    );
  }
}