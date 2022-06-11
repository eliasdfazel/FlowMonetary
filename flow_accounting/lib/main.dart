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
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/products/input/ui/products_input_view.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:flow_accounting/transactions/input/ui/remote_transactions_input_view.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:local_auth/local_auth.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:share_plus/share_plus.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:url_launcher/url_launcher.dart';

import 'resources/ColorsResources.dart';
import 'resources/StringsResources.dart';

void main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await StatusBarControl.setColor(ColorsResources.black, animated: true);
  await StatusBarControl.setNavigationBarColor(ColorsResources.black, animated: true);

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

  final QuickActions quickActions = const QuickActions();

  Widget contentView = Container(color: ColorsResources.primaryColor);

  LocalAuthentication localAuthentication = LocalAuthentication();

  String signedInUser = "";

  bool securityCheckpoint = false;

  @override
  void initState() {
    super.initState();

    contentView = getStartedView();

    quickActions.initialize((shortcutType) {

      if (shortcutType == 'action_main') {
        debugPrint("Opening Flow Dashboard");

      } else if (shortcutType == QuickActionsType.BarcodeScanner_Action) {
        debugPrint("Barcode Scanner");

        invokeBarcodeScanner();

      }
      else if(shortcutType == QuickActionsType.SubmitTrans_Action) {
        debugPrint("Submit Transaction");

        NavigationProcess().goTo(context, RemoteTransactionsInputView());

      } else if (shortcutType == QuickActionsType.SocialMedia_Action) {
        debugPrint("Social Media");

        invokeSocialMedia();

      } else if (shortcutType == QuickActionsType.ShareIt_Action) {
        debugPrint("Share It");

        invokeSharingProcess();

      } else {
        debugPrint("Opening Flow Dashboard");

        getSignedInUserId();

      }

    });

    getSignedInUserId();

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(type: QuickActionsType.BarcodeScanner_Action, localizedTitle: 'بارکد خوان', icon: 'qr_scan_icon'),
      const ShortcutItem(type: QuickActionsType.SubmitTrans_Action, localizedTitle: 'ثبت تراکنش', icon: 'transactions_icon'),
      const ShortcutItem(type: QuickActionsType.SocialMedia_Action, localizedTitle: 'اینستاگرام', icon: 'instagram_icon'),
      const ShortcutItem(type: QuickActionsType.ShareIt_Action, localizedTitle: 'به اشتراک بگذارید', icon: 'share_icon')
    ]);

    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(
            resumeCallBack: () async => (() {
              debugPrint("Dashboard Resumed");

              authenticationCheckpoint();

            }),
            pauseCallBack: ()  async => (() {
              debugPrint("Dashboard Paused");



            })
        )
    );

    if (!kDebugMode) {

      Future.delayed(Duration(seconds: 73), () {
        debugPrint("Authentication Reset");

        WelcomePage.Authenticated = false;

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 199), () async {

      if (signedInUser.isNotEmpty) {

        if (WelcomePage.Authenticated) {
          debugPrint("Authenticated Successfully");

        } else {
          debugPrint("Authentication Failed");

          Phoenix.rebirth(context);

        }

      }

    });

    return contentView;
  }

  Widget getStartedView() {

    Future.delayed(Duration(microseconds: 135), () {

      FlutterNativeSplash.remove();

    });

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

      if (securityCheckpoint) {

        WelcomePage.Authenticated = await localAuthentication.authenticate(
            localizedReason: StringsResources.securityNotice(),
            options: const AuthenticationOptions(
              useErrorDialogs: false,
              stickyAuth: false,
            ),
            // authMessages: [
            //   AndroidAuthMessages: AndroidAuthMessages(
            //       cancelButton: StringsResources.cancelText(),
            //       goToSettingsButton: StringsResources.settingText(),
            //       goToSettingsDescription: StringsResources.securityWarning()
            //   ),
            //   IOSAuthMessages: IOSAuthMessages(
            //       cancelButton: StringsResources.cancelText(),
            //       goToSettingsButton: StringsResources.settingText(),
            //       goToSettingsDescription: StringsResources.securityWarning()
            //   )
            // ]
        );
        debugPrint("Authentication Process Started");

      } else {

        WelcomePage.Authenticated = true;


      }

    } on Exception {

      signedInUser = StringsResources.unknownText();

      debugPrint("Sign In Process Error: ${signedInUser}");

    }

    setState(() {

      signedInUser;

      if (WelcomePage.Authenticated) {

        contentView = FlowDashboard();

      }

    });

  }

  void invokeBarcodeScanner() async {

    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#0095ff",
        StringsResources.cancelText(),
        true,
        ScanMode.QR
    );

    if (barcodeScanResult.contains("Product_")) {

      String productId = barcodeScanResult.replaceAll("Product_", "");

      //Get Specific Product Data then Pass It to Edit
      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      ProductsData scannedProductData = await productsDatabaseQueries.querySpecificProductById(productId, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

      Future.delayed(Duration(milliseconds: 753), () {

        NavigationProcess().goTo(context, ProductsInputView(productsData: scannedProductData,));

      });

      debugPrint("Product Id Detected ${productId}");
    }

  }

  void invokeSocialMedia() async {

    launchUrl(Uri.parse(StringsResources.instagramLink()));

  }

  void invokeSharingProcess() {

    Share.share(StringsResources.sharingText());

  }

  void authenticationCheckpoint() async {

    if (securityCheckpoint) {

      if (!WelcomePage.Authenticated) {

        WelcomePage.Authenticated = await localAuthentication.authenticate(
          localizedReason: StringsResources.securityNotice(),
          options: const AuthenticationOptions(
            useErrorDialogs: false,
            stickyAuth: false,
          ),
          // authMessages: [
          //   AndroidAuthMessages: AndroidAuthMessages(
          //       cancelButton: StringsResources.cancelText(),
          //       goToSettingsButton: StringsResources.settingText(),
          //       goToSettingsDescription: StringsResources.securityWarning()
          //   ),
          //   IOSAuthMessages: IOSAuthMessages(
          //       cancelButton: StringsResources.cancelText(),
          //       goToSettingsButton: StringsResources.settingText(),
          //       goToSettingsDescription: StringsResources.securityWarning()
          //   )
          // ]
        );
        debugPrint("Authentication Process Started");

        if (WelcomePage.Authenticated) {
          debugPrint("Authenticated Successfully");

        } else {
          debugPrint("Authentication Failed");

          Phoenix.rebirth(context);

        }

      }

    }

  }

}

class QuickActionsType {

  static const  String BarcodeScanner_Action = "barcode_scanner";
  static const  String SubmitTrans_Action = "submit_transactions";
  static const String SocialMedia_Action = "social_media";
  static const String ShareIt_Action = "share_it";

}

class LifecycleEventHandler extends WidgetsBindingObserver {

  final AsyncCallback resumeCallBack;
  final AsyncCallback pauseCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.pauseCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        await pauseCallBack();
        break;
      case AppLifecycleState.detached:

        break;
    }
  }
}