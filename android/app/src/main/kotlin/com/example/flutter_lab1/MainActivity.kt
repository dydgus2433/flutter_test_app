package com.example.flutter_lab1

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //test1.................
        val channel = BasicMessageChannel<String>(flutterEngine.dartExecutor,"myMessageChannel",
            StringCodec.INSTANCE )
        channel.setMessageHandler { message, reply ->
            Log.d("msg", "receive: $message")
            reply.reply("reply from Android")
            channel.send("Hello, i am platform message"){replay ->
                Log.d("msg", "reply : $replay")
            }
        }

        //test2........................
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "myMethodChannel")
            .setMethodCallHandler { call, result ->
                io.flutter.Log.d("flutter", call.toString())
                if (call.method == "parameterMap") {
//                Log.d("flutter", "${call.argument<String>("Username")}")
                    val map = call.arguments as Map<String, String>
                    io.flutter.Log.d("flutter", "${map.get("Username")}, ${map.get("Password")}")
                    result.success(mapOf("one" to 10, "two" to 20))
                } else {
                    result.notImplemented()
                }
            }

        //test2... event channel.........
        val eventChannel = EventChannel(flutterEngine.dartExecutor, "eventChannel");

        eventChannel.setStreamHandler( object : EventChannel.StreamHandler {
            override fun onListen(p0: Any?, p1: EventChannel.EventSink?) {
                io.flutter.Log.d("platform", "onListen.......")
                p1?.success("send event data..from native..")
            }
            override fun onCancel(p0: Any?) {

            }
        })
    }
}

