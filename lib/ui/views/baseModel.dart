import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:stacked_services/stacked_services.dart';

/// modello alla base dei viewModel o widget model
abstract class BaseModel extends ChangeNotifier {
  final _navigationService = locator<NavigationService>();

  final _dialogService = locator<DialogService>();

  BuildContext get _context => _navigationService.navigatorKey.currentContext;

  /// naviga verso il route inserito
  void navigateTo(String route, {dynamic arguments}) =>
      _navigationService.navigateTo(route, arguments: arguments);

  /// pop context
  void popView() => _navigationService.back();

  /// true è phone layout
  bool get usePhoneLayout => MediaQuery.of(_context).size.shortestSide < 600;

  double get screenWidth => MediaQuery.of(_context).size.width;

  double get shortestSide => MediaQuery.of(_context).size.shortestSide;

  Future showSnackBar(String text) => Flushbar(
        margin: EdgeInsets.all(8),
        barBlur: 10,
        backgroundColor: Colors.white,
        messageText: Text(
          text,
          style: TextStyle(color: PColors.deepBlue),
        ),
        borderRadius: 10,
        flushbarPosition: FlushbarPosition.TOP,
        duration: Duration(seconds: 2),
      ).show(_context);

  void showToast(String msg) => Fluttertoast.showToast(msg: msg);

  // void showLoadingDialog() {
  //   _dialogService
  //       .registerCustomDialogUi((BuildContext context, _) => LoadingDialog());
  //   _dialogService.showCustomDialog();
  // }

  void disposeLoadingDialog() {
    _dialogService.completeDialog(DialogResponse());
  }

  void disposeKeyboard() => FocusScope.of(_context).requestFocus(FocusNode());
}
