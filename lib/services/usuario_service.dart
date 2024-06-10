import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  final String _baseUrl = dotenv.env['BASE_URL_USUARIO']!;
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<http.Response> get(String url, Map<String, String> params) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url).replace(queryParameters: params);
      http.Response response = await http.get(uri);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response = await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      String bodyString = json.encode(body);
      http.Response response = await http.put(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }

  Future<http.Response> delete(String url) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      http.Response response = await http.delete(uri, headers: headers);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }

  Future<http.Response> login(String username, String password) async {
    try {
      Uri uri = Uri.parse('$_baseUrl/login');
      Map<String, dynamic> body = {
        'username': username,
        'password': password,
      };
      String bodyString = json.encode(body);
      http.Response response = await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }

  Future<http.Response> resetPassword(String email) async {
    try {
      Uri uri = Uri.parse('$_baseUrl/recuperar-senha');
      Map<String, dynamic> body = {
        'email': email,
      };
      String bodyString = json.encode(body);
      http.Response response = await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }

Future<http.Response> changePassword(String password, String token) async {
    try {
      Uri uri = Uri.parse('$_baseUrl/redefinir-senha');
      Map<String, dynamic> body = {
        'password': password,
      };
      String bodyString = json.encode(body);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      http.Response response = await http.post(uri, headers: headers, body: bodyString);
      return response;
    } catch (e) {
      return http.Response({'message': e}.toString(), 400);
    }
  }
}
