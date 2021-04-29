import 'package:flutter/material.dart';
import 'package:p2Endure/core/services/roomService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';
import 'package:intl/intl.dart';

class DateSelectorModel extends BaseModel {
  final _roomService = locator<RoomService>();

  DateSelectorModel() {
    dateStart = DateTime.now();
    dateEnd = DateTime.now().add(Duration(days: 2));
  }

  DateTime dateStart;

  String get dateStartString =>
      "${dateStart.day}/${dateStart.month} ${DateFormat.Hm().format(dateStart)}";

  set timeStart(DateTime value) {
    dateStart = value;
    _roomService.dateStart =
        "${dateStart.year}-${dateStart.month}-${dateStart.day}";
    notifyListeners();
  }

  DateTime dateEnd;

  String get dateEndString =>
      "${dateEnd.day}/${dateEnd.month} ${DateFormat.Hm().format(dateEnd)}";

  set timeEnd(DateTime value) {
    dateEnd = value;
    _roomService.dateEnd = "${dateEnd.year}-${dateEnd.month}-${dateEnd.day}";
    notifyListeners();
  }
}
