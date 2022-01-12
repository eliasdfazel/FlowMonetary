import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_card_view.dart';
import 'sections/features_view.dart';
import 'sections/general_data_view.dart';
import 'sections/top_bar_view.dart';

class HomePage extends StatefulWidget {

  final String applicationName;

  const HomePage({Key? key, required this.applicationName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return SafeArea (
        child: MaterialApp (
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName,
          color: ColorsResources.black,
          theme: ThemeData(fontFamily: 'Sans', colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColorLight)),
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
                        ColorsResources.primaryColorLightest,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      transform: GradientRotation(45),
                      tileMode: TileMode.clamp),
                ),
                child: Expanded(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 179,
                        child: RotatedBox (
                            quarterTurns: 2,
                            child: WaveWidget(
                              config: CustomConfig(
                                colors: [
                                  ColorsResources.primaryColorLighter,
                                  ColorsResources.primaryColorLight,
                                  ColorsResources.primaryColor,
                                ],
                                heightPercentages: [0.13, 0.57, 0.79],
                                durations: [13000, 21000, 19000],
                                blur: const MaskFilter.blur(BlurStyle.normal, 3.1),
                              ),
                              backgroundColor: Colors.transparent,
                              size: const Size(double.infinity, 300),
                              waveAmplitude: 7,
                              duration: 1000,
                              isLoop: true,
                            )
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 179,
                        child: RotatedBox (
                            quarterTurns: 2,
                            child: WaveWidget(
                              config: CustomConfig(
                                colors: [
                                  ColorsResources.primaryColor,
                                  ColorsResources.primaryColor,
                                  ColorsResources.primaryColorDark,
                                ],
                                heightPercentages: [0.13, 0.57, 0.79],
                                durations: [13000, 21000, 19000],
                                blur: const MaskFilter.blur(BlurStyle.outer, 3.7),
                              ),
                              backgroundColor: Colors.transparent,
                              size: const Size(double.infinity, 300),
                              waveAmplitude: 7,
                              duration: 1000,
                              isLoop: true,
                            )
                        ),
                      ),
                      ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                          scrollDirection: Axis.vertical,
                          children: [
                            const TopBarView(),
                            const GeneralDataView(),
                            CreditCardsView(
                                allCreditCardsData: prepareCreditCardsData(),
                            ),
                            const Divider(
                              height: 31,
                              color: Colors.white,
                              thickness: 1,
                              indent: 73,
                              endIndent: 73,
                            ),
                            const FeaturesOptionsView(),
                          ]
                      )
                    ],
                  ),
                ),
              ),),
          ),
        ));
  }

  List<CreditCardsData> prepareCreditCardsData() {

    var cardNumber = "6274121111111111";
    var cardExpiryDate = '07-05';
    var cardHolderName = "آبان آبسالان";
    var cardCVV = '456';
    var cardBankName = 'اقتصاد نوین';
    var cardBalance = "7777";

    //Get From Database

    return [CreditCardsData(
      id: 1,
      cardNumber: cardNumber,
      cardExpiry: cardExpiryDate,
      cardHolderName: cardHolderName,
      cvv: cardCVV,
      bankName: cardBankName,
      cardBalance: cardBalance
    )];
  }

}