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

class GeneralDataView extends StatelessWidget {
  const GeneralDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
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
                      flex: 3,
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
                      flex: 5,
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
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(
                          color: Colors.redAccent,
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