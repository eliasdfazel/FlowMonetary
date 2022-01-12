import 'dart:math';

import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditCardsView extends StatefulWidget {

  List<CreditCardsData> allCreditCardsData = [];

  CreditCardsView({Key? key, required this.allCreditCardsData}) : super(key: key);

  @override
  State<CreditCardsView> createState() => _CreditCardView();

}

class _CreditCardView extends State<CreditCardsView> with TickerProviderStateMixin {

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

    List<Widget> creditCardWidgets = [];

    widget.allCreditCardsData.forEach((element) {

      creditCardWidgets.add(creditCardWidgetItem(
        element.cardNumber,
        element.cardExpiry,
        element.cardHolderName,
        element.cvv,
        element.bankName,
        element.cardBalance
      ));

    });

    return Padding(padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
      child: Column(
        children: [
          SizedBox(
            height: 299,
            width: double.infinity,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(3, 11, 0, 11),
              children: creditCardWidgets,
            ),
          )
        ],
      ),);
  }

  Widget creditCardWidgetItem(String cardNumber,
      String cardExpiry,
      String cardHolderName,
      String cvv,
      String bankName,
      String cardBalance) {

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
      padding: const EdgeInsets.fromLTRB(0, 0, 31, 0),
      child: SizedBox(
        height: 279,
        width: 373,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 13, 0),
                  child: SizedBox(
                      height: 199,
                      width: 291,
                      child: GestureDetector(
                        onTap: () {

                          if (showCardsBack) {
                            animationController.reverse();
                          } else {
                            animationController.forward();  }

                          showCardsBack = !showCardsBack;

                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.center,
                          child: Stack(
                            children: [
                              AwesomeCard(
                                animation: moveToBack,
                                child: frontCardLayout(widget.cardNumber, widget.cardExpiry, widget.cardHolderName, widget.cvv, widget.bankName),
                              ),
                              AwesomeCard(
                                animation: moveToFront,
                                child: backCardLayout(widget.cvv),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 13, 0),
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
                            child: const RotatedBox(
                              quarterTurns: 3,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(StringsResources.detailsText,
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

Widget frontCardLayout(String cardNumber, String cardExpiry, String cardHolderName, String cvv, String bankName) {

  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: ColorsResources.dark.withOpacity(0.5),
          blurRadius: 12.0,
          spreadRadius: 0.2,
          offset: const Offset(3.0, 3.0),
        )
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(11.0),
      child: Stack(
        children: [
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
            image: AssetImage(generateBackgroundPattern()),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(

          )
          // Image(image: AssetImage('graphics/background.png'))
        ],
      ),
    ),
  );
}

Widget backCardLayout(String cvv) {

  return Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: ColorsResources.dark.withOpacity(0.5),
          blurRadius: 12.0,
          spreadRadius: 0.2,
          offset: const Offset(3.0, 3.0),
        )
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          // Background for card
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: ColorsResources.dark,
          ),

          // Back Side Layout
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Color(0xffff00ae),
          ),
        ],
      ),
    ),
  );
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