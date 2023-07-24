import 'dart:convert';

import 'package:attender/Model/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/storageHandler.dart';

class SubjectProvider with ChangeNotifier {
  var apiUrl = "http://localhost:3001/subject";

  Future<List<AttendanceModel>> getAllAttendences() async {
    var res = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${StorageHandler().getToken()}'
    });
    var jsonResponse = await jsonDecode(res.body);

    int len = jsonResponse["subjects"].length;
    print(len);

    List<AttendanceModel> attendences = [];

    for (int i = 0; i < len; i++) {
      AttendanceModel attendence = AttendanceModel(
        id: jsonResponse["subjects"][i]["id"],
        subjectName: jsonResponse["subjects"][i]["subjectName"],
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
      "subjectName": subjectName,
      "subjectCode": subjectCode,
      "totalClasses": 0,
      "attendedClasses": 0
    };
    var res = await http.post(
      Uri.parse(apiUrl),
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
    var res = await http.delete(
      Uri.parse('${apiUrl}/$id'),
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
}
