import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/shared/textStyle.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/configView/configViewModel.dart';
import 'package:p2Endure/ui/widget/generalForm/generalForm.dart';

class ConfigView extends StatelessWidget {
  final ScanResult device;
  final String devKey;

  ConfigView(this.devKey, this.device);

  @override
  Widget build(BuildContext context) {
    return BaseView<ConfigViewModel>(builder: (context, model, child) {
      model.device = device;

      return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.arrow_back,
              color: PColors.deepBlue,
            ),
            onPressed: () => model.disconnect()),
        body: WillPopScope(
          onWillPop: () {},
          child: Scaffold(
            body: Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Node configurator",
                    textAlign: TextAlign.center,
                    style: TextStyles.style(size: 20, weight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //fare drop down
                  GeneralForm("ssid", "Ssid"),
                  GeneralForm("pwd", "Password"),
                  GeneralForm("node", "Node name"),
                  // GeneralForm("mqttIp", "Server ip"),
                  // GeneralForm("mqttUser", "Server user"),
                  // GeneralForm("mqttPwd", "Server password"),
                  Column(
                    children: [
                      Container(
                          width: 120,
                          margin: EdgeInsets.only(top: 20),
                          child: CupertinoButton(
                            padding: EdgeInsets.only(),
                            color: PColors.deepBlue,
                            child: Text("Connect",
                                style: TextStyles.style(
                                  color: Colors.white,
                                )),
                            onPressed: () => model.connect(),
                          )),
                      Container(
                          width: 120,
                          margin: EdgeInsets.only(top: 20),
                          child: CupertinoButton(
                            padding: EdgeInsets.only(),
                            color: PColors.deepBlue,
                            child: Text("Send",
                                style: TextStyles.style(
                                  color: Colors.white,
                                )),
                            onPressed: () => model.write(),
                          )),
                      model.isCa
                          ? Container(
                              width: 120,
                              margin: EdgeInsets.only(top: 20),
                              child: CupertinoButton(
                                padding: EdgeInsets.only(),
                                color: PColors.deepBlue,
                                child: Text("Calibrate CO2",
                                    style: TextStyles.style(
                                      color: Colors.white,
                                    )),
                                onPressed: () => model.calibrateSensor(),
                              ))
                          : SizedBox.shrink(),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                              model.isConnected
                                  ? "Connected to node"
                                  : "Not connected to node",
                              style: TextStyles.style(
                                color: model.isConnected
                                    ? PColors.deepBlue
                                    : PColors.lightBlue,
                              ))),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                              model.isWifiConnected
                                  ? "Connected to network"
                                  : "Not connected to any network",
                              style: TextStyles.style(
                                color: model.isWifiConnected
                                    ? PColors.deepBlue
                                    : PColors.lightBlue,
                              ))),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
