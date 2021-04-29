import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:p2Endure/ui/views/buildingView/buildingView.dart';
import 'package:p2Endure/ui/views/configView/configView.dart';
import 'package:p2Endure/ui/views/mainView/mainView.dart';
import 'package:p2Endure/ui/views/roomView/roomView.dart';

abstract class Routes {
  static const mainViewRoute = '/';
  static const buildingViewRoute = "/building-view-route";
  static const configViewRoute = "/config-view-route";
  static const roomViewRoute = "/room-view-route";

  static const all = {
    buildingViewRoute,
    mainViewRoute,
  };
}

class AutoRouter extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings, [String basePath]) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.buildingViewRoute:
        final typedArgs = args as BuildingViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => BuildingView(typedArgs.key),
          settings: settings,
        );
      case Routes.mainViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainView(),
          settings: settings,
        );
      case Routes.roomViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => RoomView(),
          settings: settings,
        );
      case Routes.configViewRoute:
        final typedArgs = args as ConfigViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => ConfigView(typedArgs.key, typedArgs.device),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
            builder: (context) => MainView(), settings: settings);
    }
  }

  @override
  List<RouteDef> get routes => throw UnimplementedError();

  @override
  Map<Type, AutoRouteFactory> get pagesMap => Map();
}

class BuildingViewArguments {
  final String key;
  BuildingViewArguments(this.key);
}

class ConfigViewArguments {
  final String key;
  final ScanResult device;
  ConfigViewArguments(this.key, this.device);
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************
