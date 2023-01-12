package rikkei.elearning.method_channel;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.util.Zip4jConstants;

import java.io.File;
import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MethodChannelZipArchive {
    private static volatile MethodChannelZipArchive sInstance;

    MethodChannelZipArchive(){}

    public static MethodChannelZipArchive getInstance() {
        if (sInstance == null) {
            sInstance = new MethodChannelZipArchive();
        }
        return sInstance;
    }

    public void callMethod(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "zip":
                zip(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void zip(MethodCall call, MethodChannel.Result result) {
        ArrayList<String> src = call.argument("src");
        String dest = call.argument("dest");
        String pass = call.argument("pass");
        boolean isZip = zip(src, dest, pass);
        result.success(isZip);
    }

    private boolean zip(ArrayList<String> src, String dest, String pass) {
        ZipParameters parameters = new ZipParameters();
        parameters.setCompressionMethod(Zip4jConstants.COMP_DEFLATE);
        parameters.setCompressionLevel(Zip4jConstants.DEFLATE_LEVEL_NORMAL);
        if (pass != null && !pass.isEmpty()) {
            parameters.setEncryptFiles(true);
            parameters.setEncryptionMethod(Zip4jConstants.ENC_METHOD_STANDARD);
            parameters.setAesKeyStrength(Zip4jConstants.AES_STRENGTH_256);
            parameters.setPassword(pass);
        }
        try {
            ZipFile zipFile = new ZipFile(dest);
            int srcSize = src.size();
            if (srcSize == 0) {
                return false;
            }
            ArrayList<File> srcFileTemp = new ArrayList<>();
            for (int i = 0; i < srcSize; i++) {
                File srcFile = new File(src.get(i));
                if (srcFile.isFile()) {
                    srcFileTemp.add(srcFile);
                }
            }
            if (srcFileTemp.size() > 0) {
                zipFile.addFiles(srcFileTemp, parameters);
            } else {
                return false;
            }
            return true;
        } catch (ZipException e) {
            e.printStackTrace();
        }
        return false;
    }
}
