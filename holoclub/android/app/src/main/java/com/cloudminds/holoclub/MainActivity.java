package com.cloudminds.holoclub;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/getMovieList";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if (methodCall.method.equals("getMovieList")) {
                            result.success(" onMethodCall  MethodChannel   success ");
                        }else {
                            result.error("No such method","Method not found","Method name is getMovieList");
                        }
                    }

                });

        GeneratedPluginRegistrant.registerWith(this);
    }
}
