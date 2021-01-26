import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;

  String get token {
    return _token;
  }

  bool get isAuth {
    return _token != null;
  }

  Future<bool> tryLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('userData')) {
      return false;
    }
    final extractedData = await json.decode(preferences.getString('userData'))
        as Map<String, Object>;
    _token = extractedData['token'];
    // print(_token);
    return true;
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }

  Future<void> login(String username, String password) async {
    const url = "https://long-cinema-app.herokuapp.com/api/user/login/quest";
    print(json.encode(
      {'username': username, 'password': password},
    ));
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {'username': username, 'password': password},
      ),
    );
    final responseData = json.decode(response.body);
    _token = responseData['token'];
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(responseData['token']);
    final userData = json.encode({
      'token': _token,
    });
    preferences.setString('userData', userData);
    print(json.decode(response.body));
  }

  Future<http.Response> register(String username, String password, String email,
      String address, String name, String phone) async {
    const url = "https://long-cinema-app.herokuapp.com/api/quest/members";
    print(json.encode(
      {
        'username': username,
        'password': password,
        'phone': phone,
        'address': address,
        'name': name,
        'email': email
      },
    ));
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(
        {
          'username': username,
          'password': password,
          'phone': phone,
          'address': address,
          'name': name,
          'birth': '21/1/7',
          'email': email
        },
      ),
    );
    print(json.decode(response.body));
    return response;
  }
}
