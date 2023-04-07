import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticaionProvider with ChangeNotifier {
  var apiUrl = "http://localhost:3001/signin";

  Future<http.Response> singIn({
    required String userName,
    required String password,
  }) async {
    Map jsonBody = {
      "userName": userName,
      "password": password,
    };

    var body = json.encode(jsonBody);
    http.Response res = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "content-type": "application/json"
      },
      body: body,
    );

    return res;
  }
}
