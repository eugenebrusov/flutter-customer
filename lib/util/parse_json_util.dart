
import 'dart:convert';

Map<String, dynamic> parseJson(String jsonString) =>
    Map<String, dynamic>.from(json.decode(jsonString));