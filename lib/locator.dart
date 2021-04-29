import 'package:get_it/get_it.dart';
import 'package:p2Endure/core/services/bleService.dart';
import 'package:p2Endure/core/services/buildingsService.dart';
import 'package:p2Endure/core/services/configService.dart';
import 'package:p2Endure/core/services/databaseService.dart';
import 'package:p2Endure/core/services/mqttService.dart';
import 'package:p2Endure/core/services/roomService.dart';
import 'package:p2Endure/mainModel.dart';
import 'package:p2Endure/ui/views/blesView/blesVIewModel.dart';
import 'package:p2Endure/ui/views/buildingView/buildingViewModel.dart';
import 'package:p2Endure/ui/views/buildingsView/buildingsViewModel.dart';
import 'package:p2Endure/ui/views/configView/configViewModel.dart';
import 'package:p2Endure/ui/views/mainView/mainViewModel.dart';
import 'package:p2Endure/ui/views/roomView/roomViewModel.dart';
import 'package:p2Endure/ui/widget/dataSelector/dataSelector.dart';
import 'package:p2Endure/ui/widget/dataSelector/dataSelectorModel.dart';
import 'package:p2Endure/ui/widget/dateSelector/dateSelectorModel.dart';
import 'package:p2Endure/ui/widget/generalForm/generalFormModel.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.I;

/// models and services registration
void setUp() {
  //! services
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BuildingsService());
  locator.registerLazySingleton(() => BleService());
  locator.registerLazySingleton(() => ConfigService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => RoomService());
  locator.registerSingleton(MqttService());

  //! models
  locator.registerLazySingleton(() => MainViewModel());
  locator.registerLazySingleton(() => BuildingsViewModel());
  locator.registerFactory(() => BuildingViewModel());
  locator.registerFactory(() => ConfigViewModel());
  locator.registerLazySingleton(() => MainModel());
  locator.registerFactory(() => GeneralFormModel());
  locator.registerLazySingleton(() => BlesViewModel());
  locator.registerLazySingleton(() => RoomViewModel());
  locator.registerLazySingleton(() => DataSelectorModel());
  locator.registerLazySingleton(() => DateSelectorModel());
}
