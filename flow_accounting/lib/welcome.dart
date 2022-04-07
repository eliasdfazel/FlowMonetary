/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 7:16 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/home/home.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import 'resources/ColorsResources.dart';
import 'resources/StringsResources.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      Phoenix(
          child: MaterialApp(home: WelcomePage())
      )
  );

}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static bool Authenticated = false;

  @override
  State<WelcomePage> createState() => _WelcomePageViewState();

}
class _WelcomePageViewState extends State<WelcomePage> {

  LocalAuthentication localAuthentication = LocalAuthentication();

  String signedInUser = "";

  @override
  void initState() {
    super.initState();

    getSignedInUserId();

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 199), () async {

      if (signedInUser.isNotEmpty) {

        if (WelcomePage.Authenticated) {
          debugPrint("Authenticated Successfully");

          NavigationProcess().goTo(context, const FlowDashboard());

        } else {
          debugPrint("Authentication Failed");

          Phoenix.rebirth(context);

        }

      }

    });

    return getStartedView();
  }

  Widget getStartedView() {

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.applicationName(),
            color: ColorsResources.primaryColor,
            theme: ThemeData(fontFamily: 'Sans',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
                backgroundColor: ColorsResources.black,
                body: Padding (
                    padding: const EdgeInsets.fromLTRB(1.1, 3, 1.1, 3),
                    child: Container (
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                          gradient: LinearGradient(
                              colors: [
                                ColorsResources.primaryColor,
                                ColorsResources.primaryColorLight,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              transform: GradientRotation(45),
                              tileMode: TileMode.clamp),
                        ),
                        child: SizedBox (
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 39,
                                  left: 13,
                                  right: 13,
                                  child: Center(
                                    child: Text(
                                      StringsResources.welcomeText(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 23
                                      ),
                                    ),
                                  )
                              ),
                              Positioned(
                                  bottom: 39,
                                  left: 13,
                                  right: 13,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 11,
                                          child: Container(
                                            height: 79,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    ColorsResources.dark,
                                                    ColorsResources.primaryColor,
                                                  ],
                                                  begin: FractionalOffset(0.0, 0.0),
                                                  end: FractionalOffset(1.0, 0.0),
                                                  stops: [0.0, 1.0],
                                                  transform: GradientRotation(45),
                                                  tileMode: TileMode.clamp),
                                            ),
                                            child: Center(
                                                child: MaterialButton(
                                                  onPressed: () {

                                                    Future.delayed(const Duration(milliseconds: 199), () {

                                                      NavigationProcess().goTo(context, const FlowDashboard());

                                                    });

                                                  },
                                                  child: Text(
                                                    StringsResources.getStartedText(),
                                                    style: TextStyle(fontSize: 29,shadows: [
                                                      Shadow(
                                                          color: ColorsResources.light,
                                                          offset: Offset(0, 0),
                                                          blurRadius: 7
                                                      )
                                                    ]),
                                                  ),
                                                  height: 79,
                                                  minWidth: double.infinity,
                                                  color: Colors.white.withOpacity(0.3),
                                                  splashColor: ColorsResources.primaryColor,
                                                  textColor: ColorsResources.light,
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(17),),
                                                  ),
                                                )
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                    )
                )
            )
        )
    );
  }

  void getSignedInUserId() async {

    try {

      ProfileDatabaseQueries profileDatabaseQueries = ProfileDatabaseQueries();

      ProfilesData? profileData = await profileDatabaseQueries.querySignedInUser();

      if (profileData != null) {

        UserInformation.UserId = profileData.userId;

        signedInUser = UserInformation.UserId;

      } else {

        signedInUser = StringsResources.unknownText();

      }

      debugPrint("Signed In User: ${signedInUser}");

      WelcomePage.Authenticated = await localAuthentication.authenticate(
          localizedReason: StringsResources.securityNotice(),
          stickyAuth: false,
          useErrorDialogs: false,
          androidAuthStrings: AndroidAuthMessages(
              cancelButton: StringsResources.cancelText(),
              goToSettingsButton: StringsResources.settingText(),
              goToSettingsDescription: StringsResources.securityWarning()
          ),
          iOSAuthStrings: IOSAuthMessages(
              cancelButton: StringsResources.cancelText(),
              goToSettingsButton: StringsResources.settingText(),
              goToSettingsDescription: StringsResources.securityWarning()
          ));
      debugPrint("Authentication Process Started");

    } on Exception {

      signedInUser = StringsResources.unknownText();

      debugPrint("Sign In Process Error: ${signedInUser}");

    }

    setState(() {

      signedInUser;

    });

  }

}