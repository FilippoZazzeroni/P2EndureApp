import 'package:p2Endure/core/models/room.dart';

class BuildingsService {
  final _rooms = {
    "enschede": [
      Room(name: "room 1", description: "description of room 1"),
      Room(name: "room 2", description: "description of room 2")
    ],
    "gdy": [
      Room(name: "room 1", description: "description of room 1"),
      Room(name: "room 2", description: "description of room 2")
    ],
    "waw": [
      Room(name: "room 1", description: "description of room 1"),
      Room(name: "room 2", description: "description of room 2"),
      Room(name: "room 3", description: "description of room 3"),
      Room(name: "room 4", description: "description of room 4")
    ],
  };

  List<Room> getRooms(String key) => _rooms[key];
}
