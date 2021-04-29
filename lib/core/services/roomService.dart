import 'package:flutter/material.dart';
import 'package:p2Endure/core/models/kpi.dart';
import 'package:p2Endure/core/services/databaseService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/views/roomView/roomViewModel.dart';

class RoomService {
  final _databaseService = locator<DatabaseService>();
  //! name, method, active
  final selectorData = [
    ["Thermal raw data", "thermalData", false],
    ["Thermal kpi", "tclKpi", true],
    ["Iaq raw data", "iaqData", false],
    ["Iaq kpi", "calKpi", false]
  ];
  //? si puo ?
  List get _pieColors =>
      [Colors.red, Colors.yellow, Colors.green, PColors.lightBlue];

  String _key;

  ///actual key of the room
  set key(String value) => _key = value;

  ///actual key of the room
  set method(String value) {
    selectorData.forEach((element) {
      if (element[0] == value)
        element[2] = true;
      else
        element[2] = false;
    });
  }

  String get _method =>
      (selectorData.where((element) => element[2]).toList()[0][1]) as String;

  String _dateStart;

  set dateStart(String value) => _dateStart = value;

  String _dateEnd;

  set dateEnd(String value) => _dateEnd = value;

  String get selectedData =>
      (selectorData.where((element) => element[2]).toList()[0][0]) as String;

  void setSelectedData() async {
    final roomViewModel = locator<RoomViewModel>();

    //TODO capire dove sta l'errore
    final data = await _databaseService.getData("tclKPI", {
      "node": _databaseService.nodes[_key],
      "startDate": _dateStart,
      "endDate": _dateEnd
    });

    //TODO da capire se spostare dentro db service
    if (_method.contains("Kpi")) {
      List<Kpi> kpis = [];
      final periods = data["periods"];
      final categories = data["labels_category"];

      for (var i = 0; i < periods.length; i++) {
        kpis.add(Kpi(
            label: categories[i],
            value: periods[i].toDouble(),
            color: _pieColors[i]));
      }

      roomViewModel.setKpis(kpis);
    }
  }
}
//http://193.205.129.218:5000/tclKPI/labceca01/2019-08-11/2019-12-06/09:00:00/17:00:00/seated/0.05/1.1/0.5/ext
