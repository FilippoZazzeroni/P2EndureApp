import 'package:flutter/material.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';
import 'package:stacked_services/stacked_services.dart';

class MainModel extends BaseModel {
  final _navigationService = locator<NavigationService>();

  /// get navigator key dal NavigationService
  GlobalKey get navigatorKey => _navigationService.navigatorKey;
}
