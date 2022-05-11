/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 3:33 AM
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
import 'package:flow_accounting/creditors/database/structures/tables_structure.dart';
import 'package:flow_accounting/invoices/buy_invoices/database/io/inputs.dart';
import 'package:flow_accounting/invoices/buy_invoices/database/structures/tables_structure.dart';
import 'package:flow_accounting/invoices/selected_products/database/io/inputs.dart';
import 'package:flow_accounting/invoices/selected_products/database/io/queries.dart';
import 'package:flow_accounting/invoices/selected_products/database/structures/tables_structure.dart';
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
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
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class BuyInvoicesInputView extends StatefulWidget {

  BuyInvoicesData? buyInvoicesData;

  BuyInvoicesInputView({Key? key, this.buyInvoicesData}) : super(key: key);

  @override
  _BuyInvoicesInputViewState createState() => _BuyInvoicesInputViewState();
}
class _BuyInvoicesInputViewState extends State<BuyInvoicesInputView> {

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

  TextEditingController controllerInvoicePrice = TextEditingController();

  TextEditingController controllerProductEachPrice = TextEditingController();
  TextEditingController controllerProductDiscount = TextEditingController();

  TextEditingController controllerDiscount = TextEditingController();

  TextEditingController controllerShippingExpenses = TextEditingController();

  TextEditingController controllerProductTax = TextEditingController();

  TextEditingController controllerPaidBy = TextEditingController();

  TextEditingController controllerBoughtFrom = TextEditingController();

  List<ProductsData> selectedProductsData = [];

  ScreenshotController barcodeSnapshotController = ScreenshotController();

