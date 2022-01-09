import 'package:awesome_card/awesome_card.dart';
import 'package:flow_accounting/resources/IconsResources.dart';
import 'package:flow_accounting/resources/colors.dart';
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

class _CreditCardView extends State<CreditCardView> {

  var showCardsBack = false;

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

    return Padding(padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
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

                          setState(() {
                            showCardsBack = !showCardsBack;
                          });

                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.center,
                          child: Stack(
                            children: [
                              CreditCard(
                                cardNumber: "${widget.cardNumber}",
                                cardExpiry: "${widget.cardExpiry}",
                                cardHolderName: "${widget.cardHolderName}",
                                cvv: "${widget.cvv}",
                                bankName: "${widget.bankName}",
                                showBackSide: showCardsBack,
                                frontBackground: CardBackgrounds.custom(ColorsResources.darkTransparent.value),
                                backBackground: CardBackgrounds.custom(ColorsResources.light.value),
                                showShadow: true,
                                horizontalMargin: 3,
                              )
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