/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/12/22, 6:53 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/profile/input/ui/profile_input_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBarView extends StatefulWidget {
  const TopBarView({Key? key}) : super(key: key);

  @override
  State<TopBarView> createState() => _TopBarViewState();
}

class _TopBarViewState extends State<TopBarView> {

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

                        Share.share(StringsResources.sharingText);

                      },
                      child:  const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 43,
                          width: 43,
                          child: Image(image: AssetImage("share_icon.png")),
                        ),
                      ),
                    )
                ),
                Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () async {

                        await launch(StringsResources.instagramLink);

                      },
                      child:  const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 43,
                          width: 43,
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

                        NavigationProcess().goTo(context, ProfilesInputView());

                      },
                      onLongPress: () {

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => popupProfileSelector(context),
                        );

                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 43,
                          width: 43,
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

  Widget popupProfileSelector(BuildContext context) {

    return AlertDialog(
      title: const Text(StringsResources.selectProfileText),
      backgroundColor: ColorsResources.lightestBlue,
      content: SizedBox(
        width: 303,
        height: 399,
        child: ColoredBox(
          color: Colors.lightGreenAccent,
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {

            Navigator.of(context).pop();

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text(
            StringsResources.cancelText,
            style: TextStyle(
              color: ColorsResources.applicationDarkGeeksEmpire,
              fontSize: 13,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

}