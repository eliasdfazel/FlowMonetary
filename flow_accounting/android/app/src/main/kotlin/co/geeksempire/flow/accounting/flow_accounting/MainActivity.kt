/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 7:48 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

package co.geeksempire.flow.accounting.flow_accounting

import android.os.Bundle
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity

class MainActivity: /*FlutterFragmentActivity*/FlutterActivity() {
    override fun onCreate(bundle: Bundle?) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.onCreate(bundle)
    }
}
