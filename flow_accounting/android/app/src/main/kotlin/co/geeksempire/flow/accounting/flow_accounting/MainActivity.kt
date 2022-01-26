package co.geeksempire.flow.accounting.flow_accounting

import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.os.Bundle;

class MainActivity: FlutterActivity() {
    override fun onCreate(bundle: Bundle?) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.onCreate(bundle)
    }
}
