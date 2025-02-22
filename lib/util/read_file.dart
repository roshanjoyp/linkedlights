import 'dart:convert';

import 'package:flutter/services.dart';

class ReadFile {
  static Future<Map<String, List<List<String>>>> readJsonFile(
      String path) async {
    // Read the JSON file
    String jsonString = await rootBundle.loadString(path);

    // Parse the JSON string into a Dart map
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    // Convert the data into the required format
    Map<String, List<List<String>>> formattedData = {};

    for (var key in jsonData.keys) {
      List<dynamic> patterns = jsonData[key];

      // Convert each pattern into a list of strings
      List<List<String>> convertedPatterns = patterns.map((patternData) {
        List<List<int>> pattern = (patternData['pattern'] as List)
            .map((row) => List<int>.from(row))
            .toList();

        // Convert each pattern row into a binary string
        String binaryString = pattern.map((row) => row.join()).join();

        return [binaryString]; // Wrap in a list to match the required format
      }).toList();

      formattedData[key] = convertedPatterns;
    }

    return formattedData;
  }
}
