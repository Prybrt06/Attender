import 'dart:convert';

import 'package:attender/Model/SubjectModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static SharedPreferences? _preferencs;

  Future<void> initPreferences() async {
    _preferencs = await SharedPreferences.getInstance();
  }

  String listKey = "attendenceList";

  String getAttendenceJsonString() {
    return _preferencs!.getString(listKey) ?? "";
  }

  void setToken(String token) {
    _preferencs!.setString('token', token);
  }

  String getToken() {
    return _preferencs!.getString('token') ?? "";
  }

  void removeToken() {
    _preferencs!.setString('token', "");
  }

  int getAttendence() {
    String attendanceString = getAttendenceJsonString();
    if (attendanceString == "") {
      return 0;
    }
    // print(attendanceString);
    List attendances = jsonDecode(attendanceString);

    // print(attendances);

    for (var attendance in attendances) {
      // attendences.add(AttendanceModel.fromJson(attendance));
    }

    return 1;
  }

  void saveAttendence(List<SubjectModel> attendence) {
    String jsonData = jsonEncode(attendence);
    _preferencs!.setString(listKey, jsonData);
  }
}
