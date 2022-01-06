import 'package:flow_accounting/resources/colors.dart';
import 'package:flow_accounting/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HomePage extends StatefulWidget {

  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return SafeArea (child: MaterialApp (
      debugShowCheckedModeBanner: false,
      color: ColorsPalette.black,
      theme: ThemeData(fontFamily: 'Sans'),
      home: Scaffold(
        backgroundColor: ColorsPalette.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
          child: Container (
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
              gradient: LinearGradient(
                  colors: [
                    ColorsPalette.white,
                    ColorsPalette.primaryColorLighter,
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
                                Colors.green.shade50,
                                Colors.green.shade100,
                                Colors.green.shade300,
                                Colors.green.shade300,
                                Colors.green.shade700,
                              ],
                              durations: [11000, 11000, 13000, 7700, 9000],
                              heightPercentages: [0.50, 0.25, 0.35, 0.91, 0.79],
                              blur: const MaskFilter.blur(BlurStyle.normal, 1.9),
                            ),
                            backgroundColor: Colors.transparent,
                            size: const Size(double.infinity, 300),
                            waveAmplitude: 7,
                          )
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 19, 15, 0),
                            child: Text(
                              Strings.applicationName,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.black54,
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withOpacity(0.7),
                                    offset: Offset(3, 3),
                                    blurRadius: 11,
                                  )
                                ],
                              ),
                            ),
                          )
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