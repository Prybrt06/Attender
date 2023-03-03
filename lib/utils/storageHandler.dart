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

  void getAttendence() {
    String attendanceString = _preferencs!.getString(listKey)!;
    List attendances = jsonDecode(attendanceString);

    for (var attendance in attendances) {
      attendences.add(AttendanceModel.fromJson(attendance));
    }
  }

  void saveAttendence() {}
}
