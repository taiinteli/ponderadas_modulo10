import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  static String _baseUrl = 'http://localhost:${dotenv.env['SERVER_PORT']}';

  Future<void> registerUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    print("CAZE A")
    print(response)

    if (response.statusCode != 201) {
      throw Exception('Falha ao registrar usuário');
    }
  }
}