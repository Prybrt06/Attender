import 'dart:convert';

import 'package:attender/Data/attendaceData.dart';
import 'package:attender/Model/AttendanceModel.dart';
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

  int getAttendence() {
    String attendanceString = getAttendenceJsonString();
    if (attendanceString == "") {
      return 0;
    }
    // print(attendanceString);
    List attendances = jsonDecode(attendanceString);

    // print(attendances);

    for (var attendance in attendances) {
      attendences.add(AttendanceModel.fromJson(attendance));
    }

    return 1;
  }

  void saveAttendence(List<AttendanceModel> attendence) {
    String jsonData = jsonEncode(attendence);
    _preferencs!.setString(listKey, jsonData);
  }
}
