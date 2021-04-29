import 'package:flutter/material.dart';
import 'package:p2Endure/router.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/buildingsView/buildingsViewModel.dart';

class BuildingsView extends StatelessWidget {
  final _buildings = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return BaseView<BuildingsViewModel>(builder: (context, model, child) {
      _buildings.add(
          _buildingWidget("asset/enschede.jpg", "Enschede", model, "enschede"));
      _buildings
          .add(_buildingWidget("asset/gdy_out.jpg", "Gdynia", model, "gdy"));
      _buildings
          .add(_buildingWidget("asset/waw_out.jpg", "Warsaw", model, "waw"));

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Container(
            child: ListView(
          children: _buildings,
        )),
      );
    });
  }

  //TODO implementare img picker
  Widget _buildingWidget(
      String imgPath, String title, BuildingsViewModel model, String key) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () => model.navigateTo(Routes.buildingViewRoute,
            arguments: BuildingViewArguments(key)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 3.0, color: PColors.deepBlue),
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: PColors.lightBlue,
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(4),
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
