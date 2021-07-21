package com.example.netflix

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundExecutor.setPluginRegistrant
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService.setPluginRegistrant
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingService
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin


class MyApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
//        createChannel()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }



    private fun createChannel(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // Create the NotificationChannel
            val name = getString(R.string.default_notification_channel_id)
            val channel = NotificationChannel(name, "DUNGTP", NotificationManager.IMPORTANCE_HIGH)
            val notificationManager: NotificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

}
