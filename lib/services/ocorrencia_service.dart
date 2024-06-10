// ignore_for_file: unused_field, prefer_final_fields

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OcorrenciaService {
    final String _baseUrl = dotenv.env['BASE_URL_OCORRENCIA']!;
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

  Future<http.Response> post(String url, Map<String, dynamic> body, Map<String, String> headers) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response = await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e.toString()}.toString(), 400);
    }
  }
}