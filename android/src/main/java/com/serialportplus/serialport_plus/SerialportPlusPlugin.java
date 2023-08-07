package com.serialportplus.serialport_plus;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;
import android.util.Log;
import java.io.IOException;
import java.io.File;
import android.serialport.SerialPort;
import android.serialport.SerialPortFinder;
import java.lang.Thread;
import java.io.InputStream;
import java.io.OutputStream;
import android.os.Handler;
import java.util.Arrays;
import java.util.ArrayList;
import android.os.Looper;
/** SerialportPlusPlugin */
public class SerialportPlusPlugin implements FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static final String TAG = "SerialportPlusPlugin";
  private MethodChannel channel;
  private SerialPortFinder mSerialPortFinder = new SerialPortFinder();
  protected SerialPort mSerialPort;
  protected OutputStream mOutputStream;
  private InputStream mInputStream;
  private ReadThread mReadThread;
  private EventChannel.EventSink mEventSink;
  private Handler mHandler = new Handler(Looper.getMainLooper());;

  private class ReadThread extends Thread {
    @Override
    public void run() {
      super.run();
      while (!isInterrupted()) {
        int size;
        try {
          byte[] buffer = new byte[64];
          if (mInputStream == null)
            return;
          size = mInputStream.read(buffer);
          // Log.d(TAG, "read size: " + String.valueOf(size));
          if (size > 0) {
            onDataReceived(buffer, size);
          }
        } catch (IOException e) {
          e.printStackTrace();
          return;
        }
      }
    }
  }

  protected void onDataReceived(final byte[] buffer, final int size) {
    if (mEventSink != null) {
      mHandler.post(new Runnable() {
        @Override
        public void run() {
          // Log.d(TAG, "eventsink: " + buffer.toString());
          mEventSink.success(Arrays.copyOfRange(buffer, 0, size));
        }
      });
    }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "serialport_plus");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if(call.method.equals("open")) {
        final String devicePath = call.argument("devicePath");
        final int baudrate = call.argument("baudrate");
        final int dataBits = call.argument("dataBits"); 
        final int parity = call.argument("parity"); 
        final int stopBits = call.argument("stopBits");
        Log.d(TAG, "Open " + devicePath + ", baudrate: " + baudrate);
        Boolean openResult = openDevice(devicePath, baudrate, dataBits, parity, stopBits);
        result.success(openResult);
    } else if(call.method.equals("close")){
        Boolean closeResult = closeDevice();
        result.success(closeResult);
    }else if(call.method.equals("write")){
        writeData((byte[]) call.argument("data"));
        result.success(true);
    }else if(call.method.equals("getAllDevices")){
        ArrayList<String> devices = getAllDevices();
        Log.d(TAG, devices.toString());
        result.success(devices);
    }else if(call.method.equals("getAllDevicesPath")){
        ArrayList<String> devicesPath = getAllDevicesPath();
        Log.d(TAG, devicesPath.toString());
        result.success(devicesPath);
    }else if(call.method.equals("read")){
        ArrayList<String> devicesPath = 
        Log.d(TAG, devicesPath.toString());
        result.success(devicesPath);
    }else{
        result.notImplemented();
    }
  }
  @Override
  public void onListen(Object o, EventChannel.EventSink eventSink) {
    mEventSink = eventSink;
  }

  @Override
  public void onCancel(Object o) {
    mEventSink = null;
  }

  private ArrayList<String> getAllDevices() {
    ArrayList<String> devices = new ArrayList<String>(Arrays.asList(mSerialPortFinder.getAllDevices()));
    return devices;
  }

  private ArrayList<String> getAllDevicesPath() {
    ArrayList<String> devicesPath = new ArrayList<String>(Arrays.asList(mSerialPortFinder.getAllDevicesPath()));
    return devicesPath;
  }

  private Boolean openDevice(String devicePath, int baudrate, int dataBits, int parity, int stopBits) {
    if (mSerialPort == null) {
      /* Check parameters */
      if ((devicePath.length() == 0) || (baudrate == -1)) {
        return false;
      }

      /* Open the serial port */
      try {
        mSerialPort = new SerialPort(new File(devicePath), baudrate, dataBits, parity , stopBits);
        mOutputStream = mSerialPort.getOutputStream();
        mInputStream = mSerialPort.getInputStream();
        mReadThread = new ReadThread();
        mReadThread.start();
        return true;
      } catch (Exception e) {
        Log.e(TAG, e.toString());
        return false;
      }
    }
    return false;
  }

  private Boolean closeDevice() {
    try {
      if (mSerialPort != null) {
        mSerialPort.close();
        mSerialPort = null;
        return true;
      }
      return false;
    } catch (Exception e) {
      Log.e(TAG, "write data exception");
      Log.e(TAG, e.toString());
      return false;
    }
  }

  private void writeData(byte[] data) {
    try {
       mOutputStream.write(data);
       //mOutputStream.write('\n');
    } catch (IOException e) {
      Log.e(TAG, "write data exception");
      Log.e(TAG, e.toString());
    }
  }

  private void read(byte[] data) {
    try {
       mInputStream.read();
    } catch (IOException e) {
      Log.e(TAG, "read data exception");
      Log.e(TAG, e.toString());
    }
  }
  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
