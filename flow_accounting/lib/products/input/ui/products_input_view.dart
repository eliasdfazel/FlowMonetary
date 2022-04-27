/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/4/22, 4:45 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:io';
import 'dart:typed_data';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:blur/blur.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flow_accounting/products/database/io/inputs.dart';
import 'package:flow_accounting/products/database/io/queries.dart';
import 'package:flow_accounting/products/database/structures/tables_structure.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/io/FileIO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProductsInputView extends StatefulWidget {

  ProductsData? productsData;

  ProductsInputView({Key? key, this.productsData}) : super(key: key);

  @override
  _ProductsInputViewState createState() => _ProductsInputViewState();
}
class _ProductsInputViewState extends State<ProductsInputView> {

  List<ProductsData> allProducts = [];

  ColorSelectorView colorSelectorView = ColorSelectorView();

  TextEditingController controllerProductName = TextEditingController();
  TextEditingController controllerProductDescription = TextEditingController();

  TextEditingController controllerProductCategory = TextEditingController();

  TextEditingController controllerProductBrand = TextEditingController();

  TextEditingController controllerProductBuyingPrice = TextEditingController();
  TextEditingController controllerProductProfitPercent = TextEditingController();

  TextEditingController controllerProductTax = TextEditingController();

  TextEditingController controllerProductQuantity = TextEditingController();
  TextEditingController controllerProductQuantityType = TextEditingController();

  String productImageUrl = "";

  String productBrandLogoUrl = "";

  Widget imagePickerProductImage = Opacity(
    opacity: 0.7,
    child: ColoredBox(
      color: ColorsResources.lightestBlue.withOpacity(0.73),
      child: Image(
        image: AssetImage("unknown_products.png"),
        fit: BoxFit.cover,
      )
    )
  );

  Widget imagePickerProductBrand = Opacity(
      opacity: 0.7,
      child: Image(
        image: AssetImage("unknown_products.png"),
        fit: BoxFit.cover,
      )
  );

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

  bool productDataUpdated = false;

  String? warningNoticeName;
  String? warningNoticeDescription;

  String? warningNoticeCategory;

  String? warningNoticeBrand;

  String? warningNoticeBuyingPrice;
  String? warningNoticeProfitPercent;

  @override
  void dispose() {

    BackButtonInterceptor.remove(aInterceptor);

    super.dispose();
  }

