// ignore_for_file: unused_field, prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicoService {
  // final String _baseUrl = 'http://192.168.0.106:8080/api/servico';
  final String _baseUrl = 'http://10.10.101.230:8080/api/servico';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<http.Response> get(String url, Map<String, String> params, Map<String, String> headers) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url).replace(queryParameters: params);
      http.Response response = await http.get(uri, headers: headers);
      return response;
    } catch (e) {
      return http.Response({'message': e.toString()}.toString(), 400);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body, Map<String, String> headers) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response = await http.put(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e.toString()}.toString(), 400);
    }
  }
}