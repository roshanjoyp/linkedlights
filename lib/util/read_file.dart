import 'dart:convert';

import 'package:flutter/services.dart';

class ReadFile {
  static Future<Map<int, dynamic>> readJsonFile(String path) async {
    // Read the JSON file
    String jsonString = await rootBundle.loadString(path);

    // Parse the JSON string into a Dart map
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    // Convert the data into the required format
    Map<int, Map<String, dynamic>> formattedData = {};
    var i = 0;

    jsonData.forEach((key, value) {
      //print(key);
      //print(value);
      var levels = value as List;
      for (var level in levels) {
        //print(level);
        var levelStateData = level["pattern"] as List;
        var levelStateString = "";
        for (var light in levelStateData) {
          var state = light as List;
          for (var e in state) {
            levelStateString += e.toString();
          }
        }
        formattedData[++i] = {
          "pattern": levelStateString,
          "minimumTapsToWin": level["min_taps"],
          "total_unique_states": level["unique_states"]
        };
        //print(levelStateString);
      }
    });

    return formattedData;
  }
}
