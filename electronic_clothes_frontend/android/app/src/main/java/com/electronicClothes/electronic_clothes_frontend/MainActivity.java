package com.electronicClothes.electronic_clothes_frontend;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.nfc.NfcAdapter;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.electronicClothes.soulious/nfc";
    
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("getNfcData")) {
                        String nfcData = handleNfcIntent(getIntent());
                        result.success(nfcData);
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        String nfcData = handleNfcIntent(intent);
        MethodChannel channel = new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL);
        channel.invokeMethod("onNfcData", nfcData);
    }

    private String handleNfcIntent(Intent intent) {
        if (NfcAdapter.ACTION_NDEF_DISCOVERED.equals(intent.getAction())) {
            Uri uri = intent.getData();
            return uri.toString();
        }
        // Handle cases where the action is not ACTION_NDEF_DISCOVERED
        return "Error: Invalid NFC action";
    }
}
