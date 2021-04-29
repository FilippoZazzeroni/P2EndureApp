//! codice/valore 01/node, 02/ssid, 03/pwd

class ConfigService {
  //TODO fare check quando valori sono superiori a 20 byte
  final config = {
    "node": [1, ""],
    "ssid": [2, ""],
    "pwd": [3, ""],
    "mqttIp": [4, ""],
    "mqttUser": [5, ""],
    "mqttPwd": [6, ""],
  };
}
