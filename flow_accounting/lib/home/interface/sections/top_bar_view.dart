/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/13/22, 5:55 AM
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

  ProfilesData profilesData = ProfilesData(
      id: 0,
      userId: '',
      userSignedIn: ProfilesData.Profile_Not_Singed_In,
      userFullName: '',
      userImage: '',
      userEmailAddress: '',
      userInstagram: '',
      userPhoneNumber: '',
      userLocationAddress: ''
  );

  List<Widget> allAccountsViews = [];

  @override
  void initState() {

    getSignedInProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (profilesData.id != 0) {



    }

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

                        if (profilesData.id != 0) {

                          NavigationProcess().goTo(context,
                              ProfilesInputView(profilesData: profilesData));

                        } else {

                          NavigationProcess().goTo(context,
                              ProfilesInputView());
                          
                        }

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
      title: const Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            StringsResources.selectProfileText,
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
  }

  void getSignedInProfile() async {

    try {

      ProfileDatabaseQueries profileDatabaseQueries = ProfileDatabaseQueries();

      profilesData = await profileDatabaseQueries.querySignedInUser(ProfilesDatabaseInputs.databaseTableName);

      UserInformation.UserId = profilesData.userId;

      setState(() {

        profilesData;

      });

      debugPrint("Signed In User: ${profilesData}");

    } on Exception {

      debugPrint("Sign In Process Error}");

    }

  }

  void retrieveAllProfileAccounts() async{

    ProfileDatabaseQueries profileDatabaseQueries = ProfileDatabaseQueries();

    List<ProfilesData> allAccountsProfiles = await profileDatabaseQueries.getAllProfileAccounts();

    for(var element in allAccountsProfiles) {

      allAccountsViews.add(profilesItemView(element));

    }

    setState(() {

      allAccountsViews;

    });

  }

  Widget profilesItemView(ProfilesData profilesData) {

    return SizedBox(
      height: 53,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                ColorsResources.white,
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
              ),
            ),
            Expanded(
              flex: 3,
              child: AspectRatio(
                aspectRatio: 1,
                child:  Padding(
                  padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(51),
                    child: Image.file(
                      File(profilesData.userImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}