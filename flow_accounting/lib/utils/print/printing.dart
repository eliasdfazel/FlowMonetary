/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 3/30/22, 3:41 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

import 'package:share_plus/share_plus.dart';

class PrintingProcess {

  void start(String filePath, {String? sharingLabel}) {

    Share.shareFiles([filePath],
        text: "${sharingLabel}");

  }

}