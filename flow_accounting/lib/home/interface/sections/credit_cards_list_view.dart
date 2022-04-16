/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/22/22, 6:55 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/io/queries.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/credit_cards/input/ui/credit_cards_input_view.dart';
import 'package:flow_accounting/profile/database/io/queries.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/colors/color_extractor.dart';
import 'package:flow_accounting/utils/extensions/BankLogos.dart';
import 'package:flow_accounting/utils/navigations/navigations.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class CreditCardsListView extends StatefulWidget {

  List<CreditCardsData> allCreditCardsData = [];

  CreditCardsListView({Key? key, required this.allCreditCardsData}) : super(key: key);

  @override
  State<CreditCardsListView> createState() => _CreditCardsListView();

}
class _CreditCardsListView extends State<CreditCardsListView> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget creditCardsPlaceholder = SizedBox(
      height: 199,
      width: double.infinity,
      child: InkWell(
        onTap: () {

          NavigationProcess().goTo(context,
              CreditCardsInputView(
                creditCardsData: CreditCardsData(
                  id: 0,
                  bankName: "",
                  cardNumber: "",
                  cardHolderName: "",
                  cvv: "",
                  cardBalance: "",
                  cardExpiry: "",
                  colorTag: Colors.transparent.value
                )
              )
          );

        },
        child: const Image(
          image: AssetImage("add_credit_card_icon.png"),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );

    if (widget.allCreditCardsData.isNotEmpty) {

      List<Widget> creditCardWidgets = [];

      for (var creditCardData in widget.allCreditCardsData) {

        creditCardWidgets.add(creditCardWidgetItem(
          creditCardData.id,
          creditCardData.cardNumber,
          creditCardData.cardExpiry,
          creditCardData.cardHolderName,
          creditCardData.cvv,
          creditCardData.bankName,
          creditCardData.cardBalance,
          creditCardData.colorTag
        ));

      }

      creditCardWidgets.add(SizedBox(
        height: 199,
        width: 373,
        child: InkWell(
          onTap: () {

            NavigationProcess().goTo(context,
                CreditCardsInputView(
                    creditCardsData: CreditCardsData(
                        id: 0,
                        bankName: "",
                        cardNumber: "",
                        cardHolderName: "",
                        cvv: "",
                        cardBalance: "",
                        cardExpiry: "",
                        colorTag: Colors.transparent.value
                    )
                )
            );

          },
          child: const Image(
            image: AssetImage("add_credit_card_icon.png"),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ));

      creditCardsPlaceholder = SizedBox(
        height: 299,
        width: double.infinity,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(3, 11, 0, 11),
          children: creditCardWidgets,
        ),
      );

    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
      child: Column(
        children: [
          creditCardsPlaceholder
        ],
      ),
    );
  }

  Widget creditCardWidgetItem(
      int id,
      String cardNumber,
      String cardExpiry,
      String cardHolderName,
      String cvv,
      String bankName,
      String cardBalance,
      int colorTag) {

    var showCardsBack = false;

    AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this
    );

    Animation<double>? moveToBack = TweenSequence<double>([
      TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: pi / 2).chain(CurveTween(curve: Curves.easeInBack)), weight: 50.0),
      TweenSequenceItem<double>(tween: ConstantTween<double>(pi / 2), weight: 50.0)
    ]).animate(animationController);
    Animation<double>? moveToFront = TweenSequence<double>([
      TweenSequenceItem<double>(tween: ConstantTween<double>(pi / 2), weight: 50.0,),
      TweenSequenceItem<double>(tween: Tween<double>(begin: -pi / 2, end: 0.0).chain(CurveTween(curve: Curves.easeOutBack)), weight: 50.0,),
    ],).animate(animationController);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
      child: SizedBox(
        height: 279,
        width: 373,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                  child: SizedBox(
                      height: 199,
                      width: 291,
                      child: GestureDetector(
                        onTap: () {

                          if (showCardsBack) {
                            animationController.reverse();
                          } else {
                            animationController.forward();
                          }

                          showCardsBack = !showCardsBack;

                        },
                        onLongPress: () {

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              cardNumber,
                              style: const TextStyle(
                                color: ColorsResources.light
                              ),
                            ),
                            duration: const Duration(seconds: 7),
                            elevation: 7,
                            margin: const EdgeInsets.fromLTRB(19, 0, 19, 31),
                            backgroundColor: ColorsResources.dark,
                            shape:  const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(51)),
                            ),
                            action: SnackBarAction(
                              label: StringsResources.deleteText(),
                              onPressed: () async {

                                String databaseDirectory = await getDatabasesPath();

                                String creditCardDatabasePath = "${databaseDirectory}/${CreditCardsDatabaseInputs.creditCardDatabase()}";

                                bool creditCardDatabaseExist = await databaseExists(creditCardDatabasePath);

                                if (creditCardDatabaseExist) {

                                  CreditCardsDatabaseQueries()
                                      .queryDeleteCreditCard(id, CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

                                  prepareCreditCardsData();

                                }

                              },
                            ),
                          ));

                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.center,
                          child: Stack(
                            children: [
                              AwesomeCard(
                                animation: moveToBack,
                                child: CreditCardFrontLayout(
                                  bankName: bankName,
                                  cardExpiry: cardExpiry,
                                  cardHolderName: cardHolderName,
                                  cardNumber: cardNumber,
                                  cvv: cvv,
                                  colorTag: colorTag,
                                ),
                              ),
                              AwesomeCard(
                                animation: moveToFront,
                                child: CreditCardBackLayout(
                                  cardBankName: bankName,
                                  cardCVV: cvv,
                                  colorTag: colorTag,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 7, 0),
                  child: SizedBox(
                    height: 53,
                    width: 291,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                            gradient: LinearGradient(
                                colors: [
                                  ColorsResources.white,
                                  ColorsResources.light,
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                transform: GradientRotation(45),
                                tileMode: TileMode.clamp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                              gradient: LinearGradient(
                                  colors: [
                                    ColorsResources.light,
                                    ColorsResources.white,
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  transform: GradientRotation(45),
                                  tileMode: TileMode.clamp),
                            ),
                            child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                  child: Text(
                                    cardBalance,
                                    style: const TextStyle(fontSize: 23, shadows: [
                                      Shadow(
                                          color: ColorsResources.light,
                                          offset: Offset(0, 0),
                                          blurRadius: 7
                                      )
                                    ]),
                                  ),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 279,
                width: 53,
                child: InkWell(
                    onTap: () {

                      creditCardInputUpdateListener(context,
                          id,
                          cardNumber,
                          cardExpiry,
                          cardHolderName,
                          cvv,
                          bankName,
                          cardBalance,
                          colorTag
                      );

                    },
                    child: Stack(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                            gradient: LinearGradient(
                                colors: [
                                  ColorsResources.white,
                                  ColorsResources.light,
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                transform: GradientRotation(45),
                                tileMode: TileMode.clamp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7), bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                              gradient: LinearGradient(
                                  colors: [
                                    ColorsResources.light,
                                    ColorsResources.white,
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  transform: GradientRotation(45),
                                  tileMode: TileMode.clamp),
                            ),
                            alignment: AlignmentDirectional.center,
                            child: RotatedBox(
                                quarterTurns: 3,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(StringsResources.detailsText(),
                                    style: TextStyle(fontSize: 23,shadows: [
                                      Shadow(
                                          color: ColorsResources.light,
                                          offset: Offset(0, 0),
                                          blurRadius: 7
                                      )
                                    ]),
                                  ),
                                )
                            ),
                          ),
                        )
                      ],
                    )
                )
            ),
          ],
        ),
      ),
    );

  }

  void prepareCreditCardsData() async {

    widget.allCreditCardsData.clear();

    String databaseDirectory = await getDatabasesPath();

    String creditCardDatabasePath = "${databaseDirectory}/${CreditCardsDatabaseInputs.creditCardDatabase()}";

    bool creditCardDatabaseExist = await databaseExists(creditCardDatabasePath);

    if (creditCardDatabaseExist) {

      CreditCardsDatabaseQueries databaseQueries = CreditCardsDatabaseQueries();

      List<CreditCardsData> listOfAllCreditCards = await databaseQueries.getAllCreditCards(CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

      setState(() {

        widget.allCreditCardsData = listOfAllCreditCards;

      });

    }

  }

  void creditCardInputUpdateListener(BuildContext context,
      int id,
      String cardNumber,
      String cardExpiry,
      String cardHolderName,
      String cvv,
      String bankName,
      String cardBalance,
      int colorTag) async {

    bool creditCardDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreditCardsInputView(
          creditCardsData: CreditCardsData(
              id: id,
              bankName: bankName,
              cardNumber: cardNumber,
              cardHolderName: cardHolderName,
              cvv: cvv,
              cardBalance: cardBalance,
              cardExpiry: cardExpiry,
              colorTag: colorTag
          )
      )),
    );

    debugPrint("Credit Card Data Update => ${creditCardDataUpdated}");
    if (creditCardDataUpdated) {

      prepareCreditCardsData();

    }

  }

}

