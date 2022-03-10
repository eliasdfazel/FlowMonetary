
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flow_accounting/cheque/database/io/inputs.dart';
import 'package:flow_accounting/cheque/database/io/queries.dart';
import 'package:flow_accounting/cheque/database/structures/table_structure.dart';
import 'package:flow_accounting/cheque/input/ui/cheques_input_view.dart';
import 'package:flow_accounting/resources/ColorsResources.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/utils/colors/color_extractor.dart';
import 'package:flow_accounting/utils/colors/color_selector.dart';
import 'package:flow_accounting/utils/extensions/BankLogos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee/marquee.dart';

class ChequesOutputView extends StatefulWidget {
  const ChequesOutputView({Key? key}) : super(key: key);

  @override
  _ChequesOutputViewState createState() => _ChequesOutputViewState();
}
class _ChequesOutputViewState extends State<ChequesOutputView> {

  ColorSelectorView colorSelectorView = ColorSelectorView();

  List<ChequesData> allCheques = [];
  List<Widget> allChequesItems = [];

  TextEditingController textEditorControllerQuery = TextEditingController();

  bool colorSelectorInitialized = false;

  Color bankLogoColor = Colors.white;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    retrieveAllCheque(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    colorSelectorView.selectedColorNotifier.addListener(() {

      filterByColorTag(context, allCheques, colorSelectorView.selectedColorNotifier.value);

    });

    List<Widget> allListContentWidgets = [];
    allListContentWidgets.add(Padding(
      padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
      child: colorSelectorView,
    ));
    allListContentWidgets.addAll(allChequesItems);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Sans',
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
      home: Scaffold(
          backgroundColor: ColorsResources.black,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(1.1, 3, 1.1, 3),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)
                ),
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
              child: Stack(
                children: [
                  const Opacity(
                    opacity: 0.07,
                    child: Image(
                      image: AssetImage("input_background_pattern.png"),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  ListView(
                    padding: const EdgeInsets.fromLTRB(0, 73, 0, 79),
                    physics: const BouncingScrollPhysics(),
                    children: allListContentWidgets,
                  ),
                  Positioned(
                      top: 19,
                      left: 13,
                      child: InkWell(
                        onTap: () {

                          Navigator.pop(context);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: ColorsResources.blueGrayLight.withOpacity(0.7),
                                    blurRadius: 7,
                                    spreadRadius: 0.1,
                                    offset: const Offset(0.0, 3.7)
                                )
                              ]
                          ),
                          child: const Image(
                            image: AssetImage("go_previous_icon.png"),
                            fit: BoxFit.scaleDown,
                            width: 41,
                            height: 41,
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      top: 19,
                      right: 13,
                      child: SizedBox(
                        height: 43,
                        width: 321,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Expanded(
                              flex: 11,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 43,
                                      width: double.infinity,
                                      child: Blur(
                                        blur: 5,
                                        borderRadius: BorderRadius.circular(51),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    ColorsResources.white.withOpacity(0.3),
                                                    ColorsResources.primaryColorLighter.withOpacity(0.3),
                                                  ],
                                                  begin: const FractionalOffset(0.0, 0.0),
                                                  end: const FractionalOffset(1.0, 0.0),
                                                  stops: const [0.0, 1.0],
                                                  transform: const GradientRotation(45),
                                                  tileMode: TileMode.clamp
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {

                                        sortChequesByDueDate(context, allCheques);

                                      },
                                      child: const SizedBox(
                                        height: 43,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            StringsResources.sortChequeDueDate,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: ColorsResources.applicationGeeksEmpire,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 43,
                                    width: 43,
                                    child: Blur(
                                      blur: 3,
                                      borderRadius: BorderRadius.circular(51),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  ColorsResources.white.withOpacity(0.3),
                                                  ColorsResources.primaryColorLighter.withOpacity(0.3),
                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: const [0.0, 1.0],
                                                transform: const GradientRotation(45),
                                                tileMode: TileMode.clamp
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {

                                        retrieveAllCheque(context);

                                      },
                                      child: const Icon(
                                          Icons.refresh_rounded,
                                          size: 31.0,
                                          color: ColorsResources.primaryColorDark
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    bottom: 19,
                    left: 11,
                    right: 11,
                    child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 73,
                          width: 219,
                          child: Stack(
                            children: [
                              const Image(
                                image: AssetImage("search_shape.png"),
                                height: 73,
                                width: 213,
                                color: ColorsResources.primaryColorDark,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {

                                    String searchQuery = textEditorControllerQuery.text;

                                    searchCheques(context, allCheques, searchQuery);

                                  },
                                  child: const SizedBox(
                                    height: 71,
                                    width: 53,
                                    child: Icon(
                                      Icons.search_rounded,
                                      size: 23,
                                      color: ColorsResources.darkTransparent,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                    width: 153,
                                    height: 47,
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextField(
                                        controller: textEditorControllerQuery,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        textAlignVertical: TextAlignVertical.bottom,
                                        maxLines: 1,
                                        cursorColor: ColorsResources.primaryColor,
                                        autocorrect: true,
                                        autofocus: false,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.search,
                                        onSubmitted: (searchQuery) {

                                          searchCheques(context, allCheques, searchQuery);

                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(51),
                                                  topRight: Radius.circular(51),
                                                  bottomLeft: Radius.circular(51),
                                                  bottomRight: Radius.circular(51)
                                              ),
                                              gapPadding: 5
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(51),
                                                  topRight: Radius.circular(51),
                                                  bottomLeft: Radius.circular(51),
                                                  bottomRight: Radius.circular(51)
                                              ),
                                              gapPadding: 5
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(51),
                                                  topRight: Radius.circular(51),
                                                  bottomLeft: Radius.circular(51),
                                                  bottomRight: Radius.circular(51)
                                              ),
                                              gapPadding: 5
                                          ),
                                          hintText: StringsResources.searchTransactionsText,
                                          hintStyle: TextStyle(
                                              color: ColorsResources.darkTransparent,
                                              fontSize: 13.0
                                          ),
                                          labelText: StringsResources.searchText,
                                          labelStyle: TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 15.0
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget outputItem(BuildContext context, ChequesData chequesData) {

    String chequeNumber = chequesData.chequeNumber;

    String chequeMoneyAmount = chequesData.chequeMoneyAmount;

    String chequeBank = chequesData.chequeSourceBankName;
    String chequeBankBranch = chequesData.chequeSourceBankBranch;

    String chequeTargetName = chequesData.chequeTargetName;
    String chequeTargetAccountNumber = chequesData.chequeTargetAccountNumber;

    Color chequeColorTag = Color(chequesData.colorTag);

    CachedNetworkImage bankLogoImageView = CachedNetworkImage(
      imageUrl: generateBankLogoUrl(chequeBank),
      height: 51,
      width: 51,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {

        extractBankDominantColor(imageProvider);

        return Image(
          image: imageProvider,
        );
      },
    );

    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              deleteCheque(context, chequesData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.gameGeeksEmpire,
            icon: Icons.delete_rounded,
            label: StringsResources.deleteText,
            autoClose: true,
          ),
          SlidableAction(
            flex: 1,
            onPressed: (BuildContext context) {

              editCheque(context, chequesData);

            },
            backgroundColor: Colors.transparent,
            foregroundColor: ColorsResources.applicationGeeksEmpire,
            icon: Icons.edit_rounded,
            label: StringsResources.editText,
            autoClose: true,
          ),
        ],
      ),
      child: Padding(
        padding: const  EdgeInsets.fromLTRB(13, 7, 13, 13),
        child: PhysicalModel(
          color: ColorsResources.light,
          elevation: 7,
          shadowColor: chequeColorTag.withOpacity(0.79),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(17)),
          child: InkWell(
            onTap: () {

              editCheque(context, chequesData);

            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                    bottomLeft: Radius.circular(17),
                    bottomRight: Radius.circular(17)
                ),
                gradient: LinearGradient(
                    colors: [
                      ColorsResources.white,
                      ColorsResources.light,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    transform: GradientRotation(45),
                    tileMode: TileMode.clamp
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              height: 79,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(13, 11, 13, 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          chequeNumber,
                                          style: const TextStyle(
                                            color: ColorsResources.black,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(3, 0, 13, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              height: 31,
                                              width: double.infinity,
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    chequeBank,
                                                    style: const TextStyle(
                                                      color: ColorsResources.dark,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 27,
                                              width: double.infinity,
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    chequeBankBranch,
                                                    style: const TextStyle(
                                                      color: ColorsResources.darkTransparent,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        height: 51,
                                        width: 51,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: ColorsResources.white,
                                              shape: BoxShape.circle
                                          ),
                                          child: Align(
                                            alignment: AlignmentDirectional.center,
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                                              child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
                                                  child: bankLogoImageView
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          SizedBox(
                            height: 57,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 7, 17, 7),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Marquee(
                                    text: chequeMoneyAmount,
                                    style: const TextStyle(
                                      color: ColorsResources.dark,
                                      fontSize: 31,
                                      fontFamily: "Numbers",
                                    ),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    blankSpace: 199.0,
                                    velocity: 37.0,
                                    fadingEdgeStartFraction: 0.15,
                                    fadingEdgeEndFraction: 0.15,
                                    startAfter: const Duration(milliseconds: 777),
                                    numberOfRounds: 3,
                                    pauseAfterRound: const Duration(milliseconds: 500),
                                    showFadingOnlyWhenScrolling: true,
                                    startPadding: 13.0,
                                    accelerationDuration: const Duration(milliseconds: 500),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration: const Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 53,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(37, 0, 17, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 13,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          chequeTargetAccountNumber,
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 15,
                                          )
                                      )
                                    )
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            chequeTargetName,
                                            maxLines: 1,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: ColorsResources.dark,
                                              fontSize: 17,
                                            )
                                        )
                                    )
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            " :${StringsResources.chequeTargetName}",
                                            textAlign: TextAlign.right,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: ColorsResources.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: SizedBox(
                            height: 27,
                            width: 79,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(17),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(17)
                                ),
                                gradient: LinearGradient(
                                    colors: [
                                      chequeColorTag.withOpacity(0.7),
                                      ColorsResources.light,
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: const [0.0, 1.0],
                                    transform: const GradientRotation(45),
                                    tileMode: TileMode.clamp
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),
        ),
      )
    );

  }

  void deleteCheque(BuildContext context, ChequesData chequesData) async {

    var databaseQueries = ChequesDatabaseQueries();

    databaseQueries.queryDeleteCheque(chequesData.id, ChequesDatabaseInputs.databaseTableName);

    retrieveAllCheque(context);

  }

  void editCheque(BuildContext context, ChequesData chequesData) async {

    bool chequeDataUpdated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChequesInputView(chequesData: chequesData)),
    );

    debugPrint("Cheque Data Update => ${chequeDataUpdated}");
    if (chequeDataUpdated) {

      retrieveAllCheque(context);

    }

  }

  void retrieveAllCheque(BuildContext context) async {

    if (allChequesItems.isNotEmpty) {

      allChequesItems.clear();

    }

    List<Widget> preparedAllChequesItem = [];

    var databaseQueries = ChequesDatabaseQueries();

    allCheques = await databaseQueries.getAllCheques(ChequesDatabaseInputs.databaseTableName);

    for (var element in allCheques) {

      preparedAllChequesItem.add(outputItem(context, element));

    }

    colorSelectorInitialized = false;

    setState(() {

      allChequesItems = preparedAllChequesItem;

    });

  }

  void sortChequesByDueDate(BuildContext context, List<ChequesData> inputChequesList) {

    if (allChequesItems.isNotEmpty) {

      allChequesItems.clear();

    }
    inputChequesList.sort((a, b) => (a.chequeDueMillisecond).compareTo(b.chequeDueMillisecond));

    List<Widget> preparedAllTransactionsItem = [];

    for (var element in inputChequesList) {

      preparedAllTransactionsItem.add(outputItem(context, element));

    }

    setState(() {

      allChequesItems = preparedAllTransactionsItem;

    });

  }

  void filterByColorTag(BuildContext context,
      List<ChequesData> inputChequesList, Color colorQuery) {

    List<ChequesData> searchResult = [];

    for (var element in inputChequesList) {

      if (element.colorTag == colorQuery.value) {

        searchResult.add(element);

      }

      List<Widget> preparedAllChequesItem = [];

      for (var element in searchResult) {

        preparedAllChequesItem.add(outputItem(context, element));

      }

      setState(() {

        allChequesItems = preparedAllChequesItem;

      });

    }

  }

  void searchCheques(BuildContext context,
      List<ChequesData> inputChequesList, String searchQuery) {

    List<ChequesData> searchResult = [];

    for (var element in inputChequesList) {

      if (element.chequeTitle.contains(searchQuery) ||
          element.chequeDescription.contains(searchQuery) ||
          element.chequeNumber.contains(searchQuery) ||
          element.chequeMoneyAmount.contains(searchQuery) ||
          element.chequeIssueDate.contains(searchQuery) ||
          element.chequeDueDate.contains(searchQuery) ||
          element.chequeSourceId.contains(searchQuery) ||
          element.chequeSourceName.contains(searchQuery) ||
          element.chequeSourceBankName.contains(searchQuery) ||
          element.chequeSourceBankBranch.contains(searchQuery) ||
          element.chequeSourceAccountNumber.contains(searchQuery) ||
          element.chequeTargetId.contains(searchQuery) ||
          element.chequeTargetName.contains(searchQuery) ||
          element.chequeTargetBankName.contains(searchQuery) ||
          element.chequeTargetAccountNumber.contains(searchQuery) ||
          element.chequeRelevantCreditCard.contains(searchQuery) ||
          element.chequeRelevantBudget.contains(searchQuery)
      ) {

        searchResult.add(element);

      }

      List<Widget> preparedAllBudgetsItem = [];

      for (var element in searchResult) {

        preparedAllBudgetsItem.add(outputItem(context, element));

      }

      setState(() {

        allChequesItems = preparedAllBudgetsItem;

      });

    }

  }

  void extractBankDominantColor(ImageProvider? bankLogoImageProvider) async {

    if (bankLogoImageProvider != null) {

      Future<Color?> bankDominantColor = imageDominantColor(bankLogoImageProvider);

      bankDominantColor.then((extractedColor) {

        if (extractedColor != null) {

          setState(() {

            bankLogoColor = extractedColor;

          });

        }

      });

    }

  }

}