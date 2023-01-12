package rikkei.com.e.lms.elearning;

import io.flutter.embedding.android.FlutterActivity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;

import java.lang.reflect.Method;
import java.util.Objects;
import java.util.Set;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String TAG = "rikkei.com.e.lms.elearning";
    private static final String METHOD_CHANNEL = "E_LEARNING_CHANNEL";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d(TAG, "onCreate !!!");
        super.onCreate(savedInstanceState);
        methodChannelListener();
    }

    private void methodChannelListener() {
        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor(), METHOD_CHANNEL).setMethodCallHandler((call, result) -> {
            // check call method is getKeyApplication => value of BuildConfig.SMA_CHARI_ENCRYPT_KEY
            if (call.method.equals("getKeyApplication")) {
                result.success(BuildConfig.SMA_CHARI_ENCRYPT_KEY);
            }
            rikkei.elearning.method_channel.MethodChannelZipArchive.getInstance().callMethod(call, result);
        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.d(TAG, "onStart !!!");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "onDestroy!!!");
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }
}
