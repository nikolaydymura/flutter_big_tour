import 'dart:convert';

import 'package:http/http.dart';

class NetworkApi {
  final Client _client;

  NetworkApi(this._client);

  Future<Map<String, dynamic>> loadJsonObject(Uri uri) async {
    final response = await _client.get(uri);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<dynamic>> loadJsonList(Uri uri) async {
    final response = await _client.get(uri);
    return jsonDecode(response.body) as List<dynamic>;
  }
}
