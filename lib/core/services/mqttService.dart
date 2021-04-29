import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//TODO capire error handling
//TODO i topic saranno dell var fetch dal nodo
class MqttService {
  MqttService() {
    _connect();
  }

  final _client =
      MqttServerClient("193.205.129.218", "misu", maxConnectionAttempts: 6)
        ..port = 3883;

  MqttClientConnectionStatus _state;

  Stream<List<MqttReceivedMessage<MqttMessage>>> get data => _client.updates;

  double temp;

  String _error;

  String get error => _error;

  String _stateHandler() {
    if (_state == null) return "CONNECTION_NOT_STARTED";

    switch (_state.state) {
      case MqttConnectionState.disconnecting:
        return "DISCONNECTING";
      case MqttConnectionState.disconnected:
        return "DISCONNECTED";
      case MqttConnectionState.connecting:
        return "CONNECTING_TO_BROKER";
      case MqttConnectionState.connected:
        return "OK";
      case MqttConnectionState.faulted:
        return "ERROR_IN_CONNECCTION";
      default:
        return "UNKNOWN";
    }
  }

  Future _connect() async {
    try {
      _state = await _client.connect("misu", "termodiism");
    } catch (e) {
      print(e);
      // ? non serve _client.disconnect();
    }
  }

  //TODO aggiungere error handling
  void _subscribe(String topic) =>
      _client.subscribe(topic, MqttQos.atLeastOnce);

  void subscribe(String topic) {
    final response = _stateHandler();
    if (response == "OK") _subscribe(topic);
  }

  void _unsubscribe(String topic) => _client.unsubscribe(topic);

  void _publish(String message, String topic) {
    final payload = MqttClientPayloadBuilder()..addString(message);
    _client.publishMessage(topic, MqttQos.atLeastOnce, payload.payload);
  }

  //TODO error handling in case of error
  void publish(String message, String topic) {
    final response = _stateHandler();
    if (response == "OK") _publish(message, topic);
  }

  void subscribeToTopics(String topic) {
    final response = _stateHandler();
    if (response == "OK") {
      _subscribe(topic);
      _publish("getStatus", topic);
    } else
      //TODO tradurre
      _error = "Server not connected, push retry to connect to it again";
  }

  void unsubscribeTopics() {
    _unsubscribe("p2endure/menden/building/room/ce/mence01/status");
    _unsubscribe("p2endure/menden/building/room/ca/menca01/status");
  }
}
