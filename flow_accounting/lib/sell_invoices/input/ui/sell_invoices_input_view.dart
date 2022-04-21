/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/10/22, 4:12 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/io/queries.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/debtors/database/io/inputs.dart';
import 'package:flow_accounting/debtors/database/io/queries.dart';
import 'package:flow_accounting/debtors/database/structures/tables_structure.dart';
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/sell_invoices/database/io/inputs.dart';
import 'package:flow_accounting/sell_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/calendar/ui/calendar_view.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/extensions/BankLogos.dart';
import 'package:flow_accounting/utils/io/FileIO.dart';
import 'package:flow_accounting/utils/print/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SellInvoicesInputView extends StatefulWidget {

  SellInvoicesData? sellInvoicesData;

  SellInvoicesInputView({Key? key, this.sellInvoicesData}) : super(key: key);

  @override
  _SellInvoicesInputViewState createState() => _SellInvoicesInputViewState();
}
class _SellInvoicesInputViewState extends State<SellInvoicesInputView> {

  CalendarView calendarView = CalendarView();

  ColorSelectorView colorSelectorView = ColorSelectorView();

  TextEditingController controllerCompanyName = TextEditingController();

  TextEditingController controllerInvoiceNumber = TextEditingController();
  TextEditingController controllerInvoiceDescription = TextEditingController();

  TextEditingController controllerPreInvoice = TextEditingController();

  TextEditingController controllerProductId = TextEditingController();
  TextEditingController controllerProductName = TextEditingController();
  TextEditingController controllerProductQuantity = TextEditingController();
  TextEditingController controllerProductQuantityType = TextEditingController();

  TextEditingController controllerAllProductId = TextEditingController();
  TextEditingController controllerAllProductName = TextEditingController();
  TextEditingController controllerAllProductQuantity = TextEditingController();
  TextEditingController controllerAllProductQuantityType = TextEditingController();
  TextEditingController controllerAllProductEachPrice = TextEditingController();

  TextEditingController controllerInvoicePrice = TextEditingController();

  TextEditingController controllerProductEachPrice = TextEditingController();
  TextEditingController controllerProductDiscount = TextEditingController();

  TextEditingController controllerDiscount = TextEditingController();

  TextEditingController controllerShippingExpenses = TextEditingController();

  TextEditingController controllerProductTax = TextEditingController();

  TextEditingController controllerPaidTo = TextEditingController();

  TextEditingController controllerSoldTo = TextEditingController();

  List<ProductsData> selectedProductsData = [];

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  String companyLogoUrl = "";

  String companyDigitalSignature = "";

  bool sellInvoicesDataUpdated = false;

  String? warningNoticeCompanyName;

  String? warningNoticeNumber;
  String? warningNoticeDescription;

  String? warningNoticeProductName;
  String? warningNoticeProductQuantity;
  String? warningNoticeProductQuantityType;

  String? warningProductPrice;
  String? warningProductEachPrice;
  String? warningProductDiscount;

  String? warningPaidTo;

  String? warningSoldTo;

  List<Widget> selectedProductItem = [];

  Widget printingView = Container();

  Widget imageLogoPickerWidget = const Opacity(
    opacity: 0.7,
    child: Image(
      image: AssetImage("unknown_user.png"),
      fit: BoxFit.cover,
    ),
  );

  Widget imageSignaturePickerWidget = const Opacity(
    opacity: 0.3,
    child: Image(
      image: AssetImage("signature_icon.png"),
      fit: BoxFit.contain,
    ),
  );

