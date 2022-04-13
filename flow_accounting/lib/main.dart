/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/9/22, 7:39 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/home/interface/dashboard.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import 'resources/ColorsResources.dart';
import 'resources/StringsResources.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

  Widget contentView = Container(color: ColorsResources.primaryColor);

  LocalAuthentication localAuthentication = LocalAuthentication();

  String signedInUser = "";

  @override
  void initState() {
    super.initState();

    contentView = getStartedView();

    getSignedInUserId();

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 199), () async {

      if (signedInUser.isNotEmpty) {

        if (WelcomePage.Authenticated) {
          debugPrint("Authenticated Successfully");

          setState(() {

            contentView = FlowDashboard();

          });

          Future.delayed(Duration(microseconds: 7357), () {

            FlutterNativeSplash.remove();

          });

        } else {
          debugPrint("Authentication Failed");

          Phoenix.rebirth(context);

        }

      }

    });

    return contentView;
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
            home: Stack(
              children: [
                // Gradient Background
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                    gradient: LinearGradient(
                        colors: [
                          ColorsResources.light,
                          ColorsResources.lightestBlue,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(45),
                        tileMode: TileMode.clamp
                    ),
                  ),
                ),
                // Rounded Borders
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                      border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: 7,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 7,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 7,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                            width: 7,
                          )
                      ),
                      color: Colors.transparent
                  ),
                ),

              ],
            ),
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

      if (kDebugMode) {

        WelcomePage.Authenticated = true;

      } else {

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

      }

    } on Exception {

      signedInUser = StringsResources.unknownText();

      debugPrint("Sign In Process Error: ${signedInUser}");

    }

    setState(() {

      signedInUser;

    });

  }

}