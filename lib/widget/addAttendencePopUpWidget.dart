import 'package:flutter/material.dart';

import '../Model/AttendanceModel.dart';

class AddAttendacePopUp extends StatelessWidget {
  final Function addAttendence;
  const AddAttendacePopUp({required this.addAttendence});

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectController = TextEditingController();
    TextEditingController codeController = TextEditingController();
    return AlertDialog(
      content: Container(
        height: 500,
        width: 400,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            TextFormField(
              controller: subjectController,
              decoration: const InputDecoration(
                hintText: "Enter subject name",
              ),
            ),
            TextFormField(
              controller: codeController,
              decoration: const InputDecoration(
                hintText: "Enter subject code",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                AttendanceModel attendence = AttendanceModel(
                  subjectName: subjectController.text,
                  subjectCode: codeController.text,
                  totalClasses: 0,
                  attendedClasses: 0,
                );

                // attendences.add(attendence);
                addAttendence(attendence);

                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
