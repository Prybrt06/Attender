import 'dart:convert';

import 'package:attender/Model/SubjectModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/storageHandler.dart';

class SubjectProvider with ChangeNotifier {
  var apiUrl = "http://localhost:4000/subject";

  Future<List<SubjectModel>> getAllSubject() async {
    var res = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${StorageHandler().getToken()}'
    });
    var jsonResponse = await jsonDecode(res.body);

    int len = jsonResponse["subjects"].length;
    print(len);

    List<SubjectModel> attendences = [];

    for (int i = 0; i < len; i++) {
      SubjectModel attendence = SubjectModel(
        id: jsonResponse["subjects"][i]["id"],
        subjectName: jsonResponse["subjects"][i]["name"],
        subjectCode: jsonResponse["subjects"][i]["subjectCode"],
        totalClasses: jsonResponse["subjects"][i]["totalClasses"],
        attendedClasses: jsonResponse["subjects"][i]["attendedClasses"],
      );

      print(attendence.id);

      attendences.add(attendence);
    }
    return attendences;
  }

  Future<String> addSubject({
    required String subjectName,
    required String subjectCode,
  }) async {
    Map jsonBody = {
      "name": subjectName,
      "subjectCode": subjectCode,
    };
    var res = await http.post(
      Uri.parse("$apiUrl/create"),
      headers: {
        'Authorization': 'bearer ${StorageHandler().getToken()}',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(jsonBody),
    );

    if (res.statusCode == 201) {
      return "Subject has been created successfully please refresh the page to see the changes";
    } else {
      return "We are not able to create the subject at this moment";
    }
  }

  Future<String> deleteSubject({required String id}) async {
    print('$apiUrl/delete/$id');
    var res = await http.delete(
      Uri.parse('$apiUrl/delete/$id'),
      headers: {
        'Authorization': 'bearer ${StorageHandler().getToken()}',
      },
    );

    if (res.statusCode == 201) {
      return "The subject has been deleted successfully";
    } else {
      return "We are not able to delete the subject at this moment";
    }
  }

  Future<int> markAttendance({
    required int totalClasses,
    required int attendedClasses,
    required bool isAttended,
    required String id,
  }) async {
    Map jsonBody = {
      "totalClasses": totalClasses,
      "attendedClasses": attendedClasses,
      "isAttended": isAttended,
    };

    var res = await http.put(
      Uri.parse('$apiUrl/markAttendance/$id'),
      headers: {
        'Authorization': 'bearer ${StorageHandler().getToken()}',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(jsonBody),
    );

    return res.statusCode;
  }
}
