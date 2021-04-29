import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/shared/textStyle.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/widget/dateSelector/dateSelectorModel.dart';

// ignore: must_be_immutable
class DateSelector extends StatelessWidget {
  final textSize = 17.0;

  @override
  Widget build(BuildContext context) {
    return BaseView<DateSelectorModel>(builder: (context, model, child) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: PColors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: model.usePhoneLayout
                ? EdgeInsets.fromLTRB(10, 10, 10, 0)
                : EdgeInsets.fromLTRB(100, 10, 100, 0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 12.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Start date",
                        style: TextStyles.style(color: Colors.black),
                      ),
                    ),
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.white),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (Platform.isIOS) {
                          await _showDateIos(context, model);
                          _showTimeIos(context, model);
                        }
                      },
                      child: Text(model.dateStartString,
                          style: TextStyles.style(color: Colors.white)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "End date",
                        style: TextStyles.style(color: Colors.black),
                      ),
                    ),
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.white),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (Platform.isIOS) {
                          await _showDateIos(context, model, isStart: false);
                          _showTimeIos(context, model, isStart: false);
                        }
                      },
                      child: Text(model.dateEndString,
                          style: TextStyles.style(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  Future _showDateIos(context, DateSelectorModel model, {bool isStart = true}) {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: PColors.deepBlue,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: CupertinoButton(
                      padding:
                          EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                      onPressed: () => model.popView(),
                      child: Text("done",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime(2100),
                  minimumDate: DateTime(1970),
                  onDateTimeChanged: (date) =>
                      isStart ? model.dateStart = date : model.dateEnd = date,
                ),
              ),
            ],
          );
        });
  }

  Future _showTimeIos(context, DateSelectorModel model, {bool isStart = true}) {
    return showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: PColors.deepBlue,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: CupertinoButton(
                      padding:
                          EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                      onPressed: () => model.popView(),
                      child: Text("done",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: isStart ? model.dateStart : model.dateEnd,
                  onDateTimeChanged: (time) =>
                      isStart ? model.timeStart = time : model.timeEnd = time,
                ),
              ),
            ],
          );
        });
  }

  Future _showDateAndroid(context, DateSelectorModel model) async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );

    //model.date = datePicked;
  }

  Future _showTimeAndroid(context, DateSelectorModel model) async {
    final timePicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    //model.time = timePicked;
  }
}
