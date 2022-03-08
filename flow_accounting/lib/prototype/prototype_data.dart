/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/22/22, 6:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/budgets/database/io/inputs.dart';
import 'package:flow_accounting/budgets/database/structures/tables_structure.dart';
import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';
import 'package:flow_accounting/customers/database/io/inputs.dart';
import 'package:flow_accounting/customers/database/structures/table_structure.dart';
import 'package:flow_accounting/resources/StringsResources.dart';
import 'package:flow_accounting/transactions/database/io/inputs.dart';
import 'package:flow_accounting/transactions/database/structures/tables_structure.dart';
import 'package:flow_accounting/utils/extensions/Random.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  PrototypeData().generate();

}

class PrototypeData {

  List<Color> listOfColors = [
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.blueGrey,
    Colors.deepOrange,
    Colors.blue,
    Colors.yellowAccent,
    Colors.cyan,
    Colors.redAccent,
    Colors.lightGreenAccent,
    Colors.indigoAccent,
    Colors.red.shade700,
    Colors.green,
    Colors.deepPurple,
    Colors.greenAccent
  ];

  List<String> customersList = [
    "دانیال",
    "آبان",
    "الیاس",
    "پویا",
    "فاضل",
    "شرکت آبان",
    "عطیه",
    "امی"
  ];

  void generate() {

    prepareCreditCardsData();

    // prepareBudgetsData();

    // prepareCustomersData();

    // prepareTransactionsData();

  }

  void prepareCreditCardsData() async {

    CreditCardsDatabaseInputs creditCardsDatabaseInputs = CreditCardsDatabaseInputs();

    List<CreditCardsData> creditCardsData = [];

    creditCardsData.add(CreditCardsData(
        id: DateTime.now().millisecondsSinceEpoch + 1,
        cardNumber: "6274121200641696",
        cardExpiry: "11/22",
        cardHolderName: "دانیال راد",
        cvv: "179",
        bankName: "اقتصاد نوین",
        cardBalance: "1000000",
        colorTag: listOfColors.randomItem().value
    ));

    creditCardsData.add(CreditCardsData(
        id: DateTime.now().millisecondsSinceEpoch + 2,
        cardNumber: "5274331211991147",
        cardExpiry: "31/12",
        cardHolderName: "دانیال راد",
        cvv: "389",
        bankName: "صادرات",
        cardBalance: "2300000",
        colorTag: listOfColors.randomItem().value
    ));

    for (var element in creditCardsData) {

      creditCardsDatabaseInputs.insertCreditCardsData(element, CreditCardsDatabaseInputs.databaseTableName);

    }

    debugPrint("Credit Cards Created");

    prepareBudgetsData();

  }

  void prepareBudgetsData() async {

    BudgetsDatabaseInputs budgetsDatabaseInputs = BudgetsDatabaseInputs();

    List<BudgetsData> budgetsData = [];

    budgetsData.add(BudgetsData(
        id: DateTime.now().millisecondsSinceEpoch + 1,
        budgetName: "شرکت نرم افزاری آبان",
        budgetDescription: "بودجه مخارج کلی شرکت نرم افزاری آبان",
        budgetBalance: "50000000",
        colorTag: listOfColors.randomItem().value
    ));

    budgetsData.add(BudgetsData(
        id: DateTime.now().millisecondsSinceEpoch + 2,
        budgetName: "گربه",
        budgetDescription: "مخارج شدو",
        budgetBalance: "1000000",
        colorTag: listOfColors.randomItem().value
    ));

    budgetsData.add(BudgetsData(
        id: DateTime.now().millisecondsSinceEpoch + 3,
        budgetName: "آکواریوم",
        budgetDescription: "بودجه آکواریوم نیون",
        budgetBalance: "370000",
        colorTag: listOfColors.randomItem().value
    ));

    for (var element in budgetsData) {

      budgetsDatabaseInputs.insertBudgetData(element, BudgetsDatabaseInputs.databaseTableName);

    }

    debugPrint("Budgets Created");

    prepareCustomersData();

  }

  void prepareCustomersData() async {

    CustomersDatabaseInputs customersDatabaseInputs = CustomersDatabaseInputs();

    List<CustomersData> customersData = [];

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch + 1,
      customerName: "دانیال راد",
      customerDescription: "خریدار موبایل",
      customerCountry: "ایران",
      customerCity: "مشهد",
      customerStreetAddress: "احمد آباد",
      customerPhoneNumber: "09334569871",
      customerEmailAddress: "Daniel@gmail.com",
      customerAge: "31",
      customerBirthday: "شنبه ۱۲ فروردین ۱۳۶۸",
      customerJob: "برنامه نویس",
      customerMaritalStatus: "مجرد",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch + 2,
      customerName: "شلدون",
      customerDescription: "نرد اسکول",
      customerCountry: "خارج",
      customerCity: "پسدینا",
      customerStreetAddress: "کنار نونوایی",
      customerPhoneNumber: "01245487",
      customerEmailAddress: "sheldon@bezinga.biz",
      customerAge: "37",
      customerBirthday: "شنبه ۱۲ فروردین ۱۳۶۸",
      customerJob: "فیزیک دان",
      customerMaritalStatus: "متاهل",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    for (var element in customersData) {

      customersDatabaseInputs.insertCustomerData(element, CustomersDatabaseInputs.databaseTableName);

    }

    debugPrint("Customers Created");

    Future.delayed(const Duration(milliseconds: 799), () {

     prepareTransactionsData();

    });

  }

  void prepareTransactionsData() async {

    TransactionsDatabaseInputs transactionsDatabaseInputs = TransactionsDatabaseInputs();

    List<TransactionsData> transactionsData = [];

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 1,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "9735900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 12.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 2,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6274191200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "3590",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 12.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "آکواریوم"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 3,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "6274121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "71590",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "گربه"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 4,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "6274121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1590",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "گربه"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 5,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1735900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 1.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 6,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6274121200641686",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "4590",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 1.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "گربه"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 7,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "6274121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "735900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 5.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 8,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "9735900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 8.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 9,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "6274121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "9735900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 8.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 10,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1115900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 11,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "9735900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 12,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "35900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch + 13,
        transactionTitle: "عنوانی برای تراکنش",
        transactionDescription: "توضیحات تراکنش",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "6274121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "5535900",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    for (var element in transactionsData) {

      transactionsDatabaseInputs.insertTransactionData(element, TransactionsDatabaseInputs.databaseTableName);

    }

    debugPrint("Transactions Created");

  }

  String _generateDateText() {

    Gregorian gregorianCalendarOne = Gregorian(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute, 0, 0);
    var iranianCalendarOne = gregorianCalendarOne.toJalali();

    String yearNumberOne = iranianCalendarOne.formatter.yyyy.toString();
    String dayNumberOne = iranianCalendarOne.formatter.dd.toString();

    String weekdayNameOne = iranianCalendarOne.formatter.wN.toString();
    String monthNameOne = iranianCalendarOne.formatter.mN.toString();

    return "" +
        weekdayNameOne + " " +
        dayNumberOne + " " +
        monthNameOne + " " +
        yearNumberOne +
        "\n"
            "ساعت" + " " +
        "${iranianCalendarOne.hour}:${iranianCalendarOne.minute}";
  }

}