  @override
  void initState() {

    getAllProducts();

    prepareAllImagesCheckpoint();

    controllerProductName.text = widget.productsData?.productName == null ? "" : (widget.productsData?.productName)!;
    controllerProductDescription.text = widget.productsData?.productDescription == null ? "" : (widget.productsData?.productDescription)!;

    controllerProductCategory.text = widget.productsData?.productCategory == null ? "" : (widget.productsData?.productCategory)!;

    controllerProductBrand.text = widget.productsData?.productBrand == null ? "" : (widget.productsData?.productBrand)!;

    controllerProductBuyingPrice.text = widget.productsData?.productPrice == null ? "" : (widget.productsData?.productPrice)!;
    controllerProductProfitPercent.text = widget.productsData?.productProfitPercent.replaceAll("%", "") == null ? "" : (widget.productsData?.productProfitPercent)!.replaceAll("%", "");

    controllerProductTax.text = widget.productsData?.productTax.replaceAll("%", "") == null ? "" : (widget.productsData?.productTax)!.replaceAll("%", "");

    controllerProductQuantity.text = widget.productsData?.productQuantity == null ? "" : (widget.productsData?.productQuantity.toString())!;
    controllerProductQuantityType.text = widget.productsData?.productQuantityType == null ? "" : (widget.productsData?.productQuantityType.toString())!;

    colorSelectorView.inputColor = Color(widget.productsData?.colorTag ?? Colors.white.value);

    productImageUrl = widget.productsData?.productImageUrl ?? "";

    productBrandLogoUrl = widget.productsData?.productBrandLogoUrl ?? "";

    super.initState();

    BackButtonInterceptor.add(aInterceptor);

  }

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    Navigator.pop(context, productDataUpdated);

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
                          StringsResources.featureProductsTitle(),
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
                          StringsResources.featureProductsDescription(),
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
                      const Divider(
                        height: 1,
                        color: Colors.transparent,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 313,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(13, 57, 13, 0),
                              child: InkWell(
                                  onTap: () {

                                    invokeImagePickerProductImage();

                                  },
                                  child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(13),
                                        child: imagePickerProductImage,
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Positioned(
                              left: 19,
                              child: barcodeView
                          )
                        ],
                      ),
                      const Divider(
                        height: 17,
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
                                      controller: controllerProductName,
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
                                        errorText: warningNoticeName,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.productName(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.productNameHint(),
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
                                      controller: controllerProductDescription,
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
                                        labelText: StringsResources.productDescription(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 13.0
                                        ),
                                        hintText: StringsResources.productDescriptionHint(),
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
                              flex: 5,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 3, 0),
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
                                                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                    child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Text(
                                                        suggestion.toString(),
                                                        style: const TextStyle(
                                                            color: ColorsResources.darkTransparent,
                                                            fontSize: 15
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
                                      textAlign: TextAlign.right,
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
                                        errorText: warningNoticeName,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.productQuantity(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.productQuantityHint(),
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
                              flex: 9,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(3, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TypeAheadField<ProductsData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getProductsCategories();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                      flex: 11,
                                                      child:  Padding(
                                                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                        child: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Text(
                                                            suggestion.productCategory,
                                                            style: const TextStyle(
                                                                color: ColorsResources.darkTransparent,
                                                                fontSize: 15
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

                                          controllerProductCategory.text = suggestion.productCategory.toString();

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
                                          controller: controllerProductCategory,
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
                                            errorText: warningNoticeCategory,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.productCategory(),
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.productCategoryHint(),
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
                                    child: TextField(
                                      controller: controllerProductBuyingPrice,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
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
                                        errorText: warningNoticeBuyingPrice,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.productBuyingPrice(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.productBuyingPriceHint(),
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
                                      controller: controllerProductProfitPercent,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
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
                                        errorText: warningNoticeProfitPercent,
                                        filled: true,
                                        fillColor: ColorsResources.lightTransparent,
                                        labelText: StringsResources.productProfitPercent(),
                                        labelStyle: const TextStyle(
                                            color: ColorsResources.dark,
                                            fontSize: 17.0
                                        ),
                                        hintText: StringsResources.productProfitPercentHint(),
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
                                      controller: controllerProductTax,
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      textAlignVertical: TextAlignVertical.bottom,
                                      maxLines: 1,
                                      cursorColor: ColorsResources.primaryColor,
                                      autocorrect: true,
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
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
                                        errorText: warningNoticeProfitPercent,
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
                                flex: 3,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(13, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () {

                                        invokeImagePickerProductBrand();

                                      },
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(51),
                                            child: imagePickerProductBrand,
                                          ),
                                        ),
                                      ),
                                    )
                                )
                            ),
                            Expanded(
                              flex: 13,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TypeAheadField<ProductsData>(
                                        suggestionsCallback: (pattern) async {

                                          return await getProductsBrands();
                                        },
                                        itemBuilder: (context, suggestion) {

                                          return ListTile(
                                              title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                      flex: 11,
                                                      child:  Padding(
                                                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                                        child: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Text(
                                                            suggestion.productBrand,
                                                            style: const TextStyle(
                                                                color: ColorsResources.darkTransparent,
                                                                fontSize: 15
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

                                          controllerProductBrand.text = suggestion.productBrand.toString();

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
                                          controller: controllerProductBrand,
                                          autofocus: false,
                                          maxLines: 1,
                                          cursorColor: ColorsResources.primaryColor,
                                          keyboardType: TextInputType.name,
                                          textInputAction: TextInputAction.done,
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
                                            errorText: warningNoticeBrand,
                                            filled: true,
                                            fillColor: ColorsResources.lightTransparent,
                                            labelText: StringsResources.productBrand(),
                                            labelStyle: const TextStyle(
                                                color: ColorsResources.dark,
                                                fontSize: 17.0
                                            ),
                                            hintText: StringsResources.productBrandHint(),
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

                        Navigator.pop(context, productDataUpdated);

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

                                  if (controllerProductName.text.isEmpty) {

                                    setState(() {

                                      warningNoticeName= StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerProductDescription.text.isEmpty) {

                                    setState(() {

                                      warningNoticeDescription = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerProductCategory.text.isEmpty) {

                                    setState(() {

                                      warningNoticeCategory = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerProductBuyingPrice.text.isEmpty) {

                                    setState(() {

                                      warningNoticeBuyingPrice = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerProductProfitPercent.text.isEmpty) {

                                    setState(() {

                                      warningNoticeProfitPercent = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (controllerProductBrand.text.isEmpty) {

                                    setState(() {

                                      warningNoticeBrand = StringsResources.errorText();

                                    });

                                    noError = false;

                                  }

                                  if (noError) {

                                    if (widget.productsData != null) {

                                      if ((widget.productsData?.id)! != 0) {

                                        timeNow = (widget.productsData?.id)!;

                                      }

                                    }

                                    var databaseInputs = ProductsDatabaseInputs();

                                    ProductsData productData = ProductsData(
                                        id: timeNow,

                                        productImageUrl: productImageUrl,

                                        productName: controllerProductName.text,
                                        productDescription: controllerProductDescription.text,

                                        productCategory: controllerProductCategory.text,

                                        productBrand: controllerProductBrand.text,
                                        productBrandLogoUrl: productBrandLogoUrl,

                                        productPrice: controllerProductBuyingPrice.text,
                                        productProfitPercent: "${controllerProductProfitPercent.text}%",

                                        productTax: controllerProductTax.text.isEmpty ? "0%" : "${controllerProductTax.text}%",

                                        productQuantity: int.parse(controllerProductQuantity.text),
                                        productQuantityType: controllerProductQuantityType.text.isEmpty ? "" : controllerProductQuantityType.text,

                                        colorTag: colorSelectorView.selectedColor.value
                                    );

                                    if (widget.productsData != null) {

                                      if ((widget.productsData?.id)! != 0) {

                                        databaseInputs.updateProductData(productData, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

                                      }

                                    } else {

                                      databaseInputs.insertProductData(productData, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

                                      generateBarcode(productData.id);

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

                                    productDataUpdated = true;

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
                        Expanded(
                          flex: 1,
                          child: ColoredBox(color: Colors.transparent),
                        ),
                        Expanded(
                            flex: 3,
                            child: Tooltip(
                              triggerMode: TooltipTriggerMode.longPress,
                              message: StringsResources.quickSaveHint(),
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
                                      onTap: () {

                                        bool noError = true;

                                        if (controllerProductName.text.isEmpty) {

                                          setState(() {

                                            warningNoticeName= StringsResources.errorText();

                                          });

                                          noError = false;

                                        }

                                        if (controllerProductDescription.text.isEmpty) {

                                          setState(() {

                                            warningNoticeDescription = StringsResources.errorText();

                                          });

                                          noError = false;

                                        }

                                        if (controllerProductCategory.text.isEmpty) {

                                          setState(() {

                                            warningNoticeCategory = StringsResources.errorText();

                                          });

                                          noError = false;

                                        }

                                        if (controllerProductBuyingPrice.text.isEmpty) {

                                          setState(() {

                                            warningNoticeBuyingPrice = StringsResources.errorText();

                                          });

                                          noError = false;

                                        }

                                        if (controllerProductProfitPercent.text.isEmpty) {

                                          setState(() {

                                            warningNoticeProfitPercent = StringsResources.errorText();

                                          });

                                          noError = false;

                                        }

                                        if (controllerProductBrand.text.isEmpty) {

                                          setState(() {

                                            warningNoticeBrand = StringsResources.errorText();

                                          });

                                          noError = false;

                                        }

                                        if (noError) {

                                          if (widget.productsData != null) {

                                            if ((widget.productsData?.id)! != 0) {

                                              timeNow = (widget.productsData?.id)!;

                                            }

                                          }

                                          var databaseInputs = ProductsDatabaseInputs();

                                          ProductsData productData = ProductsData(
                                              id: DateTime.now().millisecondsSinceEpoch,

                                              productImageUrl: productImageUrl,

                                              productName: controllerProductName.text,
                                              productDescription: controllerProductDescription.text,

                                              productCategory: controllerProductCategory.text,

                                              productBrand: controllerProductBrand.text,
                                              productBrandLogoUrl: productBrandLogoUrl,

                                              productPrice: controllerProductBuyingPrice.text.isEmpty ? "0" : controllerProductBuyingPrice.text,
                                              productProfitPercent: controllerProductProfitPercent.text.isEmpty ? "0%" : "${controllerProductProfitPercent.text}%",

                                              productTax: controllerProductTax.text.isEmpty ? "0%" : "${controllerProductTax.text}%",

                                              productQuantity: controllerProductQuantity.text.isEmpty ? 0 : int.parse(controllerProductQuantity.text),
                                              productQuantityType: controllerProductQuantityType.text.isEmpty ? "" : controllerProductQuantityType.text,

                                              colorTag: colorSelectorView.selectedColor.value
                                          );

                                          databaseInputs.insertProductData(productData, ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

                                          generateBarcode(productData.id);

                                          Fluttertoast.showToast(
                                              msg: StringsResources.updatedText(),
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: ColorsResources.lightTransparent,
                                              textColor: ColorsResources.dark,
                                              fontSize: 16.0
                                          );

                                          productDataUpdated = true;

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
                                                  width: 53,
                                                  height: 53,
                                                ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional.center,
                                                child: const SizedBox(
                                                    width: 53,
                                                    height: 53,
                                                    child: Align(
                                                        alignment: AlignmentDirectional.center,
                                                        child: Image(
                                                          image: AssetImage("quick_save.png"),
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
                        )
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

  void invokeImagePickerProductImage() async {

    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {

      String fileName = selectedImage.name;

      if (controllerProductName.text.isNotEmpty) {

        fileName = "${controllerProductName.text.replaceAll(" ", "_")}_Image.PNG";

      }

      productImageUrl = await getFilePath(fileName);

      var imageFileByte = await selectedImage.readAsBytes();

      savePickedImageFile(productImageUrl, imageFileByte);

      setState(() {

        imagePickerProductImage = ColoredBox(
          color: ColorsResources.lightestBlue.withOpacity(0.73),
          child: Image.file(
            File(selectedImage.path),
            fit: BoxFit.cover,
          ),
        );

      });

    }

    debugPrint("Picked Image Path: $productImageUrl");

  }

  void invokeImagePickerProductBrand() async {

    final ImagePicker imagePicker = ImagePicker();

    final XFile? selectedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {

      String fileName = selectedImage.name;

      if (controllerProductBrand.text.isNotEmpty) {

        fileName = "${controllerProductBrand.text.replaceAll(" ", "_")}_Logo.PNG";

      }

      productBrandLogoUrl = await getFilePath(fileName);

      var imageFileByte = await selectedImage.readAsBytes();

      savePickedImageFile(productBrandLogoUrl, imageFileByte);

      setState(() {

        imagePickerProductBrand = ColoredBox(
          color: ColorsResources.lightestBlue.withOpacity(0.73),
          child: Image.file(
            File(selectedImage.path),
            fit: BoxFit.cover,
          ),
        );

      });

    }

    debugPrint("Picked Image Path: $productImageUrl");

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

    if (widget.productsData != null) {

      /* Product Image */
      imagePickerProductImage = ColoredBox(
        color: ColorsResources.lightestBlue.withOpacity(0.73),
        child: Image.file(
          File(widget.productsData!.productImageUrl),
          fit: BoxFit.cover,
        ),
      );

      /* Brand Image */
      imagePickerProductBrand = ColoredBox(
        color: ColorsResources.lightestBlue.withOpacity(0.73),
        child: Image.file(
          File(widget.productsData!.productBrandLogoUrl),
          fit: BoxFit.cover,
        ),
      );

      /* Barcode Image */
      bool barcodeFileCheckpoint = await fileExist("Product_${widget.productsData!.id}.PNG");

      Widget barcodeGenerator = Screenshot(
          controller: barcodeSnapshotController,
          child: SfBarcodeGenerator(
            value: "Product_${widget.productsData!.id.toString()}",
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

                            String filePath = '$appDocumentsPath/Product_${widget.productsData!.id}.PNG';

                            Share.shareFiles([filePath],
                                text: "${widget.productsData!.productName}");

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

              createFileOfBytes("Product_${widget.productsData!.id}", "PNG", imageBytes);

            }

          });

        }

        setState(() {

          imagePickerProductImage;

          imagePickerProductBrand;

          barcodeView;

        });

      });

    }

  }

  Future getAllProducts() async {

    String databaseDirectory = await getDatabasesPath();

    String productDatabasePath = "${databaseDirectory}/${ProductsDatabaseInputs.productsDatabase()}";

    bool productsDatabaseExist = await databaseExists(productDatabasePath);

    if (productsDatabaseExist) {

      ProductsDatabaseQueries productsDatabaseQueries = ProductsDatabaseQueries();

      allProducts = await productsDatabaseQueries.getAllProducts(ProductsDatabaseInputs.databaseTableName, UserInformation.UserId);

      setState(() {

        allProducts;

      });

    }

  }

  Future<List<ProductsData>> getProductsCategories() async {

    return allProducts;
  }

  Future<List<ProductsData>> getProductsBrands() async {

    return allProducts;
  }

  Future<List<String>> getQuantityTypes() async {

    return StringsResources.quantityTypesList();
  }

  void generateBarcode(int databaseId) async {

    bool barcodeFileCheckpoint = await fileExist("Product_${databaseId}.PNG");

    Widget barcodeGenerator = Screenshot(
      controller: barcodeSnapshotController,
      child: SfBarcodeGenerator(
        value: "Product_${databaseId.toString()}",
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

                            String filePath = '$appDocumentsPath/Product_${databaseId}.PNG';

                            Share.shareFiles([filePath],
                                text: "${databaseId}");

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

      setState(() {

        barcodeView;

      });

    });

  }

}