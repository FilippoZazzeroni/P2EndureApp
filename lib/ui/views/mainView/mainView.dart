import 'package:flutter/material.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/blesView/blesView.dart';
import 'package:p2Endure/ui/views/buildingsView/buildingsView.dart';
import 'package:p2Endure/ui/views/configView/configView.dart';
import 'package:p2Endure/ui/views/mainView/mainViewModel.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widgetOptions = <Widget>[BuildingsView(), BlesView()];

    return BaseView<MainViewModel>(builder: (context, model, child) {
      return WillPopScope(
          onWillPop: () => model.backButtonCallBack(),
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: PColors.lightBlue,
              title:
                  const Text('P2Endure', style: TextStyle(color: Colors.white)),
              centerTitle: true,
              leading: Container(),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: IndexedStack(
                    index: model.index,
                    children: widgetOptions,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: PColors.deepBlue,
              selectedItemColor: Colors.white,
              backgroundColor: PColors.lightBlue,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Color.fromRGBO(217, 201, 188, 1.0),
                  icon: Icon(Icons.home_work_sharp),
                  label: "Buildings",
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color.fromRGBO(217, 201, 188, 1.0),
                  icon: Icon(Icons.build),
                  label: "Configurator",
                ),
              ],
              currentIndex: model.index,
              onTap: model.onItemTap,
            ),
          ));
    });
  }
}
