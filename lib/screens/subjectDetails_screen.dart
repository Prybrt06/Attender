import 'package:attender/Data/attendaceData.dart';
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

class EditPopUp extends StatefulWidget {
  final AttendanceModel attendence;
  final Function editSubject;
  final VoidCallback update;
  EditPopUp({
    required this.attendence,
    required this.editSubject,
    required this.update,
  });

  @override
  State<EditPopUp> createState() => _EditPopUpState();
}

class _EditPopUpState extends State<EditPopUp> {
  void incTotalClass(AttendanceModel at) {
    setState(() {
      at.totalClasses++;
    });
  }

  void decTotalClass(AttendanceModel at) {
    setState(() {
      at.totalClasses--;
    });
  }

  void incAttendedClass(AttendanceModel at) {
    setState(() {
      at.attendedClasses++;
    });
  }

  void decAttendedClass(AttendanceModel at) {
    setState(() {
      at.attendedClasses--;
    });
  }

  // var totalClass = 1;
  @override
  Widget build(BuildContext context) {
    TextEditingController subjectCodeCotroller = TextEditingController();
    subjectCodeCotroller.text = widget.attendence.subjectCode;
    return AlertDialog(
      content: Container(
        height: 400,
        width: 420,
        // padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.attendence.subjectName,
              style: TextStyle(
                fontSize: 30,
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
            Text('Total Class'),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    incTotalClass(widget.attendence);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(widget.attendence.totalClasses.toString()),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    decTotalClass(widget.attendence);
                  },
                  child: Icon(
                    Icons.remove,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text('Attended Class'),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    incAttendedClass(widget.attendence);
                  },
                  child: Icon(
                    Icons.add,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(widget.attendence.attendedClasses.toString()),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    decAttendedClass(widget.attendence);
                  },
                  child: Icon(
                    Icons.remove,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                AttendanceModel attendance = AttendanceModel(
                  id: widget.attendence.id,
                  subjectName: widget.attendence.subjectName,
                  subjectCode: subjectCodeCotroller.text,
                  totalClasses: widget.attendence.totalClasses,
                  attendedClasses: widget.attendence.attendedClasses,
                );
                widget.editSubject(attendance);
                Navigator.of(context).pop();
                widget.update;
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 20),
              ),
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
