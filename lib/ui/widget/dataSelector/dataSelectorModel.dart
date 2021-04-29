import 'package:p2Endure/core/services/roomService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class DataSelectorModel extends BaseModel {
  final _roomService = locator<RoomService>();

  String get selectedData => _roomService.selectedData;

  List get data => _roomService.selectorData;

  void setSelectedData(String value) {
    _roomService.method = value;

    notifyListeners();

    popView();
  }
}
