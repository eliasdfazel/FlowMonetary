/*
 * Copyright © 2022 By Geeks Empire.
 *
 * Created by Elias Fazel
 * Last modified 4/7/22, 4:49 AM
 *
 * Licensed Under MIT License.
 * https://opensource.org/licenses/MIT
 */

package co.geeksempire.flow.accounting.flow_accounting

import android.os.Bundle
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity () {
    override fun onCreate(bundle: Bundle?) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.onCreate(bundle)
    }
}
