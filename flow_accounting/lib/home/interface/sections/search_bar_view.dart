/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */mport 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/IconsResources.dart';
import 'package:flutter/material.dart';

import 'features_view.dart';

class SearchBarView extends StatefulWidget {

  List<Widget> allFeaturesOptionsWidgets;
  StateFeaturesOptionsView featuresOptionsView;

  SearchBarView({Key? key, required this.allFeaturesOptionsWidgets, required this.featuresOptionsView}) : super(key: key);

  @override
  State<SearchBarView> createState() => _SearchBarView();

}

class _SearchBarView extends State<SearchBarView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 1, 3, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 11,
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(
                          color: Colors.lightGreenAccent,
                          alignment: AlignmentDirectional.center,
                          child: const Icon(IconsResources.share, size: 23.0, color: ColorsResources.dark),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(
                          color: Colors.blueGrey,
                          alignment: AlignmentDirectional.center,
                          child: const Icon(IconsResources.share, size: 23.0, color: ColorsResources.dark),
                        ),
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),);
  }

}