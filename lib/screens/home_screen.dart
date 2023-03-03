import 'package:flutter/material.dart';

import '../Data/attendaceData.dart';
import '../Model/AttendanceModel.dart';
import '../widget/addAttendencePopUpWidget.dart';
import '../widget/attendenceWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void addAttendence(AttendanceModel attendence) {
    setState(() {
      attendences.add(attendence);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attender"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddAttendacePopUp(addAttendence: addAttendence,);
            },
          );
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: ListView(
          // scrollDirection: Axis.vertical,
          children: attendences
              .map(
                (e) => AttendenceWidget(
                  attendence: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
