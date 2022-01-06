import 'package:flow_accounting/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: FlowDashboard()));

}

class FlowDashboard extends StatelessWidget {

  const FlowDashboard({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
                Expanded(child: RotatedBox (
                  quarterTurns: 2,
                  child: WaveWidget(
                    config: CustomConfig(
                      colors: [
                        Colors.blue.shade200,
                        Colors.blue.shade400,
                        Colors.blue.shade600,
                        Colors.blue.shade900,
                      ],
                      durations: [32000, 21000, 18000, 5000],
                      heightPercentages: [0.25, 0.26, 0.28, 0.31],
                      blur: MaskFilter.blur(BlurStyle.outer, 3.0),
                    ),
                    backgroundColor: Colors.transparent,
                    size: const Size(double.infinity, double.infinity),
                    waveAmplitude: 7,
                  ),
                )),
                Expanded(child: Text(
                    "Test Title"
                ))
              ],
            ),
          ),),
      ),
    ));;
  }

}