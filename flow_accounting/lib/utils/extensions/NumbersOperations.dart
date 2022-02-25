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