package ru.mso7nueh.promenade

import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("a48d9b9b-fce6-49dd-b653-debce01201d3")
        super.configureFlutterEngine(flutterEngine)
    }
}