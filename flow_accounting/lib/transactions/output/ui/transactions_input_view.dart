/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:44 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */
/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/13/22, 6:51 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:blur/blur.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: TransactionsInputView()));

}

class TransactionsInputView extends StatefulWidget {
  const TransactionsInputView({Key? key}) : super(key: key);

  @override
  _TransactionsInputViewState createState() => _TransactionsInputViewState();
}
class _TransactionsInputViewState extends State<TransactionsInputView> {

  TextEditingController textEditorControllerName = TextEditingController();
  TextEditingController textEditorControllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // textEditorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea (child: MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(fontFamily: 'Sans'),
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
                ListView(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                        child:  Text(
                          StringsResources.featureTransactionsTitle,
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
                        padding: const EdgeInsets.fromLTRB(13, 7, 13, 19),
                        child: Text(
                          StringsResources.featureTransactionsDescription,
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
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: textEditorControllerName,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    maxLines: 1,
                                    cursorColor: ColorsResources.primaryColor,
                                    autocorrect: true,
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                      alignLabelWithHint: true,
                                      focusColor: ColorsResources.blueGreen,
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
                                      filled: true,
                                      fillColor: ColorsResources.lightTransparent,
                                      labelText: StringsResources.searchText,
                                      labelStyle: TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 17.0
                                      ),
                                      hintText: StringsResources.searchFeaturesText,
                                      hintStyle: TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 17.0
                                      ),
                                    ),
                                  ),
                                )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    controller: textEditorControllerEmail,
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    textAlignVertical: TextAlignVertical.bottom,
                                    maxLines: 1,
                                    cursorColor: ColorsResources.primaryColor,
                                    autocorrect: true,
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                      alignLabelWithHint: true,
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
                                      filled: true,
                                      fillColor: ColorsResources.lightTransparent,
                                      labelText: StringsResources.searchText,
                                      labelStyle: TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 17.0
                                      ),
                                      hintText: StringsResources.searchFeaturesText,
                                      hintStyle: TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 17.0
                                      ),
                                    ),
                                  ),
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerName,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
                                        focusColor: ColorsResources.blueGreen,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: textEditorControllerEmail,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      decoration: const InputDecoration(
                                        alignLabelWithHint: true,
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
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.searchText,
                                        labelStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.searchFeaturesText,
                                        hintStyle: TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
                Positioned(
                  bottom: 19,
                  left: 71,
                  right: 71,
                  child: InkWell(
                    onTap: () {

                      var databaseInputs = DatabaseInputs();


                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(51),
                            topRight: Radius.circular(51),
                            bottomLeft: Radius.circular(51),
                            bottomRight: Radius.circular(51)
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
                          const SizedBox(
                            width: double.infinity,
                            height: 53,
                            child: Align(
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                StringsResources.submitText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 19,
                                    color: ColorsResources.applicationDarkGeeksEmpire
                                ),
                              ),
                            )
                          )
                        ],
                      )
                    ),
                  ),
                )
              ],
            ),
          ),),
      ),
    ));
  }

}
