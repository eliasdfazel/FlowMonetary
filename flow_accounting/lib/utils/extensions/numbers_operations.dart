/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 2/25/22, 4:24 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

double betweenZeroHundred(double maximumNumber, double inputNumber) {

  int length = maximumNumber.toString().split(".")[0].length;

  String divideNumberText = "1";

  for (int i = 1; i < (length - 1); i++) {

    divideNumberText += "0";

  }

  int divideNumber = int.parse(divideNumberText);

  double maximumResult = maximumNumber / divideNumber;

  double result = inputNumber / divideNumber;

  return result;
}

String formatNumberToCurrency(String inputNumber) {
  print("Input Number To Format: ${inputNumber}");

  StringBuffer formattedNumber = StringBuffer("");

  if (inputNumber.length % 3 == 0) {

    formattedNumber = StringBuffer("");

    int divideAmount = inputNumber.length ~/ 3;

    int loopCounter = 1;

    for (int i = 0; i < (inputNumber.length); i += 3) {

      String selectedNumber = inputNumber.substring(i, i + 3);

      formattedNumber.write("${selectedNumber}");

      if (loopCounter < divideAmount) {

        formattedNumber.write(",");

      }

      loopCounter++;

    }

  } else {

    formattedNumber = StringBuffer("");

    for (int i = 1; i <= 2; i++) {

      String inputNumberExamination = inputNumber.substring(i, inputNumber.length);

      if (inputNumberExamination.length % 3 == 0) {

        String firstValues = inputNumber.replaceAll(inputNumberExamination, "");

        print(firstValues);

        formattedNumber.write("${firstValues},");

        int divideAmount = inputNumberExamination.length ~/ 3;

        int loopCounter = 1;

        for (int i = 0; i < (inputNumberExamination.length); i += 3) {

          String selectedNumber = inputNumberExamination.substring(i, i + 3);

          formattedNumber.write("${selectedNumber}");

          if (loopCounter < divideAmount) {

            formattedNumber.write(",");

          }

          loopCounter++;

        }

        break;
      }

    }

  }

  return formattedNumber.toString().isEmpty ? inputNumber : formattedNumber.toString();
}