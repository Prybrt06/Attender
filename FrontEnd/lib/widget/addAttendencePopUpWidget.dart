import 'package:attender/Provider/subjectProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onPressed: () async {
                // attendences.add(attendence);
                String resText =
                    await Provider.of<SubjectProvider>(context, listen: false)
                        .addSubject(
                  subjectName: subjectController.text,
                  subjectCode: codeController.text,
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      resText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
