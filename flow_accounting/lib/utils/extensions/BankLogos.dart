/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/21/22, 7:38 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:flow_accounting/resources/StringsResources.dart';

String generateBankLogoUrl(String bankLogoFileName) {

  String logoFileName = "Other_Banks.png";

  if (StringsResources.mapBanksIranLogo().keys.contains(bankLogoFileName)) {

    logoFileName = StringsResources.mapBanksIranLogo()[bankLogoFileName].toString();

  }

  return "https://myhousestore.ir/wp-content/uploads/2022/02/${logoFileName}";
}