class AwesomeCard extends StatelessWidget {

  final Animation<double>? animation;

  final Widget child;

  const AwesomeCard({Key? key, required this.animation, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: animation!,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation!.value),
          alignment: Alignment.center,
          child: this.child,
        );
      },
    );
  }
}

class CreditCardFrontLayout extends StatefulWidget {

  String cardNumber;
  String cardExpiry;
  String cardHolderName;
  String cvv;
  String bankName;

  int colorTag = Colors.transparent.value;

  CreditCardFrontLayout({Key? key, required this.cardNumber, required this.cardExpiry, required this.cardHolderName, required this.bankName, required this.cvv, required this.colorTag}) :super(key: key);

  @override
  State<CreditCardFrontLayout> createState() => _CreditCardFrontLayout();

}
class _CreditCardFrontLayout extends State<CreditCardFrontLayout> {

  ImageProvider? bankLogoImageProviderFront;

  Color dominantColorForFrontLayout = ColorsResources.dark;

  bool frontLayoutDecorated = false;

  String backgroundPattern = generateBackgroundPattern();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return frontCardLayout(widget.cardNumber, widget.cardExpiry, widget.cardHolderName, widget.cvv, widget.bankName);
  }

  Widget frontCardLayout(String cardNumber, String cardExpiry, String cardHolderName, String cvv, String bankName) {

    CachedNetworkImage bankLogoImageView = CachedNetworkImage(
      imageUrl: generateBankLogoUrl(bankName),
      height: 51,
      width: 51,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {

        bankLogoImageProviderFront = imageProvider;

        if (!frontLayoutDecorated) {
          frontLayoutDecorated = true;

          extractBankDominantColor();
        }

        return Image(
          image: imageProvider,
        );
      },
    );

    return Container(
      height: 279,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: dominantColorForFrontLayout.withOpacity(0.51),
            blurRadius: 13.0,
            spreadRadius: 0.3,
            offset: const Offset(3.9, 3.9),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.0),
        child: Stack(
          children: <Widget> [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                gradient: LinearGradient(
                    colors: [
                      ColorsResources.light,
                      ColorsResources.white,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    transform: GradientRotation(45),
                    tileMode: TileMode.clamp),
              ),
            ),
            Image(
              image: AssetImage(backgroundPattern),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 11, 11, 0),
                    child: SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(widget.colorTag),
                                          shape: BoxShape.circle
                                      ),
                                      child: const SizedBox(
                                        height: 37,
                                        width: 37,
                                      ),
                                    ),
                                ),
                              )
                          ),
                          Expanded(
                              flex: 13,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 17, 0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      bankName,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: 51,
                                width: 51,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: ColorsResources.white,
                                    shape: BoxShape.circle
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                                      child: bankLogoImageView,
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
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 0, 11, 0),
                    child: SizedBox(
                      height: 63,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cardNumber.substring(0, 4),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cardNumber.substring(4, 8),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cardNumber.substring(8, 12),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cardNumber.substring(12, 16),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 5, 11, 1),
                    child: SizedBox(
                      height: 59,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 19,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(11, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      cardHolderName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cardExpiry.substring(0, 2),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "/",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 3,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cardExpiry.substring(3, 5),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void extractBankDominantColor() async {

    if (bankLogoImageProviderFront != null) {

      Future<Color?> bankDominantColor = imageDominantColor(bankLogoImageProviderFront!);

      bankDominantColor.then((extractedColor) {

        if (extractedColor != null) {

          setState(() {

            dominantColorForFrontLayout = extractedColor;

          });

        }

      });

    }

  }

}

class CreditCardBackLayout extends StatefulWidget {

  String cardBankName;
  String cardCVV;

  int colorTag = Colors.transparent.value;

  CreditCardBackLayout({Key? key, required this.cardBankName, required this.cardCVV, required this.colorTag}) :super(key: key);

  @override
  State<CreditCardBackLayout> createState() => _CreditCardBackLayout();

}
class _CreditCardBackLayout extends State<CreditCardBackLayout> {

  ImageProvider? bankLogoImageProviderBack;

  Color dominantColorForBackLayout = ColorsResources.white;

  bool backLayoutDecorated = false;

  String backgroundPattern = generateBackgroundPattern();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return backCardLayout(widget.cardCVV);
  }

  Widget backCardLayout(String cvv) {

    CachedNetworkImage bankLogoImageView = CachedNetworkImage(
      imageUrl: generateBankLogoUrl(widget.cardBankName),
      height: 51,
      width: 51,
      fit: BoxFit.contain,
      imageBuilder: (context, imageProvider) {

        bankLogoImageProviderBack = imageProvider;

        if (!backLayoutDecorated) {
          backLayoutDecorated = true;

          extractBankDominantColor();

        }

        return Image(
          image: imageProvider,
        );
      },
    );

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: dominantColorForBackLayout.withOpacity(0.51),
            blurRadius: 13.0,
            spreadRadius: 0.3,
            offset: const Offset(3.9, 3.9),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13.0),
        child: Stack(
          children: <Widget> [
            Opacity(
              opacity: 0,
              child: bankLogoImageView,
            ),
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                gradient: LinearGradient(
                    colors: [
                      ColorsResources.light,
                      dominantColorForBackLayout,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    transform: const GradientRotation(45),
                    tileMode: TileMode.clamp),
              ),
            ),
            Image(
              image: AssetImage(backgroundPattern),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 19, 0, 0),
                  child: SizedBox(
                    height: 59,
                    width: double.infinity,
                    child: ColoredBox(
                      color: ColorsResources.dark,
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 11, 0),
                    child: SizedBox(
                      height: 51,
                      width: double.infinity,
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 17,
                              child: Container(
                                color: ColorsResources.dark,
                                child: CachedNetworkImage(
                                  imageUrl: "https://myhousestore.ir/wp-content/uploads/2022/02/GraphitTexture.jpg",
                                  fit: BoxFit.cover,
                                  color: Color(widget.colorTag),
                                  colorBlendMode: BlendMode.overlay,
                                ),
                              )
                          ),
                          Expanded(
                              flex: 7,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      cvv,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: ColorsResources.dark,
                                        shadows: [
                                          Shadow(
                                            color: ColorsResources.dark.withOpacity(0.37),
                                            blurRadius: 7,
                                            offset: const Offset(1.9, 1.9),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void extractBankDominantColor() async {

    if (bankLogoImageProviderBack != null) {

      Future<Color?> bankDominantColor = imageDominantColor(bankLogoImageProviderBack!);

      bankDominantColor.then((extractedColor) {

        if (extractedColor != null) {
          dominantColorForBackLayout = extractedColor;

          setState(() {

            dominantColorForBackLayout;

          });

        }

      });

    }

  }

}

String generateBackgroundPattern() {

  List listOfPattern = [];
  listOfPattern.add("pattern_card_background_one.png");
  listOfPattern.add("pattern_card_background_two.png");
  listOfPattern.add("pattern_card_background_three.png");
  listOfPattern.add("pattern_card_background_four.png");
  listOfPattern.add("pattern_card_background_five.png");

  return listOfPattern[Random().nextInt(listOfPattern.length)];
}