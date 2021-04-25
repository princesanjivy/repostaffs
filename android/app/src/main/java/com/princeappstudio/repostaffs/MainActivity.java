package com.princeappstudio.repostaffs;

import android.app.Activity;
import android.content.ContentResolver;
import android.content.Intent;
import android.net.Uri;
import android.os.ParcelFileDescriptor;

import androidx.annotation.NonNull;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.princeappstudio.repostaffs/save";
    public static final int CREATE_FILE_REQUEST_CODE = 3517;
    private MethodChannel.Result myResult;
    public byte[] bytes;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (call, result) -> {
                    myResult = result;
                    
                    if (call.method.equals("excel")) {
                        createFile(call.argument("bytes"), call.argument("name"));
                    } else {
                        result.notImplemented();
                    }
                }
        );
    }

    private void createFile(byte[] bytes, String name) {
        this.bytes = bytes;
        Intent intent = new Intent(Intent.ACTION_CREATE_DOCUMENT);

        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        intent.putExtra(Intent.EXTRA_TITLE, name+".xlsx");
        startActivityForResult(intent, CREATE_FILE_REQUEST_CODE);
    }

    private void writeFile(Uri uri) {

        try {
            ParcelFileDescriptor parcelFileDescriptor = this.getContentResolver().openFileDescriptor(uri, "w");

            FileOutputStream fileOutputStream = new FileOutputStream(parcelFileDescriptor.getFileDescriptor());
            fileOutputStream.write(this.bytes);

            fileOutputStream.close();
            parcelFileDescriptor.close();

            myResult.success("File saved!");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == CREATE_FILE_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            if (data != null) {
                writeFile(data.getData());
            }
        }
    }
}
