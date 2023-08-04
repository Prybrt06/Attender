import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticaionProvider with ChangeNotifier {
  var apiUrl = "http://localhost:4000/signin";

  Future<http.Response> singIn({
    required String userName,
    required String password,
  }) async {
    Map jsonBody = {
      "username": userName,
      "password": password,
    };

    var body = json.encode(jsonBody);
    http.Response res = await http.post(
      Uri.parse(apiUrl),
      headers: {"content-type": "application/json"},
      body: body,
    );

    print(res);

    return res;
  }
}
