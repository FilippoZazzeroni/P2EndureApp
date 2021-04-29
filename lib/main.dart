import 'package:flutter/material.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/mainModel.dart';
import 'package:p2Endure/router.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/mainView/mainView.dart';

void main() {
  setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BaseView<MainModel>(builder: (context, model, child) {
      return MaterialApp(
        title: 'P2Endure',
        theme: ThemeData(
          //primarySwatch: PColors.lightBlue,
          primaryColor: PColors.lightBlue,
          accentColor: PColors.lightBlue,
          textSelectionColor: PColors.lightBlue,
          cursorColor: PColors.lightBlue,
          textSelectionHandleColor: PColors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainView(),
        navigatorKey: model.navigatorKey,
        onGenerateRoute: AutoRouter().onGenerateRoute,
      );
    });
  }
}
