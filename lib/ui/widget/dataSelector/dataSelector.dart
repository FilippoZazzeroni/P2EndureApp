import 'package:flutter/material.dart';
import 'package:p2Endure/ui/shared/colors.dart';
import 'package:p2Endure/ui/shared/textStyle.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/widget/dataSelector/dataSelectorModel.dart';

class DataSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<DataSelectorModel>(
      builder: (context, model, child) {
        return Container(
            height: 95,
            decoration: BoxDecoration(
                color: PColors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            margin: model.usePhoneLayout
                ? EdgeInsets.fromLTRB(10, 10, 10, 0)
                : EdgeInsets.fromLTRB(100, 10, 100, 0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 5),
                  //TODO tradurre
                  child: Text("Select type of data to show"),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: InkWell(
                            onTap: () => _selector(context),
                            child: Container(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        model.selectedData,
                                        style: TextStyles.style(size: 17),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        color: PColors.deepBlue,
                                      ),
                                    )
                                  ],
                                )),
                          ))),
                ),
              ],
            ));
      },
    );
  }

  //TODO traduzioni
  Future<void> _selector(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: PColors.deepBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: BaseView<DataSelectorModel>(builder: (context, model, child) {
            final widgets = <Widget>[];

            widgets.add(
              Stack(
                children: [
                  Positioned(
                      top: 17 / 2,
                      right: 0.0,
                      child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () => model.popView())),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Select a recipe",
                      style: TextStyles.style(
                          color: Colors.white,
                          size: 17.0,
                          weight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );

            model.data
                .forEach((element) => widgets.add(_tile(element[0], model)));

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widgets,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _tile(String element, DataSelectorModel model) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => model.setSelectedData(element),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Icon(
                //tODO da cambiare con un punto
                Icons.ac_unit,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                element,
                style: TextStyles.style(color: Colors.white, size: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
