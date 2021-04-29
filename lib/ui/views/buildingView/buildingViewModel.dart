import 'package:p2Endure/core/models/room.dart';
import 'package:p2Endure/core/services/buildingsService.dart';
import 'package:p2Endure/core/services/databaseService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class BuildingViewModel extends BaseModel {
  final _buildingsService = locator<BuildingsService>();

  String key;

  List<Room> get rooms => _buildingsService.getRooms(key);
}
