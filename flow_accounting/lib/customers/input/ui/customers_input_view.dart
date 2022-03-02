/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/2/22, 5:07 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:flow_accounting/budgets/database/io/inputs.dart';
import 'package:flow_accounting/customers/database/io/inputs.dart';
import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/calendar/ui/calendar_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CustomersInputView extends StatefulWidget {

  CustomersData? customersData = CustomersData(
    id: 0,

    customerName: '',
    customerDescription: '',

    customerCountry: '',
    customerCity: '',
    customerStreetAddress: '',

    customerPhoneNumber: '',
    customerEmailAddress: '',

    customerAge: '',
    customerBirthday: '',

    customerJob: '',

    customerMaritalStatus: '',

    colorTag: ColorsResources.white.value,
  );

  CustomersInputView({Key? key, this.customersData}) : super(key: key);

  @override
  _CustomersInputViewState createState() => _CustomersInputViewState();
}
class _CustomersInputViewState extends State<CustomersInputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  CalendarView calendarView = CalendarView(pickedDataTimeText: StringsResources.customerBirthdayText);

  TextEditingController controllerCustomerName = TextEditingController();
  TextEditingController controllerCustomerDescription = TextEditingController();

  TextEditingController controllerCustomerCountry = TextEditingController();
  TextEditingController controllerCustomerCity = TextEditingController();
  TextEditingController controllerCustomerStreetAddress = TextEditingController();

  TextEditingController controllerCustomerPhoneNumber = TextEditingController();
  TextEditingController controllerCustomerEmailAddress = TextEditingController();

  TextEditingController controllerCustomerAge = TextEditingController();

  TextEditingController controllerCustomerJob = TextEditingController();

  TextEditingController controllerCustomerMaritalStatus = TextEditingController();

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  bool customerDataUpdated = false;

  String? warningNotice;

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState(){

    controllerCustomerName.text = widget.customersData?.customerName == null ? "" : (widget.customersData?.customerName)!;
    controllerCustomerDescription.text = widget.customersData?.customerDescription == null ? "" : (widget.customersData?.customerDescription)!;

    controllerCustomerCountry.text = widget.customersData?.customerCountry == null ? "" : (widget.customersData?.customerCountry)!;
    controllerCustomerCity.text = widget.customersData?.customerCity == null ? "" : (widget.customersData?.customerCity)!;
    controllerCustomerStreetAddress.text = widget.customersData?.customerStreetAddress == null ? "" : (widget.customersData?.customerStreetAddress)!;

    controllerCustomerPhoneNumber.text = widget.customersData?.customerPhoneNumber == null ? "" : (widget.customersData?.customerPhoneNumber)!;
    controllerCustomerEmailAddress.text = widget.customersData?.customerEmailAddress == null ? "" : (widget.customersData?.customerEmailAddress)!;

    controllerCustomerAge.text = widget.customersData?.customerAge == null ? "" : (widget.customersData?.customerAge)!;
    
    controllerCustomerJob.text = widget.customersData?.customerJob == null ? "" : (widget.customersData?.customerJob)!;

    controllerCustomerMaritalStatus.text = widget.customersData?.customerMaritalStatus == null ? "" : (widget.customersData?.customerMaritalStatus)!;

    colorSelectorView.inputColor = Color(widget.customersData?.colorTag ?? Colors.white.value);

    calendarView.inputDateTime = widget.customersData?.customerBirthday ?? "";

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    Navigator.pop(context, customerDataUpdated);

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
                          StringsResources.featureCustomersTitle,
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
                          StringsResources.featureCustomersDescription,
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
                        height: 113,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(51),
                                    child: ColoredBox(
                                      color: colorSelectorView.selectedColor,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        child: InkWell(
                                          onTap: () {

                                            invokeImagePicker();

                                          },
                                          child: const Image(
                                            image: AssetImage("unknown_user.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 17,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 73,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          controller: controllerCustomerName,
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
                                            errorText: warningNotice,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.customerNameText,
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.customerNameTextHint,
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 17.0
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerDescription,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.top,
                                      maxLines: 5,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ColorsResources.applicationDarkGeeksEmpire
                                      ),
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.descriptionText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.descriptionText,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerCity,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerCityText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.customerCityText,
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
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerCountry,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          color: ColorsResources.dark,
                                          fontSize: 17.0
                                      ),
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerCountryText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.customerCountryText,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
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
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 133,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerStreetAddress,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.top,
                                      maxLines: 5,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: ColorsResources.applicationDarkGeeksEmpire
                                      ),
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerStreetAddressText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.customerStreetAddressTextHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
                                            fontSize: 13.0
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                                child: Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(13),
                                          topRight: Radius.circular(13),
                                          bottomLeft: Radius.circular(13),
                                          bottomRight: Radius.circular(13)
                                      ),
                                      border: Border(
                                          top: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          ),
                                          bottom: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          ),
                                          left: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          ),
                                          right: BorderSide(
                                            color: ColorsResources.darkTransparent,
                                            width: 1,
                                          )
                                      ),
                                      color: ColorsResources.lightTransparent,
                                    ),
                                    child: SizedBox(
                                      height: 65,
                                      width: double.infinity,
                                      child: calendarView,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextField(
                                        controller: controllerCustomerAge,
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
                                          errorText: warningNotice,
                                          filled: true,
                                          fillColor: ColorsResources.lightTransparent,
                                          labelText: StringsResources.customerAgeText,
                                          labelStyle: const TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 17.0
                                          ),
                                          hintText: StringsResources.customerAgeText,
                                          hintStyle: const TextStyle(
                                              color: ColorsResources.darkTransparent,
                                              fontSize: 17.0
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerPhoneNumber,
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.phone,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerPhoneNumberText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.customerPhoneNumberTextHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
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
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerEmailAddress,
                                      textAlign: TextAlign.left,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.emailAddress,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerEmailAddressText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.customerEmailAddressTextHint,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
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
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 73,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerMaritalStatus,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerJobText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.customerJobText,
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
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      controller: controllerCustomerJob,
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
                                        errorText: warningNotice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.customerMaritalStatusText,
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.customerMaritalStatusText,
                                        hintStyle: const TextStyle(
                                            color: ColorsResources.darkTransparent,
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
                      const Divider(
                        height: 13,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 37,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      StringsResources.colorSelectorHint,
                                      style: TextStyle(
                                          fontSize: 15
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
                        height: 103,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: colorSelectorView,
                              ),
                            ),
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

                        Navigator.pop(context, customerDataUpdated);

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

                            if (controllerCustomerName.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerDescription.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerCountry.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerCity.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerStreetAddress.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerPhoneNumber.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerEmailAddress.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerAge.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }
                            
                            if (controllerCustomerJob.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (controllerCustomerMaritalStatus.text.isEmpty) {

                              setState(() {

                                warningNotice = StringsResources.errorText;

                              });

                              noError = false;

                            }

                            if (noError) {

                              if (widget.customersData != null) {

                                if ((widget.customersData?.id)! != 0) {

                                  timeNow = (widget.customersData?.id)!;

                                }

                              }

                              var databaseInputs = CustomersDatabaseInputs();

                              CustomersData transactionData = CustomersData(
                                  id: timeNow,

                                  customerName: controllerCustomerName.text,
                                  customerDescription: controllerCustomerDescription.text,

                                  customerCountry: controllerCustomerCountry.text,
                                  customerCity: controllerCustomerCity.text,
                                  customerStreetAddress: controllerCustomerStreetAddress.text,

                                  customerPhoneNumber: controllerCustomerPhoneNumber.text,
                                  customerEmailAddress: controllerCustomerEmailAddress.text,

                                  customerAge: controllerCustomerAge.text,
                                  customerBirthday: calendarView.pickedDataTimeText ?? "",

                                  customerJob: controllerCustomerJob.text,

                                  customerMaritalStatus: controllerCustomerMaritalStatus.text,

                                  colorTag: colorSelectorView.selectedColor.value
                              );

                              if (widget.customersData != null) {

                                if ((widget.customersData?.id)! != 0) {

                                  databaseInputs.updateCustomerData(transactionData, BudgetsDatabaseInputs.databaseTableName);

                                }

                              } else {

                                databaseInputs.insertCustomerData(transactionData, BudgetsDatabaseInputs.databaseTableName);

                              }

                              Fluttertoast.showToast(
                                  msg: StringsResources.updatedText,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorsResources.lightTransparent,
                                  textColor: ColorsResources.dark,
                                  fontSize: 16.0
                              );

                              customerDataUpdated = true;

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

  }

}