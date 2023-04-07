import 'package:attender/Data/attendaceData.dart';
import 'package:attender/Provider/subjectProvider.dart';
import 'package:attender/screens/subjectDetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Model/AttendanceModel.dart';

class AttendenceWidget extends StatefulWidget {
  final Function editSubject;
  final AttendanceModel attendence;
  final Function deleteSubject;
  const AttendenceWidget(
      {required this.attendence,
      required this.editSubject,
      required this.deleteSubject});

  @override
  State<AttendenceWidget> createState() => _AttendenceWidgetState();
}

class _AttendenceWidgetState extends State<AttendenceWidget> {
  int calculateReqClass(int totalClass, int attendedClass) {
    if (totalClass == 0) {
      return 0;
    }
    int a = ((attendedClass / totalClass) * 100).toInt();
    if (a >= 75) {
      return 0;
    } else {
      a = ((75 * totalClass - 100 * attendedClass) ~/ 25);
      return a;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SubjectDetailsScreen(
              attendance: widget.attendence,
              editSubject: widget.editSubject,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.25),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Lottie.asset(
                  (widget.attendence.subjectCode.toLowerCase().contains('cs'))
                      ? 'assets/json/cs.json'
                      : 'assets/json/ma.json',
                  height: 150,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    // boxShadow: [
                    //   BoxShadow(
                    //     blurRadius: 3,
                    //     spreadRadius: 3,
                    //     offset: Offset(0, 4),
                    //     color: Colors.black.withOpacity(0.25),
                    //   ),
                    // ],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(10),
                  // margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.attendence.subjectName,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.attendence.subjectCode,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "Attended : ${widget.attendence.attendedClasses}"),
                              Text("Total : ${widget.attendence.totalClasses}")
                              // IconButton(
                              //   icon: const Icon(Icons.done),
                              //   onPressed: () {},
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.cancel_sharp),
                              //   onPressed: () {},
                              // ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // maximumSize: MediaQuery.of(context).size * 25,
                                // minimumSize: MediaQuery.of(context).size * 0.25,
                                shadowColor: Colors.black,
                              ),
                              onPressed: () {
                                widget.attendence.totalClasses =
                                    widget.attendence.totalClasses + 1;
                                widget.attendence.attendedClasses =
                                    widget.attendence.attendedClasses + 1;
                                widget.editSubject(widget.attendence);
                                setState(() {});
                              },
                              child: const Text(
                                "YES",
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 50,
                              width: 160,
                              child: Center(
                                child: Text(
                                  (calculateReqClass(
                                            widget.attendence.totalClasses,
                                            widget.attendence.attendedClasses,
                                          ) ==
                                          0)
                                      ? "Great you already have 75% attendance"
                                      : "You have to attend next ${calculateReqClass(widget.attendence.totalClasses, widget.attendence.attendedClasses)} class to gain 75% attendence",
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // maximumSize: MediaQuery.of(context).size * 25,
                                // minimumSize: MediaQuery.of(context).size * 0.25,
                                shadowColor: Colors.black,
                              ),
                              onPressed: () {
                                widget.attendence.totalClasses =
                                    widget.attendence.totalClasses + 1;
                                widget.editSubject(widget.attendence);
                                setState(() {});
                              },
                              child: const Text(
                                "NO",
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(
                      //   "${((widget.attendence.attendedClasses / widget.attendence.totalClasses) * 100).roundToDouble()}",
                      //   style: const TextStyle(fontSize: 30, color: Colors.purple),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (widget.attendence.totalClasses == 0)
                    ? null
                    : Colors.purple[50],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                (widget.attendence.totalClasses == 0)
                    ? ""
                    : "${((widget.attendence.attendedClasses / widget.attendence.totalClasses) * 100).roundToDouble()}",
                style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 25,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          width: 400,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Are you sure?',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      String resText =
                                          await Provider.of<SubjectProvider>(
                                                  context,
                                                  listen: false)
                                              .deleteSubject(
                                        id: widget.attendence.id,
                                      );
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            resText,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                      setState(() {});
                                    },
                                    child: const Text(
                                      "YES",
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "NO",
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                // widget.deleteSubject(widget.attendence);
              },
            ),
          ),
        ],
      ),
    );
  }
}
