import 'package:flow_accounting/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'sections/top_bar.dart';

class HomePage extends StatefulWidget {

  final String applicationName;

  const HomePage({Key? key, required this.applicationName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return SafeArea (child: MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(fontFamily: 'Sans'),
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
            child: Column ( /*** Page Content ***/
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Stack(
                    children: [
                      RotatedBox (
                          quarterTurns: 2,
                          child: WaveWidget(
                            config: CustomConfig(
                              colors: [
                                ColorsResources.primaryColorLighter,
                                ColorsResources.primaryColorLight,
                                ColorsResources.primaryColor,
                                ColorsResources.primaryColorTransparent,
                                ColorsResources.primaryColorDarkTransparent,
                              ],
                              heightPercentages: [0.13, 0.37, 0.57, 0.79, 0.93],
                              durations: [13000, 7000, 9900, 21000, 19000],
                              blur: const MaskFilter.blur(BlurStyle.normal, 3.1),
                            ),
                            backgroundColor: Colors.transparent,
                            size: const Size(double.infinity, 300),
                            waveAmplitude: 7,
                            duration: 1000,
                            isLoop: true,
                          )
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TopBar(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: ListView(children: [
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
                ])),
                MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: const Text('Insert'),
                  onPressed: () {


                  },
                )
              ],
            ),
          ),),
      ),
    ));
  }

}