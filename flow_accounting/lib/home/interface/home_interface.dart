import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/home/interface/sections/search_bar_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/credit_cards_list_view.dart';
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17.0),
                              child: WaveWidget(
                                config: CustomConfig(
                                  colors: [
                                    ColorsResources.primaryColor,
                                    ColorsResources.primaryColorDark,
                                    ColorsResources.black,
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
                              ),
                            ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 179,
                        child: RotatedBox (
                            quarterTurns: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17.0),

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
                              ),
                            ),
                        ),
                      ),
                      ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                          scrollDirection: Axis.vertical,
                          children: [
                            const TopBarView(),
                            const GeneralDataView(),
                            CreditCardsListView(
                              allCreditCardsData: prepareCreditCardsData(),
                            ),
                            const SearchBarView(),
                            const FeaturesOptionsView(),
                          ]
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  List<CreditCardsData> prepareCreditCardsData() {

    //Get From Database

    return [
      CreditCardsData(
          id: 1,
          cardNumber: "6274121210306479",
          cardExpiry: "07-05",
          cardHolderName: "آبان آبسالان",
          cvv: "456",
          bankName: "اقتصاد نوین",
          cardBalance: "17777"
      ),
      CreditCardsData(
          id: 2,
          cardNumber: "6074121210306479",
          cardExpiry: "01-04",
          cardHolderName: "آبان آبسالان",
          cvv: "456",
          bankName: "اقتصاد نوین",
          cardBalance: "27777"
      ),
      CreditCardsData(
          id: 3,
          cardNumber: "5374121210306479",
          cardExpiry: "04-08",
          cardHolderName: "آبان آبسالان",
          cvv: "456",
          bankName: "اقتصاد نوین",
          cardBalance: "37777"
      )
    ];
  }

}