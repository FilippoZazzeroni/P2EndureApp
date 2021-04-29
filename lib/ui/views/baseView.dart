import 'package:flutter/material.dart';
import 'package:p2Endure/locator.dart';
import 'package:provider/provider.dart';

/// base class di una view generica
class BaseView<T extends ChangeNotifier> extends StatelessWidget {
  BaseView({@required this.builder, this.child});

  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    //.value quando l'istanza è gia stata registrata => nel locator
    return ChangeNotifierProvider<T>.value(
      value: locator<T>(),
      child: Consumer<T>(
        builder: builder,
        child: child,
      ),
    );
  }
}
