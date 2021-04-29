import 'package:p2Endure/core/enum/generalFormState.dart';
import 'package:p2Endure/core/services/configService.dart';
import 'package:p2Endure/locator.dart';
import 'package:p2Endure/ui/views/baseModel.dart';

class GeneralFormModel extends BaseModel {
  final _configService = locator<ConfigService>();

  //stato iniziale del form
  GeneralFormState _state = GeneralFormState.EMPTY;

  GeneralFormState get state => _state;

  String _key;

  set key(String key) {
    _key = key;
  }

  /// set value nel servizio con la chiave voluta
  set value(String value) => _configService.config[_key][1] = value;

  //funzione usate per settare lo stato del form
  void setState(GeneralFormState state) {
    if (state == GeneralFormState.EMPTY) value = "";
    _state = state;
    notifyListeners();
  }
}