  Widget selectedInvoiceProductsView = Container();

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {

    calendarView.inputDateTime = widget.sellInvoicesData?.sellInvoiceDateText ?? StringsResources.invoicesDate();

    companyLogoUrl = widget.sellInvoicesData?.companyLogoUrl ?? "";

    companyDigitalSignature = widget.sellInvoicesData?.companyDigitalSignature ?? "";

    controllerCompanyName.text = widget.sellInvoicesData?.companyName ?? "";

    controllerInvoiceNumber.text = widget.sellInvoicesData?.sellInvoiceNumber == null ? "" : (widget.sellInvoicesData?.sellInvoiceNumber)!;
    controllerInvoiceDescription.text = widget.sellInvoicesData?.sellInvoiceDescription == null ? "" : (widget.sellInvoicesData?.sellInvoiceDescription)!;

    controllerPreInvoice.text = widget.sellInvoicesData?.sellPreInvoice == null ? SellInvoicesData.SellInvoice_Final : (widget.sellInvoicesData?.sellPreInvoice)!;

    controllerProductName.text = widget.sellInvoicesData?.soldProductName == null ? "" : (widget.sellInvoicesData?.soldProductName)!;
    controllerProductQuantity.text = widget.sellInvoicesData?.soldProductQuantity == null ? "" : (widget.sellInvoicesData?.soldProductQuantity)!;
    controllerProductQuantityType.text = widget.sellInvoicesData?.productQuantityType == null ? "" : (widget.sellInvoicesData?.productQuantityType.toString())!;

    controllerInvoicePrice.text = widget.sellInvoicesData?.soldProductPrice == null ? "" : (widget.sellInvoicesData?.soldProductPrice)!;
    controllerProductEachPrice.text = widget.sellInvoicesData?.soldProductEachPrice == null ? "" : (widget.sellInvoicesData?.soldProductEachPrice)!;
    controllerProductDiscount.text = widget.sellInvoicesData?.soldProductPriceDiscount == null ? "" : (widget.sellInvoicesData?.soldProductPriceDiscount)!;

    controllerShippingExpenses.text = widget.sellInvoicesData?.productShippingExpenses == null ? "" : (widget.sellInvoicesData?.productShippingExpenses)!;

    controllerProductTax.text = widget.sellInvoicesData?.productTax.replaceAll("%", "") == null ? "" : (widget.sellInvoicesData?.productTax)!.replaceAll("%", "");

    controllerPaidTo.text = widget.sellInvoicesData?.paidTo == null ? "" : (widget.sellInvoicesData?.paidTo)!;

    controllerSoldTo.text = widget.sellInvoicesData?.soldTo == null ? "" : (widget.sellInvoicesData?.soldTo)!;

    colorSelectorView.inputColor = Color(widget.sellInvoicesData?.colorTag ?? Colors.white.value);

    prepareAllImagesCheckpoint();

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    if (widget.sellInvoicesData != null) {

      printingView = Expanded(
          flex: 3,
          child: Tooltip(
            triggerMode: TooltipTriggerMode.longPress,
            message: StringsResources.printingHint(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(51),
              gradient: const LinearGradient(
                colors: [
                  ColorsResources.black,
                  ColorsResources.primaryColorDark
                ],
                transform: const GradientRotation(45),
              ),
            ),
            height: 31,
            padding: const EdgeInsets.fromLTRB(13, 3, 13, 3),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 7),
            preferBelow: false,
            textStyle: const TextStyle(
              color: ColorsResources.light,
              fontSize: 13,
            ),
            showDuration: const Duration(seconds: 3),
            waitDuration: const Duration(seconds: 5),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(51.0),
                child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: ColorsResources.applicationGeeksEmpire.withOpacity(0.5),
                    splashFactory: InkRipple.splashFactory,
                    onTap: () async {

                      PrintingProcess().startSellInvoicePrint(widget.sellInvoicesData!);

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
                                width: 53,
                                height: 53,
                                child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                                        child: Image(
                                          image: AssetImage("print_icon.png"),
                                          color: ColorsResources.lightestOrange,
                                        )
                                    )
                                )
                            )
                          ],
                        )
                    ),
                  ),
                ),
              ),
            ),
          )
      );

    }

  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    Navigator.pop(context, sellInvoicesDataUpdated);

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
                          StringsResources.featureSellInvoicesTitle(),
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
                          StringsResources.featureSellInvoicesDescription(),
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
                                      controller: controllerCompanyName,
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
                                        errorText: warningNoticeCompanyName,
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
                                            fontSize: 13.0
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

                                    invokeLogoImagePicker();

                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(51),
                                      child: imageLogoPickerWidget,
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
                                      controller: controllerInvoiceNumber,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
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
                                        errorText: warningNoticeNumber,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.invoiceNumber(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.sellInvoiceNumberHint(),
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
                                      controller: controllerInvoiceDescription,
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
                                        errorText: warningNoticeDescription,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.invoiceDescription(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.sellInvoiceDescriptionHint(),
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
                        height: 91,
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
                                      height: 62,
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
                                  padding: const EdgeInsets.fromLTRB(7, 0, 13, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                          alignment: AlignmentDirectional.topCenter,
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: DropdownButtonFormField(
                                              isDense: true,
                                              elevation: 7,
                                              focusColor: ColorsResources.applicationDarkGeeksEmpire,
                                              dropdownColor: ColorsResources.light,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(
                                                        color: ColorsResources.applicationDarkGeeksEmpire,
                                                        width: 1
                                                    ),
                                                    borderRadius: BorderRadius.circular(13),
                                                  ),
                                                  filled: true,
                                                  fillColor: ColorsResources.lightTransparent,
                                                  focusColor: ColorsResources.dark
                                              ),
                                              value: StringsResources.invoiceFinal(),
                                              items: <String> [
                                                StringsResources.invoiceFinal(),
                                                StringsResources.invoicePre()
                                              ].map<DropdownMenuItem<String>>((String value) {

                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: SizedBox(
                                                    height: 27,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                                      child: Align(
                                                        alignment:
                                                        AlignmentDirectional.center,
                                                        child: Text(
                                                          value,
                                                          style: const TextStyle(
                                                            color: ColorsResources.darkTransparent,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {

                                                if (value.toString() == StringsResources.invoiceFinal()) {

                                                  controllerPreInvoice.text = SellInvoicesData.SellInvoice_Final;

                                                } else if (value.toString() == StringsResources.invoicePre()) {

                                                  controllerPreInvoice.text = SellInvoicesData.SellInvoice_Pre;

                                                }

                                              },
                                            ),
                                          )
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(0, 5, 7, 0),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              StringsResources.invoiceType(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: ColorsResources.applicationGeeksEmpire,
                                                  fontSize: 12
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
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
                        height: 151,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(9, 0, 3, 0),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(23),
                                            bottomLeft: Radius.circular(23),
                                            topRight: Radius.circular(23),
                                            bottomRight: Radius.circular(23)
                                        ),
                                        child: Material(
                                            shadowColor: Colors.transparent,
                                            color: Colors.transparent,
                                            child: InkWell(
                                                splashColor: ColorsResources.blue.withOpacity(0.91),
                                                splashFactory: InkRipple.splashFactory,
                                                onTap: () async {

                                                  bool noError = true;

                                                  if (controllerProductName.text.isEmpty) {

                                                    setState(() {

                                                      warningNoticeProductName = StringsResources.errorText();

                                                    });

                                                    noError = false;

                                                  }

                                                  if (controllerProductQuantity.text.isEmpty) {

                                                    setState(() {

                                                      warningNoticeProductQuantity = StringsResources.errorText();

                                                    });

                                                    noError = false;

                                                  }

                                                  if (controllerProductQuantityType.text.isEmpty) {

                                                    setState(() {

                                                      warningNoticeProductQuantityType = StringsResources.errorText();

                                                    });

                                                    noError = false;

                                                  }

                                                  if (controllerProductEachPrice.text.isEmpty) {

                                                    setState(() {

                                                      warningProductEachPrice = StringsResources.errorText();

                                                    });

                                                    noError = false;

                                                  }

                                                  if (noError) {

                                                    ProductsData productData = ProductsData(
                                                        id: DateTime.now().millisecondsSinceEpoch,

                                                        productImageUrl: "",

                                                        productName: controllerProductName.text,
                                                        productDescription: "",

                                                        productCategory: "",

                                                        productBrand: "",
                                                        productBrandLogoUrl: "",

                                                        productPrice: controllerProductEachPrice.text,
                                                        productProfitPercent: "0%",

                                                        productTax: "0%",

                                                        productQuantity: int.parse(controllerProductQuantity.text),
                                                        productQuantityType: controllerProductQuantityType.text.isEmpty ? "" : controllerProductQuantityType.text,

                                                        colorTag: ColorsResources.white.value
                                                    );

                                                    bool productExist = false;

                                                    var productQueries = ProductsDatabaseQueries();

                                                    String databaseDirectory = await getDatabasesPath();

                                                    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase()}";

                                                    bool productsDatabaseExist = await databaseExists(productDatabasePath);

                                                    if (productsDatabaseExist) {

                                                      try {

                                                        var queriedProduct = await productQueries.querySpecificProductByName(controllerProductName.text, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

                                                        if (queriedProduct != null) {

                                                          productData = queriedProduct;

                                                          productExist = true;

                                                          debugPrint("Invoice | Selected Product Exists");

                                                        } else {

                                                          productExist = false;

                                                        }

                                                      } on Exception {
                                                        debugPrint("Invoice | Selected Product Not Exists");

                                                        productExist = false;

                                                      }

                                                    }

                                                    debugPrint("Product Exist: ${productExist}");
                                                    if (!productExist) {
                                                      debugPrint("Invoice | New Product Added");

                                                      var databaseInputs = ProductsDatabaseInputs();

                                                      databaseInputs.insertProductData(productData, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

                                                    }

                                                    controllerAllProductId.text += productData.id.toString() + ",";
                                                    controllerAllProductName.text += controllerProductName.text + ",";
                                                    controllerAllProductQuantity.text += controllerProductQuantity.text + ",";
                                                    controllerAllProductQuantityType.text += controllerProductQuantityType.text + ",";
                                                    controllerAllProductEachPrice.text += controllerProductEachPrice.text + ",";

                                                    /* Start - Calculate Invoice Price */
                                                    int completePrice = int.parse(controllerProductEachPrice.text.isEmpty ? "0" : controllerProductEachPrice.text.replaceAll(",", "")) * int.parse(controllerProductQuantity.text.isEmpty ? "0" : controllerProductQuantity.text);

                                                    int taxAmount = ((completePrice * int.parse(controllerProductTax.text.isEmpty ? "0" : controllerProductTax.text.replaceAll("%", ""))) / 100).round();

                                                    int discountPrice = ((completePrice * int.parse(controllerProductDiscount.text.isEmpty ? "0" : controllerProductDiscount.text)) / 100).round();

                                                    int finalPrice = (completePrice + taxAmount) - discountPrice;

                                                    int previousInvoicePrice = int.parse(controllerInvoicePrice.text.isEmpty ? "0" : controllerInvoicePrice.text.replaceAll(",", ""));

                                                    controllerInvoicePrice.text = (previousInvoicePrice + finalPrice).toString();
                                                    /* End - Calculate Invoice Price */

                                                    controllerProductName.text = "";
                                                    controllerProductQuantity.text = "";
                                                    controllerProductQuantityType.text = "";
                                                    controllerProductEachPrice.text = "";
                                                    controllerProductTax.text = "";
                                                    controllerProductDiscount.text = "";

                                                    selectedProductsData.add(productData);

                                                    updateSelectedProductsList(selectedProductsData);

                                                  }

                                                },
                                                child: SizedBox(
                                                    width: double.infinity,
                                                    height: 151,
                                                    child: Align(
                                                        alignment: AlignmentDirectional.center,
                                                        child: Icon(
                                                          Icons.playlist_add_rounded,
                                                          size: 31,
                                                          color: ColorsResources.primaryColor,
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            ),
                            Expanded(
                                flex: 19,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 73,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                              flex: 5,
                                              child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                  child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: TypeAheadField<String>(
                                                          suggestionsCallback: (pattern) async {

                                                            return await getQuantityTypes();
                                                          },
                                                          itemBuilder: (context, suggestion) {

                                                            return ListTile(
                                                                title: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                                      child: Directionality(
                                                                        textDirection: TextDirection.rtl,
                                                                        child: Text(
                                                                          suggestion.toString(),
                                                                          style: const TextStyle(
                                                                              color: ColorsResources.darkTransparent,
                                                                              fontSize: 13
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                            );
                                                          },
                                                          onSuggestionSelected: (suggestion) {

                                                            controllerProductQuantityType.text = suggestion.toString();

                                                          },
                                                          errorBuilder: (context, suggestion) {

                                                            return Padding(
                                                                padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                                                child: Text(StringsResources.nothingText())
                                                            );
                                                          },
                                                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                                              elevation: 7,
                                                              color: ColorsResources.light,
                                                              shadowColor: ColorsResources.darkTransparent,
                                                              borderRadius: BorderRadius.circular(17)
                                                          ),
                                                          textFieldConfiguration: TextFieldConfiguration(
                                                            controller: controllerProductQuantityType,
                                                            autofocus: false,
                                                            textAlignVertical: TextAlignVertical.bottom,
                                                            maxLines: 1,
                                                            cursorColor: ColorsResources.primaryColor,
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
                                                              errorText: warningNoticeProductQuantityType,
                                                              filled: true,
                                                              fillColor: ColorsResources.lightTransparent,
                                                              labelText: StringsResources.productQuantityType(),
                                                              labelStyle: const TextStyle(
                                                                  color: ColorsResources.dark,
                                                                  fontSize: 17.0
                                                              ),
                                                              hintText: StringsResources.productQuantityTypeHint(),
                                                              hintStyle: const TextStyle(
                                                                  color: ColorsResources.darkTransparent,
                                                                  fontSize: 13.0
                                                              ),
                                                            ),
                                                          )
                                                      )
                                                  )
                                              )
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextField(
                                                    controller: controllerProductQuantity,
                                                    textAlign: TextAlign.center,
                                                    textDirection: TextDirection.rtl,
                                                    textAlignVertical: TextAlignVertical.bottom,
                                                    maxLines: 1,
                                                    cursorColor: ColorsResources.primaryColor,
                                                    autocorrect: true,
                                                    autofocus: false,
                                                    keyboardType: TextInputType.number,
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
                                                      errorText: warningNoticeProductQuantity,
                                                      filled: true,
                                                      fillColor: ColorsResources.lightTransparent,
                                                      labelText: StringsResources.quantity(),
                                                      labelStyle: const TextStyle(
                                                          color: ColorsResources.dark,
                                                          fontSize: 17.0
                                                      ),
                                                      hintText: StringsResources.buyQuantityHint(),
                                                      hintStyle: const TextStyle(
                                                          color: ColorsResources.darkTransparent,
                                                          fontSize: 13.0
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                          Expanded(
                                            flex: 13,
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TypeAheadField<ProductsData>(
                                                      suggestionsCallback: (pattern) async {

                                                        return await getAllProducts();
                                                      },
                                                      itemBuilder: (context, suggestion) {

                                                        return ListTile(
                                                            title: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              children: [
                                                                Expanded(
                                                                  flex: 11,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                                    child: Directionality(
                                                                      textDirection: TextDirection.rtl,
                                                                      child: Text(
                                                                        suggestion.productName,
                                                                        style: const TextStyle(
                                                                            color: ColorsResources.darkTransparent,
                                                                            fontSize: 15
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    flex: 5,
                                                                    child:  AspectRatio(
                                                                      aspectRatio: 1,
                                                                      child: Container(
                                                                        decoration: const BoxDecoration(
                                                                            shape: BoxShape.circle,
                                                                            color: ColorsResources.light
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(51),
                                                                              child: Image.file(
                                                                                File(suggestion.productImageUrl),
                                                                                fit: BoxFit.cover,
                                                                              )
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                ),
                                                              ],
                                                            )
                                                        );
                                                      },
                                                      onSuggestionSelected: (suggestion) {

                                                        controllerProductId.text = suggestion.id.toString();
                                                        controllerProductName.text = suggestion.productName.toString();
                                                        controllerProductQuantityType.text = suggestion.productQuantityType.toString();
                                                        controllerProductTax.text = suggestion.productTax.toString();

                                                        String percentProfit = suggestion.productProfitPercent.replaceAll("%", "");
                                                        double profitMargin = (int.parse(suggestion.productPrice.replaceAll(",", "")) * int.parse(percentProfit)) / 100;

                                                        double sellingPriceWithProfit = int.parse(suggestion.productPrice.replaceAll(",", "")) + profitMargin;

                                                        String percentTax = suggestion.productTax.replaceAll("%", "");
                                                        double taxMargin = (sellingPriceWithProfit * int.parse(percentTax)) / 100;

                                                        int sellingPrice = (sellingPriceWithProfit + taxMargin).round();

                                                        controllerProductEachPrice.text = sellingPrice.toString();

                                                      },
                                                      errorBuilder: (context, suggestion) {

                                                        return Padding(
                                                            padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                                            child: Text(StringsResources.nothingText())
                                                        );
                                                      },
                                                      suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                                          elevation: 7,
                                                          color: ColorsResources.light,
                                                          shadowColor: ColorsResources.darkTransparent,
                                                          borderRadius: BorderRadius.circular(17)
                                                      ),
                                                      textFieldConfiguration: TextFieldConfiguration(
                                                        controller: controllerProductName,
                                                        autofocus: false,
                                                        maxLines: 1,
                                                        cursorColor: ColorsResources.primaryColor,
                                                        keyboardType: TextInputType.name,
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
                                                          errorText: warningNoticeProductName,
                                                          filled: true,
                                                          fillColor: ColorsResources.lightTransparent,
                                                          labelText: StringsResources.invoiceProduct(),
                                                          labelStyle: const TextStyle(
                                                              color: ColorsResources.dark,
                                                              fontSize: 17.0
                                                          ),
                                                          hintText: StringsResources.buyInvoiceProductHint(),
                                                          hintStyle: const TextStyle(
                                                              color: ColorsResources.darkTransparent,
                                                              fontSize: 13.0
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 3,
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
                                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextField(
                                                    controller: controllerProductDiscount,
                                                    textAlign: TextAlign.center,
                                                    textDirection: TextDirection.rtl,
                                                    textAlignVertical: TextAlignVertical.bottom,
                                                    maxLines: 1,
                                                    cursorColor: ColorsResources.primaryColor,
                                                    autocorrect: true,
                                                    autofocus: false,
                                                    keyboardType: TextInputType.number,
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
                                                      errorText: warningProductDiscount,
                                                      filled: true,
                                                      fillColor: ColorsResources.lightTransparent,
                                                      labelText: StringsResources.invoiceDiscount(),
                                                      labelStyle: const TextStyle(
                                                          color: ColorsResources.dark,
                                                          fontSize: 17.0
                                                      ),
                                                      hintText: StringsResources.buyInvoiceDiscountHint(),
                                                      hintStyle: const TextStyle(
                                                          color: ColorsResources.darkTransparent,
                                                          fontSize: 13.0
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextField(
                                                    controller: controllerProductTax,
                                                    textAlign: TextAlign.center,
                                                    textDirection: TextDirection.ltr,
                                                    textAlignVertical: TextAlignVertical.bottom,
                                                    maxLines: 1,
                                                    cursorColor: ColorsResources.primaryColor,
                                                    autocorrect: true,
                                                    autofocus: false,
                                                    keyboardType: TextInputType.number,
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
                                                      filled: true,
                                                      fillColor: ColorsResources.lightTransparent,
                                                      labelText: StringsResources.productProfitTax(),
                                                      labelStyle: const TextStyle(
                                                          color: ColorsResources.dark,
                                                          fontSize: 17.0
                                                      ),
                                                      hintText: StringsResources.productProfitTaxHint(),
                                                      hintStyle: const TextStyle(
                                                          color: ColorsResources.darkTransparent,
                                                          fontSize: 13.0
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                                padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                                child: Directionality(
                                                  textDirection: TextDirection.rtl,
                                                  child: TextField(
                                                    controller: controllerProductEachPrice,
                                                    textAlign: TextAlign.center,
                                                    textDirection: TextDirection.rtl,
                                                    textAlignVertical: TextAlignVertical.bottom,
                                                    maxLines: 1,
                                                    cursorColor: ColorsResources.primaryColor,
                                                    autocorrect: true,
                                                    autofocus: false,
                                                    keyboardType: TextInputType.number,
                                                    textInputAction: TextInputAction.next,
                                                    inputFormatters: [
                                                      CurrencyTextInputFormatter(decimalDigits: 0, symbol: "")
                                                    ],
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
                                                      errorText: warningProductEachPrice,
                                                      filled: true,
                                                      fillColor: ColorsResources.lightTransparent,
                                                      labelText: StringsResources.invoiceEachPrice(),
                                                      labelStyle: const TextStyle(
                                                          color: ColorsResources.dark,
                                                          fontSize: 17.0
                                                      ),
                                                      hintText: StringsResources.invoiceEachPriceHint(),
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
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 3,
                        color: Colors.transparent,
                      ),
                      selectedInvoiceProductsView,
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
                                      controller: controllerShippingExpenses,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [
                                        CurrencyTextInputFormatter(decimalDigits: 0, symbol: "")
                                      ],
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
                                        errorText: warningProductPrice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.shippingExpenses(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.shippingExpensesHint(),
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
                                      controller: controllerDiscount,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
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
                                        errorText: warningProductDiscount,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.buyFullDiscount(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.buyFullDiscountHint(),
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
                                      controller: controllerInvoicePrice,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [
                                        CurrencyTextInputFormatter(decimalDigits: 0, symbol: "")
                                      ],
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
                                        errorText: warningProductPrice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.invoicePrice(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.invoicePriceHint(),
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
                                    child: TypeAheadField<CreditCardsData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getAllCreditCards();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 11,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                      child: Directionality(
                                                        textDirection: TextDirection.rtl,
                                                        child: Text(
                                                          suggestion.cardNumber,
                                                          style: const TextStyle(
                                                              color: ColorsResources.darkTransparent,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child:  AspectRatio(
                                                        aspectRatio: 1,
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: ColorsResources.light
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(51),
                                                              child: Image.network(
                                                                generateBankLogoUrl(suggestion.bankName),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerPaidTo.text = suggestion.cardNumber;

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText())
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerPaidTo,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
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
                                            errorText: warningPaidTo,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.sellInvoicePaidBy(),
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.sellInvoicePaidByHint(),
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 13.0
                                            ),
                                          ),
                                        )
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
                                    child: TypeAheadField<DebtorsData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getAllDebtors();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 11,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                      child: Directionality(
                                                        textDirection: TextDirection.rtl,
                                                        child: Text(
                                                          "suggestion.creditorName",
                                                          style: const TextStyle(
                                                              color: ColorsResources.darkTransparent,
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 5,
                                                      child:  AspectRatio(
                                                        aspectRatio: 1,
                                                        child: Container(
                                                          decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: ColorsResources.light
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(51),
                                                              child: Image.network(
                                                                generateBankLogoUrl("suggestion.creditorImageUrl"),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          );
                                        },
                                        onSuggestionSelected: (suggestion) {

                                          controllerSoldTo.text = "suggestion.creditorName";

                                        },
                                        errorBuilder: (context, suggestion) {

                                          return Padding(
                                              padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                              child: Text(StringsResources.nothingText())
                                          );
                                        },
                                        suggestionsBoxDecoration: SuggestionsBoxDecoration(
                                            elevation: 7,
                                            color: ColorsResources.light,
                                            shadowColor: ColorsResources.darkTransparent,
                                            borderRadius: BorderRadius.circular(17)
                                        ),
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controllerSoldTo,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
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
                                            errorText: warningSoldTo,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.sellInvoiceSoldTo(),
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.sellInvoiceSoldToHint(),
                                            hintStyle: const TextStyle(
                                                color: ColorsResources.darkTransparent,
                                                fontSize: 13.0
                                            ),
                                          ),
                                        )
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
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      StringsResources.digitalSignatureHint(),
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
                        height: 179,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                child: InkWell(
                                  onTap: () {

                                    invokeSignatureImagePicker();

                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(19),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              ColorsResources.lightestBlue,
                                              ColorsResources.white.withOpacity(0.3)
                                            ],
                                            transform: const GradientRotation(45),
                                          )
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(7),
                                          child: imageSignaturePickerWidget
                                        )
                                      )
                                    )
                                  )
                                )
                              )
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 17,
                        color: Colors.transparent,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 37,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      StringsResources.colorSelectorHint(),
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

                        Navigator.pop(context, sellInvoicesDataUpdated);

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        printingView,
                        Expanded(
                          flex: 1,
                          child: ColoredBox(color: Colors.transparent),
                        ),
                        Expanded(
                          flex: 13,
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

                                  if (controllerCompanyName.text.isEmpty) {

                                    setState(() {

                                      warningNoticeCompanyName = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerInvoiceNumber.text.isEmpty) {

                                    setState(() {

                                      warningNoticeNumber = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerInvoiceDescription.text.isEmpty) {

                                    setState(() {

                                      warningNoticeDescription = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerPaidTo.text.isEmpty) {

                                    setState(() {

                                      warningPaidTo = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerSoldTo.text.isEmpty) {

                                    setState(() {

                                      warningSoldTo = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (noError) {

                                    if (widget.sellInvoicesData != null) {

                                      if ((widget.sellInvoicesData?.id)! != 0) {

                                        timeNow = (widget.sellInvoicesData?.id)!;

                                      }

                                    }

                                    var databaseInputs = SellInvoicesDatabaseInputs();

                                    SellInvoicesData sellInvoicesData = SellInvoicesData(
                                        id: timeNow,

                                        companyName: controllerCompanyName.text.isEmpty ? UserInformation.UserId : controllerCompanyName.text,
                                        companyLogoUrl: companyLogoUrl,

                                        sellInvoiceNumber: controllerInvoiceNumber.text,

                                        sellInvoiceDescription: controllerInvoiceDescription.text,

                                        sellInvoiceDateText: calendarView.inputDateTime ?? "",
                                        sellInvoiceDateMillisecond: calendarView.pickedDateTime.millisecondsSinceEpoch,

                                        soldProductId: controllerAllProductId.text, // CSV
                                        soldProductName: controllerAllProductName.text, // CSV
                                        soldProductQuantity: controllerAllProductQuantity.text.isEmpty ? "0" : controllerAllProductQuantity.text, // CSV
                                        productQuantityType: controllerAllProductQuantityType.text.isEmpty ? "" : controllerAllProductQuantityType.text, // CSV
                                        soldProductEachPrice: controllerAllProductEachPrice.text.isEmpty ? "0" : controllerAllProductEachPrice.text, // CSV

                                        soldProductPrice: controllerInvoicePrice.text.isEmpty ? "0" : controllerInvoicePrice.text,
                                        soldProductPriceDiscount: controllerProductDiscount.text.isEmpty ? "0" : controllerProductDiscount.text,

                                        invoiceDiscount: controllerDiscount.text.isEmpty ? "0%" : controllerDiscount.text,

                                        productShippingExpenses: controllerShippingExpenses.text.isEmpty ? "0" : controllerShippingExpenses.text,

                                        productTax: controllerProductTax.text.isEmpty ? "0%" : "${controllerProductTax.text}%",

                                        paidTo: controllerPaidTo.text,

                                        soldTo: controllerSoldTo.text,

                                        sellPreInvoice: controllerPreInvoice.text,

                                        companyDigitalSignature: companyDigitalSignature,

                                        invoiceReturned: "",

                                        colorTag: colorSelectorView.selectedColor.value
                                    );

                                    if (widget.sellInvoicesData != null) {

                                      if ((widget.sellInvoicesData?.id)! != 0) {

                                        partialReturnProcess();

                                        databaseInputs.updateInvoiceData(sellInvoicesData, SellInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

                                      }

                                    } else {

                                      databaseInputs.insertSellInvoiceData(sellInvoicesData, SellInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

                                      updateProductQuantity();

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

                                    sellInvoicesDataUpdated = true;

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
                                                    child: ColoredBox(color: Colors.transparent)
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
                                                    child: ColoredBox(color: Colors.transparent)
                                                ),
                                              ],
                                            )
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<ProductsData>> getAllProducts() async {

    List<ProductsData> allProducts = [];

    String databaseDirectory = await getDatabasesPath();

    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase()}";

    bool productsDatabaseExist = await databaseExists(productDatabasePath);

    if (productsDatabaseExist) {

      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      allProducts = await productsDatabaseQueries.getAllProducts(ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

    }

    return allProducts;
  }

  void updateSelectedProductsList(List<ProductsData> inputSelectedProduct) async {

    selectedProductItem.clear();

    for(var aProduct in inputSelectedProduct) {
      debugPrint("Product Added To Invoice -> ${aProduct.productName}");

      selectedProductItem.add(selectedProductView(aProduct));

    }

    selectedInvoiceProductsView = SelectedInvoiceProductsView(selectedInputProductsItem: selectedProductItem);

    setState(() {
      debugPrint("Invoices Products Updated");

      selectedInvoiceProductsView;

    });

  }

  void prepareSelectedProducts() async {

    List<Widget> allProductsItem = [];

    if (widget.sellInvoicesData != null) {

      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      controllerAllProductId.text = widget.sellInvoicesData!.soldProductId;
      var allIds = widget.sellInvoicesData!.soldProductId.split(",");

      controllerAllProductName.text = widget.sellInvoicesData!.soldProductName;
      var allNames = widget.sellInvoicesData!.soldProductName.split(",");

      controllerAllProductQuantity.text = widget.sellInvoicesData!.soldProductQuantity;
      var allQuantities = widget.sellInvoicesData!.soldProductQuantity.split(",");


      controllerAllProductQuantityType.text = widget.sellInvoicesData!.productQuantityType;
      var allQuantitiesTypes = widget.sellInvoicesData!.productQuantityType.split(",");

      controllerAllProductEachPrice.text = widget.sellInvoicesData!.soldProductEachPrice;
      var allEachPrice = widget.sellInvoicesData!.soldProductEachPrice.split(",");

      var index = 0;

      allIds.forEach((element) async {

        var aProduct = await productsDatabaseQueries.querySpecificProductById(element, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

        allProductsItem.add(selectedProductView(ProductsData(
            id: int.parse(element),

            productImageUrl: aProduct.productImageUrl,

            productName: allNames[index],
            productDescription: aProduct.productDescription,

            productCategory: aProduct.productCategory,

            productBrand: aProduct.productBrand,
            productBrandLogoUrl: aProduct.productBrandLogoUrl,

            productPrice: allEachPrice[index],
            productProfitPercent: aProduct.productProfitPercent,

            productTax: aProduct.productTax,

            productQuantity: int.parse(allQuantities[index]),
            productQuantityType: allQuantitiesTypes[index],

            colorTag: aProduct.colorTag
        )));

        index++;

      });

      selectedInvoiceProductsView = SelectedInvoiceProductsView(selectedInputProductsItem: allProductsItem);

      setState(() {
        debugPrint("Invoices Products Retrieved");

        selectedInvoiceProductsView;

      });

    }

  }

  Widget selectedProductView(ProductsData productsData) {

    return Container(
        width: 173,
        height: 37,
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(51),
            color: ColorsResources.light
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 2,
                child: InkWell(
                    onTap: () {

                      selectedProductsData.remove(productsData);

                      controllerAllProductId.text.replaceAll((productsData.id.toString() + ","), "");
                      controllerAllProductName.text.replaceAll((productsData.productName + ","), "");
                      controllerAllProductQuantity.text.replaceAll((productsData.productQuantity.toString() + ","), "");
                      controllerAllProductQuantityType.text.replaceAll((productsData.productQuantityType + ","), "");
                      controllerAllProductEachPrice.text.replaceAll((productsData.productPrice + ","), "");

                      /* Start - Calculate Invoice Price */
                      int previousInvoicePrice = int.parse(controllerInvoicePrice.text.replaceAll(",", ""));

                      controllerInvoicePrice.text = (previousInvoicePrice - int.parse(productsData.productPrice.replaceAll(",", "replace"))).toString();
                      /* End - Calculate Invoice Price */

                      updateSelectedProductsList(selectedProductsData);

                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                        child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Icon(
                              Icons.delete_rounded,
                              size: 17,
                              color: ColorsResources.darkTransparent,
                            )
                        )
                    )
                )
            ),
            Expanded(
              flex: 11,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    productsData.productName,
                    style: const TextStyle(
                        color: ColorsResources.darkTransparent,
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child:  AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsResources.light
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 7, 3),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(51),
                          child: Image.file(
                            File(productsData.productImageUrl),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  ),
                )
            ),
          ],
        )
    );
  }

  void updateProductQuantity() async {

    if (selectedProductsData.isNotEmpty) {

      String databaseDirectory = await getDatabasesPath();

      String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase()}";

      bool productsDatabaseExist = await databaseExists(productDatabasePath);

      if (productsDatabaseExist) {

        ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

        for (var aProduct in selectedProductsData) {

          ProductsData currentProductData = await productsDatabaseQueries.querySpecificProductById(aProduct.id.toString(), ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

          currentProductData.productQuantity = currentProductData.productQuantity + aProduct.productQuantity;

          ProductsDatabaseInputs productsDatabaseInputs = ProductsDatabaseInputs();

          productsDatabaseInputs.updateProductData(currentProductData, ProductsDatabaseInputs.productsDatabase(), UserInformation.UserId);

        }

      }

    }

  }

  void partialReturnProcess() async {

    if (widget.sellInvoicesData != null) {

      if (widget.sellInvoicesData!.soldProductId != controllerAllProductId.text) {

        ProductsDatabaseInputs productsDatabaseInputs = ProductsDatabaseInputs();

        ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

        if (widget.sellInvoicesData!.soldProductId.length > controllerAllProductId.text.length) {// New Products Added

          var csvNewProductIds = controllerAllProductId.text.replaceAll(widget.sellInvoicesData!.soldProductId, "");
          var csvNewProductQuantity = controllerAllProductQuantity.text.replaceAll(widget.sellInvoicesData!.soldProductQuantity, "");

          var allIds = csvNewProductIds.split(",");

          var index = 0;

          allIds.forEach((element) async {

            var aProduct = await productsDatabaseQueries.querySpecificProductById(element, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

            aProduct.productQuantity = aProduct.productQuantity - int.parse(csvNewProductQuantity[index]);

            await productsDatabaseInputs.updateProductData(aProduct, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

            index++;

          });

        } else { // Products Removed

          var csvRemovedProductIds = widget.sellInvoicesData!.soldProductId.replaceAll(controllerAllProductId.text, "");
          var csvRemovedProductQuantity = widget.sellInvoicesData!.soldProductQuantity.replaceAll(controllerAllProductQuantity.text, "");

          var allIds = csvRemovedProductIds.split(",");

          var index = 0;

          allIds.forEach((element) async {

            var aProduct = await productsDatabaseQueries.querySpecificProductById(element, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

            aProduct.productQuantity = aProduct.productQuantity + int.parse(csvRemovedProductQuantity[index]);

            await productsDatabaseInputs.updateProductData(aProduct, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

            index++;

          });

        }

      }

    }

  }

  Future<List<CreditCardsData>> getAllCreditCards() async {

    List<CreditCardsData> allCreditCards = [];

    String databaseDirectory = await getDatabasesPath();

    String creditCardDatabasePath = "${databaseDirectory}/${CreditCardsDatabaseInputs.creditCardDatabase()}";

    bool creditCardDatabaseExist = await databaseExists(creditCardDatabasePath);

    if (creditCardDatabaseExist) {

      CreditCardsDatabaseQueries databaseQueries = CreditCardsDatabaseQueries();

      List<CreditCardsData> listOfAllCreditCards = await databaseQueries.getAllCreditCards(CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

      setState(() {

        allCreditCards = listOfAllCreditCards;

      });

    }

    return allCreditCards;
  }

  Future<List<DebtorsData>> getAllDebtors() async {

    List<DebtorsData> allDebtors = [];

    String databaseDirectory = await getDatabasesPath();

    String creditCardDatabasePath = "${databaseDirectory}/${DebtorsDatabaseInputs.debtorsDatabase()}";

    bool creditCardDatabaseExist = await databaseExists(creditCardDatabasePath);

    if (creditCardDatabaseExist) {

      DebtorsDatabaseQueries databaseQueries = DebtorsDatabaseQueries();

      List<DebtorsData> listOfAllDebtors = await databaseQueries.getAllDebtors(DebtorsDatabaseInputs.databaseTableName, UserInformation.UserId);

      setState(() {

        allDebtors = listOfAllDebtors;

      });

    }

    return allDebtors;
  }

  void invokeLogoImagePicker() async {

    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {

      String fileName = "${UserInformation.UserId}_LOGO.PNG";

      companyLogoUrl = await getFilePath(fileName);

      var imageFileByte = await selectedImage.readAsBytes();

      savePickedImageFile(companyLogoUrl, imageFileByte);

      setState(() {

        imageLogoPickerWidget = Image.file(
          File(selectedImage.path),
          fit: BoxFit.cover,
        );

      });

    }

    debugPrint("Picked Image Path: $companyLogoUrl");

  }

  void invokeSignatureImagePicker() async {

    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {

      String fileName = "${UserInformation.UserId}_SIGNATURE.PNG";

      companyDigitalSignature = await getFilePath(fileName);

      var imageFileByte = await selectedImage.readAsBytes();

      savePickedImageFile(companyDigitalSignature, imageFileByte);

      setState(() {

        imageSignaturePickerWidget = Image.file(
          File(selectedImage.path),
          fit: BoxFit.contain,
        );

      });

    }

    debugPrint("Picked Image Path: $companyDigitalSignature");

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

  void prepareAllImagesCheckpoint() async {

    /* Company Logo */
    if (widget.sellInvoicesData != null) {

      imageLogoPickerWidget = Image.file(
        File(widget.sellInvoicesData!.companyLogoUrl),
        fit: BoxFit.cover,
      );

    }

    bool signatureCheckpoint = await fileExist("${UserInformation.UserId}_SIGNATURE.PNG");

    if (signatureCheckpoint) {

      Directory appDocumentsDirectory = await getApplicationSupportDirectory();

      String appDocumentsPath = appDocumentsDirectory.path;

      String filePath = '$appDocumentsPath/${UserInformation.UserId}_SIGNATURE.PNG';

      imageSignaturePickerWidget = Image.file(
        File(filePath),
        fit: BoxFit.contain,
      );

    }

    setState(() {

      imageLogoPickerWidget;

      imageSignaturePickerWidget;

    });

  }

  Future<List<String>> getQuantityTypes() async {

    return StringsResources.quantityTypesList();
  }

}

class SelectedInvoiceProductsView extends StatefulWidget {

  List<Widget> selectedInputProductsItem;

  SelectedInvoiceProductsView({Key? key, required this.selectedInputProductsItem}) : super(key: key);

  @override
  _SelectedInvoiceProductsViewState createState() => _SelectedInvoiceProductsViewState();
}
class _SelectedInvoiceProductsViewState extends State<SelectedInvoiceProductsView> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Selected Products Number -> ${widget.selectedInputProductsItem.length}");

    setState(() {

      widget.selectedInputProductsItem;

    });

    return SizedBox(
        width: double.infinity,
        height: 57,
        child: Container(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
            scrollDirection: Axis.horizontal,
            children: widget.selectedInputProductsItem,
          ),
        )
    );
  }

}