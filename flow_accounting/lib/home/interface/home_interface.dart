import 'package:flow_accounting/resources/colors.dart';
import 'package:flow_accounting/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_card_view.dart';
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

    var cardBankName = 'اقتصاد نوین';
    var cardHolderName = "آبان آبسالان";
    var cardNumber = "6274121111111111";
    var cardCVV = '456';
    var cardExpiryDate = '۰۷/۰۵';

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
                        ColorsResources.primaryColorLighter,
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
                            CreditCardView(
                                bankName: cardBankName,
                                cardHolderName: cardHolderName,
                                cardNumber: cardNumber,
                                cardExpiry: cardExpiryDate,
                                cvv: cardCVV
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      "123",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      "XYZ",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]
                      )
                    ],
                  ),
                ),
              ),),
          ),
        ));
  }

}