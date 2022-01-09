import 'package:awesome_card/awesome_card.dart';
import 'package:flow_accounting/resources/IconsResources.dart';
import 'package:flow_accounting/resources/colors.dart';
import 'package:flutter/material.dart';

class CreditCardView extends StatefulWidget {
  const CreditCardView({Key? key}) : super(key: key);

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


    return Padding(padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 179,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(3, 1, 3, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 11,
                      child: GestureDetector(
                        onTap: () {

                          setState(() {
                            showCardsBack = !showCardsBack;
                          });

                        },
                        child: Container(
                          color: Colors.transparent,
                          alignment: AlignmentDirectional.center,
                          child: CreditCard(
                            cardNumber: "cardNumber",
                            cardExpiry: "expiryDate",
                            cardHolderName: "cardHolderName",
                            cvv: "cvv",
                            bankName: 'Axis Bank',
                            showBackSide: showCardsBack,
                            frontBackground: CardBackgrounds.black,
                            backBackground: CardBackgrounds.white,
                            showShadow: true,
                            mask: getCardTypeMask(cardType: CardType.americanExpress),
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
                          color: Colors.redAccent,
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