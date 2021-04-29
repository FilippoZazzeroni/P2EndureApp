import 'package:flutter/material.dart';
import 'package:p2Endure/core/models/room.dart';
import 'package:p2Endure/router.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/buildingView/buildingViewModel.dart';

class BuildingView extends StatelessWidget {
  final String buildingKey;

  BuildingView(this.buildingKey);

  final _rooms = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return BaseView<BuildingViewModel>(builder: (context, model, child) {
      model.key = buildingKey;
      model.rooms.forEach((element) => _rooms.add(_roomWidget(element, model)));
      return Scaffold(
        backgroundColor: PColors.lightBlue,
        body: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                "${model.key} rooms",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: _rooms,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _roomWidget(Room room, BuildingViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        onPressed: () => model.navigateTo(Routes.roomViewRoute),
        color: PColors.deepBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Container(
          height: 80,
          width: double.infinity,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.meeting_room_outlined,
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
                      room.name,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(room.description,
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
