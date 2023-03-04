import 'package:attender/Model/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SubjectDetailsScreen extends StatefulWidget {
  final Function editSubject;
  final AttendanceModel attendance;
  const SubjectDetailsScreen({
    required this.attendance,
    required this.editSubject,
  });

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  void UpdateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.attendance.subjectName),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return EditPopUp(
                      attendence: widget.attendance,
                      editSubject: widget.editSubject,
                      update: UpdateScreen,
                    );
                  });
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Lottie.asset(
            widget.attendance.subjectCode.toLowerCase().contains('cs')
                ? 'assets/json/cs.json'
                : 'assets/json/ma.json',
          ),
        ),
      ),
    );
  }
}

class EditPopUp extends StatelessWidget {
  final AttendanceModel attendence;
  final Function editSubject;
  final VoidCallback update;
  const EditPopUp(
      {required this.attendence,
      required this.editSubject,
      required this.update});

  @override
  Widget build(BuildContext context) {
    TextEditingController subjectCodeCotroller = TextEditingController();
    subjectCodeCotroller.text = attendence.subjectCode;
    return AlertDialog(
      content: Container(
        height: 400,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              attendence.subjectName,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: subjectCodeCotroller,
              decoration: InputDecoration(
                labelText: 'Subject Code',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                AttendanceModel attendance = AttendanceModel(
                  subjectName: attendence.subjectName,
                  subjectCode: subjectCodeCotroller.text,
                  totalClasses: attendence.totalClasses,
                  attendedClasses: attendence.attendedClasses,
                );
                editSubject(attendance);
                Navigator.of(context).pop();
                update;
              },
              child: Text("Save"),
            ),
            // TextFormField(
            //   controller: subjectCodeCotroller,
            //   decoration: InputDecoration(
            //     labelText: 'Subject Code',
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
