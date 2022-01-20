/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:ui';

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
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

  TextEditingController textEditorControllerQuery = TextEditingController();

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
      padding: const EdgeInsets.fromLTRB(13, 7, 13, 3),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 17,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 7, 1),
                        child: GestureDetector(
                          onTap: () {



                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                  bottomRight: Radius.circular(13)
                              ),
                              color: ColorsResources.primaryColorLightest,
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: textEditorControllerQuery,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                textAlignVertical: TextAlignVertical.bottom,
                                maxLines: 1,
                                cursorColor: ColorsResources.primaryColor,
                                autocorrect: true,
                                autofocus: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueGrey, width: 5.0),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(13),
                                          topRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                          bottomRight: Radius.circular(13)
                                      ),
                                      gapPadding: 5
                                  ),
                                  hintText: StringsResources.searchFeaturesText,
                                  hintStyle: TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 17.0
                                  ),
                                  labelText: StringsResources.searchText,
                                  labelStyle: TextStyle(
                                    color: ColorsResources.dark,
                                    fontSize: 17.0
                                  ),
                                ),
                              ),
                            )
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
                        child: InkWell(
                          splashColor: ColorsResources.primaryColor,
                          onTap: () {

                            String searchQuery = textEditorControllerQuery.text;


                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                  bottomRight: Radius.circular(13)),
                              color: ColorsResources.primaryColorLightest,
                            ),
                            alignment: AlignmentDirectional.center,
                            child: const Icon(Icons.search_sharp, size: 23.0, color:
                            ColorsResources.dark),
                          ),
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