import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:p2Endure/core/models/kpi.dart';
import 'package:p2Endure/core/services/databaseService.dart';
import 'package:p2Endure/core/services/roomService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class RoomViewModel extends BaseModel {
  final _databaseService = locator<DatabaseService>();

  final _roomService = locator<RoomService>();

  set key(String value) => _roomService.key = value;

  List<Series> _graphData;

  List<Series> get graphData => _graphData;

  //? si possono importare i colori nel modello
  void setKpis(List<Kpi> data) async {
    _graphData = [
      Series<Kpi, double>(
          id: "CO2",
          colorFn: (value, _) => ColorUtil.fromDartColor(value.color),
          domainFn: (value, _) => value.value,
          measureFn: (value, _) => value.value,
          data: data,
          labelAccessorFn: (value, _) => value.label)
    ];

    notifyListeners();
  }

  void getData() => _roomService.setSelectedData();
}
