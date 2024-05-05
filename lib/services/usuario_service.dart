// ignore_for_file: unused_field, prefer_final_fields

import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioService {
  final String _baseUrl='localhost:8080/api/usuario';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<http.Response> get(String url, Map<String, String> params) async {
    try {
      Uri uri = Uri.parse(_baseUrl+url).replace(queryParameters: params);
      http.Response response = await http.get(uri);
      return response;
    } catch (e) {
      return http.Response({'message':e}.toString(), 400);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(_baseUrl+url);
      String bodyString = json.encode(body);
      http.Response response = await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message':e}.toString(), 400);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(_baseUrl+url);
      String bodyString = json.encode(body);
      http.Response response = await http.put(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message':e}.toString(), 400);
    }
  }

  Future<http.Response> delete(String url) async {
    try {
      Uri uri = Uri.parse(_baseUrl+url);
      http.Response response = await http.delete(uri, headers: headers);
      return response;
    } catch (e) {
      return http.Response({'message':e}.toString(), 400);
    }
  }
}