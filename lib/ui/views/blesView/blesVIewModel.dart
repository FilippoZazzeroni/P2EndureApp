import 'package:flutter_blue/flutter_blue.dart';
import 'package:p2Endure/core/services/bleService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class BlesViewModel extends BaseModel {
  final _bleService = locator<BleService>();

  Stream<List<ScanResult>> get devices => _bleService.devices;

  void scan() => _bleService.scan();
}
