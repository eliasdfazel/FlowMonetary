import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'resources/colors.dart';
import 'resources/strings.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp( home: WelcomePage()));

}

class WelcomePage extends StatelessWidget {

  const WelcomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringsResources.applicationName,
          color: ColorsResources.primaryColor,
          theme: ThemeData(fontFamily: 'Sans', colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.primaryColor)),
          home: Scaffold(
              backgroundColor: ColorsResources.black,
              body: Padding (
                padding: const EdgeInsets.fromLTRB(/*left*/1.1, /*top*/3, /*right*/1.1, /*bottom*/3),
                child: Container (
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                    gradient: LinearGradient(
                        colors: [
                          ColorsResources.primaryColor,
                          ColorsResources.primaryColorLight,
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        transform: GradientRotation(45),
                        tileMode: TileMode.clamp),
                  ),
                  child: SizedBox (
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 39,
                            left: 13,
                            right: 13,
                            child: Center(
                              child: Text("Welcome To Flow Accounting",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23
                                ),
                              ),
                            )
                        ),
                        Positioned(
                            bottom: 39,
                            left: 13,
                            right: 13,
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 11,
                                    child: Container(
                                      height: 79,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(17), topRight: Radius.circular(17), bottomLeft: Radius.circular(17), bottomRight: Radius.circular(17)),
                                        gradient: LinearGradient(
                                            colors: [
                                              ColorsResources.dark,
                                              ColorsResources.primaryColor,
                                            ],
                                            begin: FractionalOffset(0.0, 0.0),
                                            end: FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            transform: GradientRotation(45),
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Center(
                                        child: MaterialButton(
                                          onPressed: () {

                                          },
                                          child: Text(
                                            "Get Started",
                                            style: TextStyle(fontSize: 29,shadows: [
                                              Shadow(
                                                color: ColorsResources.light,
                                                offset: Offset(0, 0),
                                                blurRadius: 7
                                              )
                                            ]),

                                          ),
                                          height: 79,
                                          minWidth: double.infinity,
                                          color: Colors.white.withOpacity(0.3),
                                          splashColor: ColorsResources.primaryColor,
                                          textColor: ColorsResources.light,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(17),),
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(),
                                  ),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  )
              )
          ),
        )
    )
    );
  }

}