/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/24/22, 10:17 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flow_accounting/profile/database/io/inputs.dart';
import 'package:flow_accounting/profile/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfilesInputView extends StatefulWidget {

  ProfilesData? profilesData;

  ProfilesInputView({Key? key, this.profilesData}) : super(key: key);

  @override
  _ProfilesInputViewState createState() => _ProfilesInputViewState();
}
class _ProfilesInputViewState extends State<ProfilesInputView> {

  String userId = "";

  TextEditingController controllerFullName = TextEditingController();

  TextEditingController controllerUserEmailAddress = TextEditingController();
  TextEditingController controllerUserInstagram = TextEditingController();
  TextEditingController controllerUserPhoneNumber = TextEditingController();

  TextEditingController controllerUserLocationAddress = TextEditingController();

  Widget imagePickerWidget = const Opacity(
    opacity: 0.7,
    child: Image(
      image: AssetImage("unknown_user.png"),
      fit: BoxFit.cover,
    ),
  );

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  String profileImage = "";

  bool profileDataUpdated = false;

  String? warningNoticeFullName;
  String? warningNoticeEmailAddress;
  String? warningNoticeInstagram;
  String? warningNoticePhoneNumber;

  String? warningNoticeLocationAddress;

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {

    controllerFullName.text = widget.profilesData?.userFullName ?? "";
    profileImage = widget.profilesData?.userImage ?? "";

    controllerUserEmailAddress.text = widget.profilesData?.userEmailAddress ?? "";
    controllerUserInstagram.text = widget.profilesData?.userInstagram ?? "";
    controllerUserPhoneNumber.text = widget.profilesData?.userPhoneNumber ?? "";

    controllerUserLocationAddress.text = widget.profilesData?.userLocationAddress ?? "";

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    Navigator.pop(context, profileDataUpdated);

    return true;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Sans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        }),
      ),
      home: Scaffold(
        backgroundColor: ColorsResources.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
          child: Container (
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
              gradient: LinearGradient(
                  colors: [
                    ColorsResources.white,
                    ColorsResources.primaryColorLighter,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp),
            ),
            child: Stack ( /*** Page Content ***/
              children: [
                const Opacity(
                  opacity: 0.07,
                  child: Image(
                    image: AssetImage("input_background_pattern.png"),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                ListView(
                    padding: const EdgeInsets.fromLTRB(0, 7, 0, 93),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                        child:  Text(
                          StringsResources.profileTitle(),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 23,
                            color: ColorsResources.dark,
                            shadows: [
                              Shadow(
                                blurRadius: 13,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(3, 3),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 19),
                        child: Text(
                          StringsResources.profileDescription(),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorsResources.blueGreen,
                            shadows: [
                              Shadow(
                                blurRadius: 7,
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(1.3, 1.3),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 13,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerFullName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeFullName,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.profileUserFullName(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.profileUserFullNameHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 13, 0),
                                child: InkWell(
                                  onTap: () {

                                    invokeImagePicker();

                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(51),
                                      child: imagePickerWidget,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Stack(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: controllerUserPhoneNumber,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.ltr,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    maxLines: 1,
                                    cursorColor: ColorsResources.primaryColor,
                                    autocorrect: true,
                                    autofocus: false,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(13, 25, 77, 17),
                                      alignLabelWithHint: true,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13),
                                              bottomLeft: Radius.circular(13),
                                              bottomRight: Radius.circular(13)
                                          ),
                                          gapPadding: 5
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13),
                                              bottomLeft: Radius.circular(13),
                                              bottomRight: Radius.circular(13)
                                          ),
                                          gapPadding: 5
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.green, width: 1.0),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13),
                                              bottomLeft: Radius.circular(13),
                                              bottomRight: Radius.circular(13)
                                          ),
                                          gapPadding: 5
                                      ),
                                      errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(13),
                                              topRight: Radius.circular(13),
                                              bottomLeft: Radius.circular(13),
                                              bottomRight: Radius.circular(13)
                                          ),
                                          gapPadding: 5
                                      ),
                                      errorText: warningNoticePhoneNumber,
                                      filled: true,
                                      fillColor: ColorsResources.lightTransparent,
                                      labelText: StringsResources.profileUserPhoneNumber(),
                                      labelStyle: const TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 17.0
                                      ),
                                      hintText: StringsResources.profileUserPhoneNumberHint(),
                                      hintStyle: const TextStyle(
                                          color: ColorsResources.darkTransparent,
                                          fontSize: 17.0
                                      ),
                                    ),
                                  )
                                )
                            ),
                            Positioned(
                              right: 13,
                              top: 0,
                              bottom: 3,
                              child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(17, 17, 17, 17),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(51),
                                        child: CachedNetworkImage(
                                          imageUrl: "https://myhousestore.ir/wp-content/uploads/2022/03/telephone.png",
                                          fit: BoxFit.cover,
                                          imageBuilder: (context, imageProvider) {

                                            return Image(
                                              image: imageProvider,
                                              alignment: AlignmentDirectional.center,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                    ),
                                  )
                              )
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Stack(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerUserEmailAddress,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(13, 25, 77, 17),
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeEmailAddress,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.profileUserEmail(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.profileUserEmailHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    )
                                )
                            ),
                            Positioned(
                                right: 13,
                                top: 0,
                                bottom: 3,
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(17, 17, 17, 17),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(51),
                                          child: CachedNetworkImage(
                                            imageUrl: "https://myhousestore.ir/wp-content/uploads/2022/03/email.png",
                                            fit: BoxFit.cover,
                                            imageBuilder: (context, imageProvider) {

                                              return Image(
                                                image: imageProvider,
                                                alignment: AlignmentDirectional.center,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Stack(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerUserInstagram,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(13, 25, 77, 17),
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.purpleAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeInstagram,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.profileUserInstagram(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.profileUserInstagramHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    )
                                )
                            ),
                            Positioned(
                                right: 13,
                                top: 0,
                                bottom: 3,
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(17, 17, 17, 17),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(51),
                                          child: CachedNetworkImage(
                                            imageUrl: "https://myhousestore.ir/wp-content/uploads/2022/03/instagram.png",
                                            fit: BoxFit.cover,
                                            imageBuilder: (context, imageProvider) {

                                              return Image(
                                                image: imageProvider,
                                                alignment: AlignmentDirectional.center,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                      ),
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 133,
                        child: Stack(
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerUserLocationAddress,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 3,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(13, 19, 77, 17),
                                        alignLabelWithHint: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13),
                                                bottomLeft: Radius.circular(13),
                                                bottomRight: Radius.circular(13)
                                            ),
                                            gapPadding: 5
                                        ),
                                        errorText: warningNoticeLocationAddress,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.profileUserLocationAddress(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.profileUserLocationAddressHint(),
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    )
                                )
                            ),
                            Positioned(
                                right: 31,
                                top: 13,
                                child: SizedBox(
                                  height: 37,
                                  width: 37,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(51),
                                      child: CachedNetworkImage(
                                        imageUrl: "https://myhousestore.ir/wp-content/uploads/2022/03/pin.png",
                                        fit: BoxFit.cover,
                                        imageBuilder: (context, imageProvider) {

                                          return Image(
                                            image: imageProvider,
                                            alignment: AlignmentDirectional.center,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ]
                ),
                Positioned(
                    top: 19,
                    left: 13,
                    child:  InkWell(
                      onTap: () {

                        Navigator.pop(context, profileDataUpdated);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: ColorsResources.blueGrayLight.withOpacity(0.7),
                                  blurRadius: 7,
                                  spreadRadius: 0.1,
                                  offset: const Offset(0.0, 3.7)
                              )
                            ]
                        ),
                        child: const Image(
                          image: AssetImage("go_previous_icon.png"),
                          fit: BoxFit.scaleDown,
                          width: 41,
                          height: 41,
                        ),
                      ),
                    )
                ),
                Positioned(
                    bottom: 19,
                    left: 71,
                    right: 71,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(51.0),
                      child: Material(
                        shadowColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: ColorsResources.applicationGeeksEmpire.withOpacity(0.5),
                          splashFactory: InkRipple.splashFactory,
                          onTap: () {

                            bool noError = true;

                            if (controllerFullName.text.isEmpty) {

                              setState(() {

                                warningNoticeFullName = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (controllerUserPhoneNumber.text.isEmpty) {

                              setState(() {

                                warningNoticePhoneNumber = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (controllerUserInstagram.text.isEmpty) {

                              setState(() {

                                warningNoticeInstagram = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (controllerUserEmailAddress.text.isEmpty) {

                              setState(() {

                                warningNoticeEmailAddress = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (controllerUserLocationAddress.text.isEmpty) {

                              setState(() {

                                warningNoticeLocationAddress = StringsResources.errorText();

                              });

                              noError = false;

                            }

                            if (noError) {

                              if (widget.profilesData != null) {

                                if ((widget.profilesData?.id)! != 0) {

                                  timeNow = (widget.profilesData?.id)!;

                                }

                              }

                              var databaseInputs = ProfilesDatabaseInputs();

                              ProfilesData profilesData = ProfilesData(
                                id: timeNow,

                                userId: widget.profilesData?.userId ?? controllerUserPhoneNumber.text,
                                userSignedIn: ProfilesData.Profile_Not_Singed_In,

                                userFullName: controllerFullName.text,
                                userImage: profileImage,

                                userEmailAddress: controllerUserEmailAddress.text,
                                userInstagram: controllerUserInstagram.text,
                                userPhoneNumber: controllerUserPhoneNumber.text,

                                userLocationAddress: controllerUserLocationAddress.text
                              );

                              if (widget.profilesData != null) {

                                if ((widget.profilesData?.id)! != 0) {

                                  databaseInputs.updateProfileData(profilesData);

                                }

                              } else {

                                databaseInputs.insertProfileData(profilesData);

                              }

                              Fluttertoast.showToast(
                                  msg: StringsResources.updatedText(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorsResources.lightTransparent,
                                  textColor: ColorsResources.dark,
                                  fontSize: 16.0
                              );

                              profileDataUpdated = true;

                            }

                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(51),
                                    topRight: Radius.circular(51),
                                    bottomLeft: Radius.circular(51),
                                    bottomRight: Radius.circular(51)
                                ),
                                border: const Border(
                                    top: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    ),
                                    left: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    ),
                                    right: BorderSide(
                                      color: ColorsResources.primaryColorLight,
                                      width: 1,
                                    )
                                ),
                                gradient: LinearGradient(
                                    colors: [
                                      ColorsResources.primaryColor.withOpacity(0.3),
                                      ColorsResources.primaryColorLight.withOpacity(0.3),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: const [0.0, 1.0],
                                    transform: const GradientRotation(45),
                                    tileMode: TileMode.clamp
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorsResources.dark.withOpacity(0.179),
                                    blurRadius: 13.0,
                                    spreadRadius: 0.3,
                                    offset: const Offset(3.0, 3.0),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Blur(
                                    blur: 3.0,
                                    borderRadius: BorderRadius.circular(51),
                                    alignment: AlignmentDirectional.center,
                                    blurColor: Colors.blue,
                                    colorOpacity: 0.0,
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: 53,
                                    ),
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      height: 53,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Spacer(flex: 1),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Align(
                                              alignment: AlignmentDirectional.center,
                                              child: Image(
                                                image: AssetImage("submit_icon.png"),
                                                height: 37,
                                                width: 37,
                                                color: ColorsResources.light,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Align(
                                                alignment: AlignmentDirectional.center,
                                                child: Text(
                                                  StringsResources.submitText(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      color: ColorsResources.darkTransparent,
                                                      shadows: [
                                                        Shadow(
                                                            color: ColorsResources.primaryColorDark,
                                                            blurRadius: 7.0,
                                                            offset: Offset(1, 1)
                                                        )
                                                      ]
                                                  ),
                                                ),
                                              )
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Spacer(flex: 1),
                                          ),
                                        ],
                                      )
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void invokeImagePicker() async {

    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {

      String fileName = selectedImage.name;

      if (controllerUserPhoneNumber.text.isNotEmpty) {

        fileName = "${controllerUserPhoneNumber.text.replaceAll(" ", "_")}_image.png";

      }

      profileImage = await getFilePath(fileName);

      var imageFileByte = await selectedImage.readAsBytes();

      savePickedImageFile(profileImage, imageFileByte);

      setState(() {

        imagePickerWidget = Image.file(
          File(selectedImage.path),
          fit: BoxFit.cover,
        );

      });

    }

    debugPrint("Picked Image Path: $profileImage");

  }

  Future<String> getFilePath(String fileName) async {

    Directory appDocumentsDirectory = await getApplicationSupportDirectory();

    String appDocumentsPath = appDocumentsDirectory.path;

    String filePath = '$appDocumentsPath/$fileName';

    return filePath;
  }

  void savePickedImageFile(String imageFilePath, Uint8List imageBytes) async {

    File file = File(imageFilePath);

    file.writeAsBytes(imageBytes);

  }

}