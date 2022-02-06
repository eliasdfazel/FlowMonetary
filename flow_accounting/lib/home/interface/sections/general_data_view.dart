/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flutter/material.dart';

class GeneralDataView extends StatelessWidget {
  const GeneralDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String totalEarning = "1000";

    String totalBalance = "793";

    String totalSpending = "207";

    return Padding(padding: const EdgeInsets.fromLTRB(13, 3, 13, 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {



                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(23),
                                  topRight: Radius.circular(23),
                                  bottomLeft: Radius.circular(23),
                                  bottomRight: Radius.circular(0)),
                              border: const Border(
                                  top: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  left: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  right: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  )
                              ),
                              color: ColorsResources.light.withOpacity(0.3)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(totalEarning,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 17,shadows: [
                                Shadow(
                                    color: ColorsResources.white,
                                    offset: Offset(0, 0),
                                    blurRadius: 11
                                )
                              ]),
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(31),
                                  topRight: Radius.circular(31),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              border: const Border(
                                  top: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  left: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  right: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  )
                              ),
                              color: ColorsResources.light.withOpacity(0.3)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(totalBalance,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 23,shadows: [
                                Shadow(
                                    color: ColorsResources.white,
                                    offset: Offset(0, 0),
                                    blurRadius: 11
                                )
                              ]),
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(23),
                                  topRight: Radius.circular(23),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(23)),
                              border: const Border(
                                  top: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  left: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  ),
                                  right: BorderSide(
                                    color: ColorsResources.light,
                                    width: 1,
                                  )
                              ),
                              color: ColorsResources.light.withOpacity(0.3)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(totalSpending,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 17,shadows: [
                                Shadow(
                                    color: ColorsResources.white,
                                    offset: Offset(0, 0),
                                    blurRadius: 11
                                )
                              ]),
                            ),
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