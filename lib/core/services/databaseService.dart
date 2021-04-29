import 'dart:convert';

import "package:http/http.dart" as http;

class DatabaseService {
  final nodes = {
    "labceca01": "labceca01",
    "labceca02": "labceca02",
  };

  final _query = {
    "tclKPI": {
      "base": "http://193.205.129.218:5000/tclKPI",
      "node": "",
      "startDate": "",
      "endDate": "",
      "startTime": "09:00:00",
      "endTime": "17:00:00",
      "state": "seated",
      "vAir": "0.05",
      "met": "1.1",
      "cla": "0.5",
      "pos": "ext",
    }
  };

  String _getQuery(String method, Map<String, dynamic> args) {
    String query = "";
    _query[method].forEach((key, value) {
      if (key == "base")
        query += value;
      else {
        if (value.isEmpty)
          query += "/${args[key]}";
        else
          query += "/$value";
      }
    });
    print(query);
    return query;
  }

  Future<Map<String, dynamic>> getData(
      String method, Map<String, dynamic> args) async {
    final response = await http.get(_getQuery(method, args));

    if (method.contains("KPI")) return jsonDecode(response.body);

    // final data = <List<int>>[];
    // final rawData = jsonDecode(response.body) as List;

    // for (var i = 0; i < rawData.length; i++) {
    //   data.add([rawData[i][0], i]);
    // }

    // print(data);

    // return data;
    return Map();
  }
}
