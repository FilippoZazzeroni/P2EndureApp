import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:p2Endure/core/services/bleService.dart';
import 'package:p2Endure/core/services/configService.dart';
import 'package:p2Endure/core/services/mqttService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class ConfigViewModel extends BaseModel {
  ConfigViewModel() {
    _handleMqttMessage();
  }

  final _bluetoothService = locator<BleService>();

  final _configService = locator<ConfigService>();

  final _mqttService = locator<MqttService>();

  set device(ScanResult device) {
    _bluetoothService.device = device.device;
    if (device.device.name == "Comfort Eye")
      _mqttService.subscribeToTopics(
          "p2endure/menden/building/room/ce/mence01/mobileStatus");
    else {
      _mqttService.subscribeToTopics(
          "p2endure/menden/building/room/ca/menca01/mobileStatus");
      _isCa = true;
      notifyListeners();
    }
  }

  bool _isCa = false;

  bool get isCa => _isCa;

  BluetoothCharacteristic _char;

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  bool _isWifiConnected = false;

  bool get isWifiConnected => _isWifiConnected;

  void _handleMqttMessage() {
    _mqttService.data.listen((event) {
      event.forEach((element) {
        final val = utf8
            .decode((element.payload as MqttPublishMessage).payload.message);
        final status = json.decode(val);
        print(status);
        if (status["status"] == "true") {
          _isWifiConnected = true;
          notifyListeners();
        }
      });
    });
  }

  void _getState() async {
    final val = utf8.decode(await _char.read());
    if (val.contains("Connected")) _isConnected = true;
    notifyListeners();
  }

  void connect() async {
    final services = await _bluetoothService.connect();
    services.forEach((element) {
      element.characteristics.forEach((element) {
        if (element.uuid.toMac().contains("36:35:34:33:32:31")) _char = element;
      });
    });

    _getState();
  }

  void write() async {
    for (var i in _configService.config.keys) {
      await _char.write(utf8.encode(
          "${_configService.config[i][0]}/${_configService.config[i][1]}"));
    }
  }

  void disconnect() async {
    _mqttService.unsubscribeTopics();
    await _bluetoothService.disconnect();
    popView();
  }

  void calibrateSensor() {
    final data = jsonEncode({"mode": "Calibration"});
    _mqttService.publish(data, "p2endure/menden/building/room/ca/menca01/mode");
  }
}
