import 'dart:math';

import 'package:flow_accounting/resources/IconsResources.dart';
import 'package:flow_accounting/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditCardView extends StatefulWidget {

  final String cardNumber;
  final String cardExpiry;
  final String cardHolderName;
  final String cvv;
  final String bankName;

  const CreditCardView({Key? key, required this.cardNumber, required this.cardExpiry, required this.cardHolderName, required this.cvv, required this.bankName}) : super(key: key);

  @override
  State<CreditCardView> createState() => _CreditCardView();

}

class _CreditCardView extends State<CreditCardView> with SingleTickerProviderStateMixin {

  var showCardsBack = false;

  late AnimationController _controller;
  Animation<double>? _moveToBack;
  Animation<double>? _moveToFront;

  @override
  void initState() {

    _controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    _moveToBack = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeInBack)),
          weight: 50.0),
      TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2), weight: 50.0)
    ]).animate(_controller);

    _moveToFront = TweenSequence<double>(
      [
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOutBack)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(padding: const EdgeInsets.fromLTRB(13, 23, 0, 0),
      child: Column(
        children: [
          SizedBox(
            height: 199,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 3, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 13,
                      child: GestureDetector(
                        onTap: () {

                          if (showCardsBack) {
                            _controller.reverse();
                          } else {
                            _controller.forward();  }

                          showCardsBack = !showCardsBack;

                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.center,
                          child: Stack(
                            children: [
                              AwesomeCard(
                                animation: _moveToBack,
                                child: frontCardLayout(widget.cardNumber, widget.cardExpiry, widget.cardHolderName, widget.cvv, widget.bankName),
                              ),
                              AwesomeCard(
                                animation: _moveToFront,
                                child: backCardLayout(widget.cvv),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {



                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.center,
                          child: const Icon(IconsResources.share, size: 23.0, color: ColorsResources.dark),
                        ),
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),);
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
          offset: Offset(3.0, 3.0),
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
                    ColorsResources.primaryColor,
                    ColorsResources.primaryColorLighter,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  transform: GradientRotation(45),
                  tileMode: TileMode.clamp),
            ),
          ),
          const Image(
            image: AssetImage('pattern_card_background.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
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
          offset: Offset(3.0, 3.0),
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