  Widget barcodeView = Opacity(
      opacity: 0.37,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: ColoredBox(
              color: ColorsResources.lightestBlue.withOpacity(0.73),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                  child: Image(
                    image: AssetImage("qr_code_icon.png"),
                    fit: BoxFit.cover,
                    height: 131,
                    width: 131,
                  )
              )
          )
      )
  );

  int timeNow = DateTime.now().millisecondsSinceEpoch;

  String companyLogoUrl = "";

  String companyDigitalSignature = "";

  bool buyInvoicesDataUpdated = false;

  String? warningNoticeCompanyName;

  String? warningNoticeNumber;
  String? warningNoticeDescription;

  String? warningNoticeProductName;
  String? warningNoticeProductQuantity;
  String? warningNoticeProductQuantityType;

  String? warningProductPrice;
  String? warningProductEachPrice;
  String? warningProductDiscount;

  String? warningPaidBy;

  String? warningBoughtFrom;

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

    if (widget.buyInvoicesData != null) {

      if ((widget.buyInvoicesData?.id)! != 0) {

        timeNow = (widget.buyInvoicesData?.id)!;

      }

    }

    calendarView.inputDateTime = widget.buyInvoicesData?.buyInvoiceDateText ?? StringsResources.invoicesDate();

    companyLogoUrl = widget.buyInvoicesData?.companyLogoUrl ?? "";

    companyDigitalSignature = widget.buyInvoicesData?.companyDigitalSignature ?? "";

    controllerCompanyName.text = widget.buyInvoicesData?.companyName ?? "";

    controllerInvoiceNumber.text = widget.buyInvoicesData?.buyInvoiceNumber == null ? "" : (widget.buyInvoicesData?.buyInvoiceNumber)!;
    controllerInvoiceDescription.text = widget.buyInvoicesData?.buyInvoiceDescription == null ? "" : (widget.buyInvoicesData?.buyInvoiceDescription)!;

    controllerPreInvoice.text = widget.buyInvoicesData?.buyPreInvoice == null ? BuyInvoicesData.BuyInvoice_Final : (widget.buyInvoicesData?.buyPreInvoice)!;

    controllerInvoicePrice.text = widget.buyInvoicesData?.boughtProductPrice == null ? "" : (widget.buyInvoicesData?.boughtProductPrice)!;

    controllerShippingExpenses.text = widget.buyInvoicesData?.productShippingExpenses == null ? "" : (widget.buyInvoicesData?.productShippingExpenses)!;

    controllerProductTax.text = widget.buyInvoicesData?.productTax.replaceAll("%", "") == null ? "" : (widget.buyInvoicesData?.productTax)!.replaceAll("%", "");

    controllerPaidBy.text = widget.buyInvoicesData?.paidBy == null ? "" : (widget.buyInvoicesData?.paidBy)!;

    controllerBoughtFrom.text = widget.buyInvoicesData?.boughtFrom == null ? "" : (widget.buyInvoicesData?.boughtFrom)!;

    colorSelectorView.inputColor = Color(widget.buyInvoicesData?.colorTag ?? Colors.white.value);

    prepareAllImagesCheckpoint();

    prepareSelectedProducts();

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    if (widget.buyInvoicesData != null) {

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

                      PrintingProcess().startBuyInvoicePrint(widget.buyInvoicesData!);

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
                                width: 53,
                                height: 53,
                              ),
                            ),
                            const Align(
                              alignment: AlignmentDirectional.center,
                              child: SizedBox(
                                  width: 53,
                                  height: 53,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
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

    Navigator.pop(context, buyInvoicesDataUpdated);

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
                          StringsResources.featureBuyInvoicesTitle(),
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
                          StringsResources.featureBuyInvoicesDescription(),
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
                      Align(
                          alignment: AlignmentDirectional.center,
                          child: barcodeView
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
                                        hintText: StringsResources.buyInvoiceNumberHint(),
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
                                        hintText: StringsResources.buyInvoiceDescriptionHint(),
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

                                                  controllerPreInvoice.text = BuyInvoicesData.BuyInvoice_Final;

                                                } else if (value.toString() == StringsResources.invoicePre()) {

                                                  controllerPreInvoice.text = BuyInvoicesData.BuyInvoice_Pre;

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

                                            InvoicedProductsDatabaseInputs invoicesProductsDatabaseInputs = InvoicedProductsDatabaseInputs();

                                            invoicesProductsDatabaseInputs.insertInvoicedProductData(
                                                InvoicedProductsData(
                                                    id: DateTime.now().millisecondsSinceEpoch,
                                                    invoiceProductId: productData.id,
                                                    invoiceProductName: productData.productName,
                                                    invoiceProductQuantity: productData.productQuantity,
                                                    invoiceProductQuantityType: productData.productQuantityType,
                                                    invoiceProductPrice: productData.productPrice,
                                                    invoiceProductStatus: InvoicedProductsData.Product_Purchased
                                                ),
                                                InvoicedProductsDatabaseInputs.invoicedProductsDatabase(timeNow),
                                                InvoicedProductsDatabaseInputs.databaseTableName
                                            );

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
                                        child: Container(
                                          color: ColorsResources.lightTransparent,
                                          child: SizedBox(
                                              width: double.infinity,
                                              height: 151,
                                              child: Align(
                                                  alignment: AlignmentDirectional.center,
                                                  child: Image(
                                                    image: AssetImage("submit_icon.png"),
                                                    height: 31,
                                                    width: 31,
                                                    color: ColorsResources.primaryColor,
                                                  )
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
                                      onChanged: (shippingExpenses) {

                                        int completeShipping = int.parse(controllerShippingExpenses.text.isEmpty ? "0" : controllerShippingExpenses.text.replaceAll(",", ""));

                                        int previousInvoicePrice = int.parse(controllerInvoicePrice.text.isEmpty ? "0" : controllerInvoicePrice.text.replaceAll(",", ""));

                                        controllerInvoicePrice.text = (previousInvoicePrice + completeShipping).toString();

                                      },
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
                                      onChanged: (fullDiscount) {

                                        String completeDiscountPercent = controllerDiscount.text.isEmpty ? "0%" : controllerDiscount.text;

                                        int previousInvoicePrice = int.parse(controllerInvoicePrice.text.isEmpty ? "0" : controllerInvoicePrice.text.replaceAll(",", ""));

                                        int completeDiscount = ((previousInvoicePrice * int.parse(completeDiscountPercent.replaceAll("%", ""))) / 100).round();

                                        controllerInvoicePrice.text = (previousInvoicePrice - completeDiscount).toString();

                                      },
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

                                          controllerPaidBy.text = suggestion.cardNumber;

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
                                          controller: controllerPaidBy,
                                          autofocus: false,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
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
                                            errorText: warningPaidBy,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.buyInvoicePaidBy(),
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.buyInvoicePaidByHint(),
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
                                    child: TypeAheadField<CreditorsData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getAllCreditors();
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

                                          controllerBoughtFrom.text = "suggestion.creditorName";

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
                                          controller: controllerBoughtFrom,
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
                                            errorText: warningBoughtFrom,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.buyInvoiceBoughtFrom(),
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.buyInvoiceBoughtFromHint(),
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

                        Navigator.pop(context, buyInvoicesDataUpdated);

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

                                  if (controllerInvoiceDescription.text.isEmpty) {

                                    setState(() {

                                      warningNoticeDescription = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerInvoicePrice.text.isEmpty) {

                                    setState(() {

                                      warningProductPrice = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerPaidBy.text.isEmpty) {

                                    setState(() {

                                      warningPaidBy = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerBoughtFrom.text.isEmpty) {

                                    setState(() {

                                      warningBoughtFrom = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (noError) {

                                    if (widget.buyInvoicesData != null) {

                                      if ((widget.buyInvoicesData?.id)! != 0) {

                                        timeNow = (widget.buyInvoicesData?.id)!;

                                      }

                                    }

                                    var databaseInputs = BuyInvoicesDatabaseInputs();

                                    BuyInvoicesData buyInvoicesData = BuyInvoicesData(
                                        id: timeNow,

                                        companyName: controllerCompanyName.text.isEmpty ? UserInformation.UserId : controllerCompanyName.text,
                                        companyLogoUrl: companyLogoUrl,

                                        buyInvoiceNumber: controllerInvoiceNumber.text.isEmpty ? timeNow.toString() : controllerInvoiceNumber.text,

                                        buyInvoiceDescription: controllerInvoiceDescription.text,

                                        buyInvoiceDateText: calendarView.inputDateTime ?? "",
                                        buyInvoiceDateMillisecond: calendarView.pickedDateTime.millisecondsSinceEpoch,

                                        boughtProductPrice: controllerInvoicePrice.text.isEmpty ? "0" : controllerInvoicePrice.text,
                                        boughtProductPriceDiscount: controllerProductDiscount.text.isEmpty ? "0" : controllerProductDiscount.text,

                                        invoiceDiscount: controllerDiscount.text.isEmpty ? "0%" : controllerDiscount.text,

                                        productShippingExpenses: controllerShippingExpenses.text.isEmpty ? "0" : controllerShippingExpenses.text,

                                        productTax: controllerProductTax.text.isEmpty ? "0%" : "${controllerProductTax.text}%",

                                        paidBy: controllerPaidBy.text,

                                        boughtFrom: controllerBoughtFrom.text,

                                        buyPreInvoice: controllerPreInvoice.text,

                                        companyDigitalSignature: companyDigitalSignature,

                                        colorTag: colorSelectorView.selectedColor.value,

                                        invoiceReturned: ""
                                    );

                                    if (widget.buyInvoicesData != null) {

                                      if ((widget.buyInvoicesData?.id)! != 0) {

                                        databaseInputs.updateInvoiceData(buyInvoicesData, BuyInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

                                      }

                                    } else {

                                      databaseInputs.insertBuyInvoiceData(buyInvoicesData, BuyInvoicesDatabaseInputs.databaseTableName, UserInformation.UserId);

                                      generateBarcode(buyInvoicesData.id);

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

                                    buyInvoicesDataUpdated = true;

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

    if (selectedProductItem.isNotEmpty) {

      selectedInvoiceProductsView = SelectedInvoiceProductsView(selectedInputProductsItem: selectedProductItem);

    }

    setState(() {
      debugPrint("Invoices Products Updated");

      selectedInvoiceProductsView;

    });

  }

  void prepareSelectedProducts() async {

    List<Widget> allProductsItem = [];

    if (widget.buyInvoicesData != null) {

      InvoicedProductsQueries invoicedProductsQueries = InvoicedProductsQueries();

      List<InvoicedProductsData> allInvoicedProducts = await invoicedProductsQueries.getAllInvoicedProducts(InvoicedProductsDatabaseInputs.invoicedProductsDatabase(timeNow), InvoicedProductsDatabaseInputs.databaseTableName);

      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      allInvoicedProducts.forEach((element) async {

        var aProduct = await productsDatabaseQueries.querySpecificProductById(element.invoiceProductId.toString(), ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

        allProductsItem.add(selectedProductView(ProductsData(
            id: element.invoiceProductId,

            productImageUrl: aProduct.productImageUrl,

            productName: aProduct.productName,
            productDescription: aProduct.productDescription,

            productCategory: aProduct.productCategory,

            productBrand: aProduct.productBrand,
            productBrandLogoUrl: aProduct.productBrandLogoUrl,

            productPrice: aProduct.productImageUrl,
            productProfitPercent: aProduct.productProfitPercent,

            productTax: aProduct.productTax,

            productQuantity: aProduct.productQuantity,
            productQuantityType: aProduct.productQuantityType,

            colorTag: aProduct.colorTag
        )));

      });

      if (allProductsItem.isNotEmpty) {

        selectedInvoiceProductsView = SelectedInvoiceProductsView(selectedInputProductsItem: allProductsItem);

      }

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
                onTap: () async {

                  InvoicedProductsQueries invoicedProductsQueries = InvoicedProductsQueries();

                  InvoicedProductsData invoicedProductsData = await invoicedProductsQueries.queryInvoicedProductById(
                      productsData.id.toString(),
                      InvoicedProductsDatabaseInputs.invoicedProductsDatabase(timeNow),
                      InvoicedProductsDatabaseInputs.databaseTableName
                  );

                  invoicedProductsData.invoiceProductStatus = InvoicedProductsData.Product_Returned;

                  InvoicedProductsDatabaseInputs invoicedProductsDatabaseInputs = InvoicedProductsDatabaseInputs();

                  invoicedProductsDatabaseInputs.updateInvoicedData(
                      invoicedProductsData,
                      InvoicedProductsDatabaseInputs.invoicedProductsDatabase(timeNow),
                      InvoicedProductsDatabaseInputs.databaseTableName
                  );

                  /* Start - Calculate Invoice Price */
                  int previousInvoicePrice = int.parse(controllerInvoicePrice.text.replaceAll(",", ""));

                  controllerInvoicePrice.text = (previousInvoicePrice - int.parse(productsData.productPrice.replaceAll(",", "replace"))).toString();
                  /* End - Calculate Invoice Price */

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

  Future<List<CreditorsData>> getAllCreditors() async {

    List<CreditorsData> allCreditors = [];

    return allCreditors;
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

    if (widget.buyInvoicesData != null) {

      /* Start - Company Logo */
      imageLogoPickerWidget = Image.file(
        File(widget.buyInvoicesData!.companyLogoUrl),
        fit: BoxFit.cover,
      );
      /* End - Company Logo */

      /* Start - Barcode Image */
      bool barcodeFileCheckpoint = await fileExist("BuyInvoices_${widget.buyInvoicesData!.id}.PNG");

      Widget barcodeGenerator = Screenshot(
        controller: barcodeSnapshotController,
        child: SfBarcodeGenerator(
          value: "BuyInvoices_${widget.buyInvoicesData!.id.toString()}",
          symbology: QRCode(),
          barColor: ColorsResources.primaryColor,
        ),
      );

      barcodeView = ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: ColoredBox(
              color: ColorsResources.lightestBlue.withOpacity(0.91),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                  child:  SizedBox(
                      height: 131,
                      width: 131,
                      child: InkWell(
                          onTap: () async {

                            if (barcodeFileCheckpoint) {

                              Directory appDocumentsDirectory = await getApplicationSupportDirectory();

                              String appDocumentsPath = appDocumentsDirectory.path;

                              String filePath = '$appDocumentsPath/BuyInvoices_${widget.buyInvoicesData!.id}.PNG';

                              Share.shareFiles([filePath],
                                  text: "${widget.buyInvoicesData!.buyInvoiceDescription}");

                            }

                          },
                          child: barcodeGenerator
                      )
                  )
              )
          )
      );

      Future.delayed(Duration(milliseconds: 333), () {

        if (!barcodeFileCheckpoint) {

          barcodeSnapshotController.capture().then((Uint8List? imageBytes) {
            debugPrint("Barcode Captured");

            if (imageBytes != null) {

              createFileOfBytes("Product_${widget.buyInvoicesData!.id}", "PNG", imageBytes);

            }

          });

        }

      });
      /* End - Barcode Image */

    }

    /* Start - Signature */
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
    /* End - Signature */

    setState(() {

      barcodeView;

      imageLogoPickerWidget;

      imageSignaturePickerWidget;

    });

  }

  Future<List<String>> getQuantityTypes() async {

    return StringsResources.quantityTypesList();
  }

  List<String> removeEmptyElementCsv(List<String> inputList) {

    List<String> cleanCsvList = [];

    inputList.forEach((element) {

      if (element.isNotEmpty) {

        cleanCsvList.add(element);

      }

    });

    return cleanCsvList;
  }

  String cleanUpCsvDatabase(String inputCsvData) {

    List<String> csvData = removeEmptyElementCsv(inputCsvData.split(","));

    String clearCsvDatabase = "";

    csvData.forEach((element) {

      clearCsvDatabase += "${element},";

    });

    return clearCsvDatabase;
  }

  void generateBarcode(int databaseId) async {

    /* Start - Barcode Image */
    bool barcodeFileCheckpoint = await fileExist("BuyInvoices_${databaseId}.PNG");

    Widget barcodeGenerator = Screenshot(
      controller: barcodeSnapshotController,
      child: SfBarcodeGenerator(
        value: "BuyInvoices_${databaseId.toString()}",
        symbology: EAN8(),
        barColor: ColorsResources.primaryColor,
      ),
    );

    barcodeView = ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: ColoredBox(
            color: ColorsResources.lightestBlue.withOpacity(0.91),
            child: Padding(
                padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                child:  SizedBox(
                    height: 131,
                    width: 131,
                    child: InkWell(
                        onTap: () async {

                          if (barcodeFileCheckpoint) {

                            Directory appDocumentsDirectory = await getApplicationSupportDirectory();

                            String appDocumentsPath = appDocumentsDirectory.path;

                            String filePath = '$appDocumentsPath/BuyInvoices_${databaseId}.PNG';

                            Share.shareFiles([filePath],
                                text: "${widget.buyInvoicesData!.buyInvoiceDescription}");

                          }

                        },
                        child: barcodeGenerator
                    )
                )
            )
        )
    );

    Future.delayed(Duration(milliseconds: 333), () {

      if (!barcodeFileCheckpoint) {

        barcodeSnapshotController.capture().then((Uint8List? imageBytes) {
          debugPrint("Barcode Captured");

          if (imageBytes != null) {

            createFileOfBytes("Product_${databaseId}", "PNG", imageBytes);

          }

        });

      }

    });
    /* End - Barcode Image */

    setState(() {

      barcodeView;

    });

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