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
import 'package:flow_accounting/profile/database/io/queries.dart';
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
    "دانیال راد",
    "آرش مرادی",
    "مریم عسگری",
    "مرضیه یاسایی",
    "نیما کشاورز",
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
        cardNumber: "6037997111991147",
        cardExpiry: "10/12",
        cardHolderName: "دانیال راد",
        cvv: "389",
        bankName: "ملی",
        cardBalance: "2300000",
        colorTag: listOfColors.randomItem().value
    ));

    creditCardsData.add(CreditCardsData(
        id: DateTime.now().millisecondsSinceEpoch + 3,
        cardNumber: "5022291011998586",
        cardExpiry: "05/01",
        cardHolderName: " دانیال راد",
        cvv: "686",
        bankName: "پاسارگاد",
        cardBalance: "3100000",
        colorTag: listOfColors.randomItem().value
    ));

    for (var element in creditCardsData) {

      creditCardsDatabaseInputs.insertCreditCardsData(element, CreditCardsDatabaseInputs.databaseTableName, UserInformation.UserId);

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
        budgetName: "شرکت نرم افزاری سفید",
        budgetDescription: " بودجه حقوق سالیانه کارآموزان",
        budgetBalance: "50000000",
        colorTag: listOfColors.randomItem().value
    ));

    budgetsData.add(BudgetsData(
        id: DateTime.now().millisecondsSinceEpoch + 3,
        budgetName: "شرکت نرم افزاری سداد",
        budgetDescription: "بودجه تهیه سیستم های نرم افزاری",
        budgetBalance: "60000000",
        colorTag: listOfColors.randomItem().value
    ));

    budgetsData.add(BudgetsData(
        id: DateTime.now().millisecondsSinceEpoch + 3,
        budgetName: "شرکت ثبت برند ملاصدرا",
        budgetDescription: "بودجه ثبت برند ",
        budgetBalance: "7000000",
        colorTag: listOfColors.randomItem().value
    ));

    budgetsData.add(BudgetsData(
        id: DateTime.now().millisecondsSinceEpoch + 3,
        budgetName: "شرکت تبلیغاتی رهام",
        budgetDescription: "بودجه تبلیغات",
        budgetBalance: "27000000",
        colorTag: listOfColors.randomItem().value
    ));

    for (var element in budgetsData) {

      budgetsDatabaseInputs.insertBudgetData(element, BudgetsDatabaseInputs.databaseTableName, UserInformation.UserId);

    }

    debugPrint("Budgets Created");

    prepareCustomersData();

  }

  void prepareCustomersData() async {

    CustomersDatabaseInputs customersDatabaseInputs = CustomersDatabaseInputs();

    List<CustomersData> customersData = [];

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch,
      customerName: "دانیال راد",
      customerDescription: "خریدار موبایل",
      customerCountry: "ایران",
      customerCity: "مشهد",
      customerStreetAddress: "احمد آباد",
      customerPhoneNumber: "09334569871",
      customerEmailAddress: "Daniel@gmail.com",
      customerAge: "31",
      customerBirthday: "1368/01/12",
      customerJob: "برنامه نویس",
      customerMaritalStatus: "مجرد",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch + 1,
      customerName: "آرش مرادی",
      customerDescription: " تولید محتوا",
      customerCountry: "ایران",
      customerCity: "تهران",
      customerStreetAddress: "یوسف آباد",
      customerPhoneNumber: "09386561412",
      customerEmailAddress: "َArash.Moradi@yahoo.com",
      customerAge: "37",
      customerBirthday: " 1363/05/16 ",
      customerJob: "فیزیک دان",
      customerMaritalStatus: "متاهل",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch + 1,
      customerName: "مریم عسگری",
      customerDescription: "مدیریت مالی ",
      customerCountry: "ایران",
      customerCity: "تهران",
      customerStreetAddress: "پاسداران ",
      customerPhoneNumber: "09126563484",
      customerEmailAddress: "Maryam12asgari@Gmail.com",
      customerAge: "29",
      customerBirthday: " 1371/09/28 ",
      customerJob: " کارمند بانک",
      customerMaritalStatus: "محرد",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch + 1,
      customerName: " مرضیه یاسایی",
      customerDescription: "مدیریت پروژه",
      customerCountry: "ایران",
      customerCity: "کرج",
      customerStreetAddress: " عظیمیه",
      customerPhoneNumber: "09196789663",
      customerEmailAddress: "Marziyeyasaei97@Gmail.com",
      customerAge: "31",
      customerBirthday: " 1369/11/08 ",
      customerJob: " برنامه نویس",
      customerMaritalStatus: "متاهل",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    customersData.add(CustomersData(
      id: DateTime.now().millisecondsSinceEpoch + 1,
      customerName: "نیما کشاورز",
      customerDescription: "تبلیغات ",
      customerCountry: "ایران",
      customerCity: "تهران",
      customerStreetAddress: " سعادت آباد",
      customerPhoneNumber: "09124587661",
      customerEmailAddress: ".Moradi@yahoo.com",
      customerAge: "33",
      customerBirthday: " 1367/10/12 ",
      customerJob: " دیجیتال مارکتینگ",
      customerMaritalStatus: "مجرد",
      customerImagePath: "/data/user/0/co.geeksempire.flow.accounting.flow_accounting/files/image_picker1337937822812840444.jpg",
      colorTag: listOfColors.randomItem().value,
    ));

    for (var element in customersData) {

      customersDatabaseInputs.insertCustomerData(element, CustomersDatabaseInputs.databaseTableName, UserInformation.UserId);

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
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: "  کارت به کارت",
        transactionDescription: " پرداخت حقوق ماه اول",
        sourceCardNumber: "6221061211621294",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1500000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 12.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: "حقوق کارآموزان",
        sourceCardNumber: "6037997111991147",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "2300000",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 12.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری سفید"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: "کارت به کارت",
        transactionDescription: " هزینه تهیه نرم افزار",
        sourceCardNumber: "5022291011998586",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "5300000",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری سداد"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: "کارت به کارت",
        transactionDescription: "حقوق کارآموزان ",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "6274121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1630000",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری سفید"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: "کارت به کارت ",
        transactionDescription: "ثبت برند شرکت - ماه اول",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "5022291011998586",
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
        budgetName: "شرکت ثبت برند ملاصدرا "
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: " هزینه تبلیغات - ماه اول",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "2600000",
        transactionType: TransactionsData.TransactionType_Send,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 1.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت تبلیغاتی رهام"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: "پرداخت حقوق ماه دوم",
        sourceCardNumber: "6221061211621294",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1500000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 5.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: "پرداخت حقوق ماه سوم",
        sourceCardNumber: "6221061211621294",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "1500000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 8.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت نرم افزاری آبان"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: "کارت به کارت",
        transactionDescription: " ثبت برند شرکت - ماه دوم",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "5022291011998586",
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
        budgetName: " شزکت ثبت برند ملاصدرا"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: "کارت به کارت",
        transactionDescription: " هزینه تبلیغات - ماه دوم",
        sourceCardNumber: "6276339200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "2900000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت تبلیغاتی رهام"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: " خرید نرم افزار",
        sourceCardNumber: "5892101200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "4630000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: " شرکت نرم افزاری سفید"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: " هزینه تبلیغات - ماه سوم",
        sourceCardNumber: "6274121200641696",
        targetCardNumber: "6666121200641696",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "2600000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت تبلیغاتی رهام"
    ));

    transactionsData.add(TransactionsData(
        id: DateTime.now().millisecondsSinceEpoch,
        transactionTitle: " کارت به کارت",
        transactionDescription: "ثبت برند شرکت - ماه سوم",
        sourceCardNumber: "5274331211991147",
        targetCardNumber: "5022291011998586",
        sourceBankName: StringsResources.listOfBanksIran.randomItem(),
        targetBankName: StringsResources.listOfBanksIran.randomItem(),
        sourceUsername: customersList.randomItem(),
        targetUsername: customersList.randomItem(),
        amountMoney: "5590000",
        transactionType: TransactionsData.TransactionType_Receive,
        transactionTimeMillisecond: DateTime.now().millisecondsSinceEpoch,
        transactionTime: _generateDateText(),
        transactionTimeYear: "1400",
        transactionTimeMonth: 7.toString(),
        colorTag: listOfColors.randomItem().value,
        budgetName: "شرکت ثبت برند ملاصدرا"
    ));

    for (var element in transactionsData) {

      transactionsDatabaseInputs.insertTransactionData(element, TransactionsDatabaseInputs.databaseTableName, UserInformation.UserId);

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