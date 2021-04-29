import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/shared/textStyle.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/views/roomView/roomViewModel.dart';
import 'package:p2Endure/ui/widget/dataSelector/dataSelector.dart';
import 'package:p2Endure/ui/widget/dateSelector/dateSelector.dart';

class RoomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<RoomViewModel>(builder: (context, model, child) {
      //TODO da spostare in inzializzazione
      model.key = "labceca01";

      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              DataSelector(),
              DateSelector(),
              OutlineButton(
                  child: Text("get data", style: TextStyles.style()),
                  onPressed: () => model.getData()),
              //! thermal confort
              Container(
                height: 300,
                padding: EdgeInsets.all(30),
                child: model.graphData == null
                    ? Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      )
                    : PieChart(model.graphData,
                        defaultRenderer: ArcRendererConfig(
                            arcWidth: 60,
                            arcRendererDecorators: [
                              ArcLabelDecorator(
                                  labelPosition: ArcLabelPosition.outside)
                            ])),
              ),
            ],
          ),
        ),
      );
    });
  }
}
