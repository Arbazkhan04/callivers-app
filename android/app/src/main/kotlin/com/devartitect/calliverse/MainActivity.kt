package com.devartitect.calliverse

import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "screen_capture_service"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startForegroundService" -> {
                    startScreenCaptureService()
                    result.success(null)
                }
                "stopForegroundService" -> {
                    stopScreenCaptureService()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startScreenCaptureService() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val serviceIntent = Intent(this, ScreenCaptureService::class.java)
            startForegroundService(serviceIntent)
        } else {
            val serviceIntent = Intent(this, ScreenCaptureService::class.java)
            startService(serviceIntent)
        }
    }

    private fun stopScreenCaptureService() {
        val serviceIntent = Intent(this, ScreenCaptureService::class.java)
        stopService(serviceIntent)
    }
}
