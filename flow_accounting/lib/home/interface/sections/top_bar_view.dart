/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/9/22, 7:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';

import 'package:flow_accounting/profile/database/io/inputs.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/input/ui/profile_input_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBarView extends StatefulWidget {
  const TopBarView({Key? key}) : super(key: key);

  @override
  State<TopBarView> createState() => _TopBarViewState();
}
class _TopBarViewState extends State<TopBarView> {

  ProfilesData? profilesData;

  List<ProfilesData> allProfilesData = [];
  List<Widget> allAccountsViews = [];

  Widget profileImageView = Image(
      image: AssetImage("add_profile_icon.png")
  );

  @override
  void initState() {

    getSignedInProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
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

                        Share.share(StringsResources.sharingText());

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

                        await launch(StringsResources.instagramLink());

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
                    flex: 3,
                    child: GestureDetector(
                      onTap: () async {

                        synchronizeWithServer();

                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 43,
                            width: 43,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: ColorsResources.blueGray,
                                    borderRadius: BorderRadius.circular(9)
                                ),
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Image(
                                      image: AssetImage("sync_icon.png"),
                                      color: ColorsResources.lightBlue,
                                    )
                                )
                            )
                        ),
                      ),
                    )
                ),
                Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.transparent,
                    )
                ),
                Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () async {

                        if (profilesData?.id != 0) {

                          bool dataUpdated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilesInputView(profilesData: profilesData))
                          );

                          if (dataUpdated) {

                            getSignedInProfile();

                          }

                        } else {

                          bool dataUpdated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilesInputView())
                          );

                          debugPrint("Profile Database Updated");
                          if (dataUpdated) {

                            getSignedInProfile();

                          }

                        }

                      },
                      onLongPress: () {

                        showDialog(
                          context: context,
                          builder: (BuildContext context) => popupProfileSelector(context),
                        );

                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 43,
                          width: 43,
                          child: profileImageView,
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

    AlertDialog alertDialog = AlertDialog(
      title: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            StringsResources.selectProfileText(),
            style: TextStyle(
                color: ColorsResources.applicationDarkGeeksEmpire
            ),
          )
      ),
      alignment: AlignmentDirectional.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13))
      ),
      scrollable: true,
      elevation: 13,
      backgroundColor: ColorsResources.lightestBlue,
      actions: [
        addProfilesView()
      ],
      content: SizedBox(
        width: 303,
        height: 399,
        child: ListView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          physics: BouncingScrollPhysics(),
          children: allAccountsViews,
        ),
      ),
    );

    return alertDialog;
  }

  void getSignedInProfile() async {

    try {

      ProfileDatabaseQueries profileDatabaseQueries = ProfileDatabaseQueries();

      profilesData = await profileDatabaseQueries.querySignedInUser();

      UserInformation.UserId = profilesData?.userId ?? "Unknown";

      if (profilesData != null) {

        if (profilesData!.userImage.isNotEmpty) {

          profileImageView = ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.file(
              File(profilesData!.userImage),
              fit: BoxFit.cover,
            ),
          );

        }

      }

      setState(() {

        profilesData;
        profileImageView;

      });

      debugPrint("Signed In User: ${profilesData}");

    } on Exception {

      debugPrint("Sign In Process Error}");

    }

    retrieveAllProfileAccounts();

  }

  void retrieveAllProfileAccounts() async {

    try {

      ProfileDatabaseQueries profileDatabaseQueries = ProfileDatabaseQueries();

      allProfilesData = await profileDatabaseQueries.getAllProfileAccounts();

      if (allProfilesData.isNotEmpty) {

        allAccountsViews.clear();

        for(var element in allProfilesData) {

          allAccountsViews.add(profilesItemView(element));

        }

      } else {

        allAccountsViews.clear();

        allAccountsViews.add(noProfilesView());

      }

      setState(() {

        allAccountsViews;

      });

    } on Exception {



    }

  }

  Widget profilesItemView(ProfilesData profilesData) {

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 3, 0, 9),
      child: SizedBox(
        height: 73,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
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
              borderRadius: BorderRadius.circular(13)
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(1.3, 1.3, 1.3, 1.3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13.0),
              child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: ColorsResources.lightestBlue,
                    splashFactory: InkRipple.splashFactory,
                    onTap: () async {

                      ProfilesDatabaseInputs profilesDatabaseInputs = ProfilesDatabaseInputs();

                      for (var element in allProfilesData) {

                        if (element.id != profilesData.id) {

                          element.userSignedIn = ProfilesData.Profile_Not_Singed_In;
                          profilesDatabaseInputs.updateProfileData(element);

                        }

                      }

                      profilesData.userSignedIn = ProfilesData.Profile_Singed_In;
                      await profilesDatabaseInputs.updateProfileData(profilesData);

                      Future.delayed(Duration(milliseconds: 357), () {

                        Navigator.of(context, rootNavigator: true).pop();

                      });

                      Future.delayed(Duration(milliseconds: 379), () {

                        Phoenix.rebirth(context);

                      });

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                ColorsResources.lightestBlue,
                                ColorsResources.light,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              transform: GradientRotation(45),
                              tileMode: TileMode.clamp
                          ),
                          borderRadius: BorderRadius.circular(13)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 13,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        profilesData.userFullName,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: ColorsResources.dark,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(3, 0, 11, 0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(51),
                                      child: Image.file(
                                        File(profilesData.userImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                              )
                          )
                        ],
                      ),
                    ),
                  )
              ),
            )
          )
        ),
      ),
    );
  }

  Widget addProfilesView() {

    return Align(
      alignment: AlignmentDirectional.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 11, 13, 13),
        child: SizedBox(
          height: 79,
          width: 79,
          child: Container(
              decoration: BoxDecoration(
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
                  borderRadius: BorderRadius.circular(13)
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(1.3, 1.3, 1.3, 1.3),
                  child: InkWell(
                    onTap: () async {

                      Future.delayed(Duration(milliseconds: 357), () {

                        Navigator.of(context, rootNavigator: true).pop();

                      });

                      bool dataUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilesInputView())
                      );

                      if (dataUpdated) {

                        getSignedInProfile();

                      }

                    },
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Lottie.asset("assets/sign_up.json"),
                    ),
                  )
              )
          ),
        ),
      ),
    );
  }

  Widget noProfilesView() {

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 3, 0, 9),
      child: SizedBox(
        height: 303,
        width: double.infinity,
        child: Container(
            decoration: BoxDecoration(
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
                borderRadius: BorderRadius.circular(13)
            ),
            child: Padding(
                padding: EdgeInsets.fromLTRB(1.3, 1.3, 1.3, 1.3),
                child: InkWell(
                  onTap: () async {

                    Future.delayed(Duration(milliseconds: 357), () {

                      Navigator.of(context, rootNavigator: true).pop();

                    });

                    bool dataUpdated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilesInputView(profilesData: profilesData))
                    );

                    if (dataUpdated) {

                      getSignedInProfile();

                    }

                  },
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Lottie.asset("assets/sign_up.json"),
                  ),
                )
            )
        ),
      ),
    );
  }

  void synchronizeWithServer() async {

    // Replace Data of Server with Local Database
    // If Date (epoch millis) on Server is Lower than CurrentMillis

  }

}