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

class TopBarView extends StatelessWidget {
  const TopBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: SizedBox(
        width: double.infinity,
        height: 51,
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
                    child:  const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 47,
                        width: 47,
                        child: Image(image: AssetImage("share_icon.png")),
                      ),
                    ),
                  )
              ),
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {



                    },
                    child:  const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 47,
                        width: 47,
                        child: Image(image: AssetImage("instagram_icon.png")),
                      ),
                    ),
                  )
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                    color: Colors.transparent,
                  )
              ),
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {



                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 47,
                        width: 47,
                        child: Image(image: AssetImage("add_profile_icon.png")),
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}