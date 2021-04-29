import 'package:flutter_blue/flutter_blue.dart';

class BleService {
  BleService() {
    scan();
  }

  final _bluetooth = FlutterBlue.instance;

  Stream get devices => _bluetooth.scanResults;

  BluetoothDevice device;

  void scan() async {
    try {
      await _bluetooth.startScan(timeout: Duration(seconds: 3));
    } catch (e) {
      print(e);
    }
  }

  Future<List<BluetoothService>> connect() async {
    await device.connect();
    return device.discoverServices();
  }

  Future disconnect() => device.disconnect();
}
