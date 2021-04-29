import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:p2Endure/router.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/shared/textStyle.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/blesView/blesVIewModel.dart';

class BlesView extends StatelessWidget {
  final _devicesList = [];

  @override
  Widget build(BuildContext context) {
    return BaseView<BlesViewModel>(builder: (context, model, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => model.scan(),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: StreamBuilder<List<ScanResult>>(
            stream: model.devices,
            builder: (context, snapshot) {
              _devicesList.clear();

              snapshot.data.forEach((element) {
                if (element.device.name.isNotEmpty) _devicesList.add(element);
              });

              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text("Ble devices",
                      style:
                          TextStyles.style(size: 20, weight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  snapshot.data == null
                      ? CircularProgressIndicator()
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _devicesList.length,
                              itemBuilder: (context, index) =>
                                  _buildDeviceWidget(
                                      _devicesList[index], model)),
                        )
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildDeviceWidget(ScanResult device, BlesViewModel model) {
    return GestureDetector(
      onTap: () => model.navigateTo(Routes.configViewRoute,
          arguments: ConfigViewArguments(device.device.name, device)),
      child: Container(
        margin: EdgeInsets.only(top: 16),
        height: 80,
        decoration: BoxDecoration(
            color: PColors.deepBlue, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              child: Icon(
                Icons.bluetooth,
                size: 30,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.device.name,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${device.rssi} dB",
                      style: TextStyle(color: Colors.white))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
