/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/22/22, 6:00 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/credit_cards/database/io/inputs.dart';
import 'package:flow_accounting/credit_cards/database/structures/tables_structure.dart';

class PrototypeData {

  void generate() {

    prepareCreditCardsData();

  }

  void prepareCreditCardsData() async {

    CreditCardsDatabaseInputs creditCardsDatabaseInputs = CreditCardsDatabaseInputs();

    CreditCardsData creditCardsData = CreditCardsData(
        id: DateTime.now().millisecondsSinceEpoch,
        cardNumber: "6274121200641696",
        cardExpiry: cardExpiry,
        cardHolderName: cardHolderName,
        cvv: cvv,
        bankName: bankName,
        cardBalance: cardBalance,
        colorTag: colorTag
    );

    creditCardsDatabaseInputs.insertCreditCardsData(creditCardsData, CreditCardsDatabaseInputs.databaseTableName);

    prepareBudgetsData();

  }

  void prepareBudgetsData() async {



    prepareCustomersData();

  }

  void prepareCustomersData() async {



    prepareTransactionsData();

  }

  void prepareTransactionsData() async {



  }

}