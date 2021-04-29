import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p2Endure/core/enum/generalFormState.dart';
import 'package:p2Endure/ui/shared/textStyle.dart';
import 'package:p2Endure/ui/views/baseView.dart';
import 'package:p2Endure/ui/widget/generalForm/generalFormModel.dart';

class GeneralForm extends StatefulWidget {
  /// chiave traduazione testo form
  GeneralForm(this.textKey, this.title);

  final String textKey;
  final String title;

  @override
  State<StatefulWidget> createState() => _GeneralForm();
}

class _GeneralForm extends State<GeneralForm> {
  final _controller = TextEditingController();
  final _node = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //FormModel è il provider che gestisce lo stato di questo widget.
    //il change notifier è necessario per collegare il modello al widget/view
    return BaseView<GeneralFormModel>(builder: (context, model, child) {
      model.key = widget.textKey;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: model.usePhoneLayout
                ? EdgeInsets.fromLTRB(20, 10, 20, 0)
                : EdgeInsets.fromLTRB(200, 20, 200, 0),
            child: Text(
              widget.title,
              style: TextStyles.style(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: model.usePhoneLayout
                ? EdgeInsets.fromLTRB(20, 0, 20, 0)
                : EdgeInsets.fromLTRB(200, 20, 200, 0),
            width: 400,
            child: Form(
              child: TextFormField(
                focusNode: _node,
                controller: _controller,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  model.value = value;
                  if (value.isEmpty) {
                    model.setState(GeneralFormState.EMPTY);
                  } else {
                    model.setState(GeneralFormState.FILLED);
                  }
                },
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide()),
                  suffixIcon: Container(
                    width: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        //bottone per cancellare form
                        model.state == GeneralFormState.FILLED
                            ? IconButton(
                                icon: Icon(CupertinoIcons.delete),
                                onPressed: () {
                                  _controller.clear();
                                  model.setState(GeneralFormState.EMPTY);
                                })
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
