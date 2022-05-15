/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 1/27/22, 7:30 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

String prepareCreditCard(String inputCreditCardNumber) {

  String creditCardNumber = inputCreditCardNumber;

  if (inputCreditCardNumber.length == 16) {

    creditCardNumber = "${inputCreditCardNumber.substring(0, 4)}" " - "
        "${inputCreditCardNumber.substring(4, 8)}" " - "
        "${inputCreditCardNumber.substring(8, 12)}" " - "
        "${inputCreditCardNumber.substring(12, 16)}";

  }

  return creditCardNumber;
}