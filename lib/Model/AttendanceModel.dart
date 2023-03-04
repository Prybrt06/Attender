class AttendanceModel {
  String subjectName;
  String subjectCode;
  int totalClasses;
  int attendedClasses;

  AttendanceModel({
    required this.subjectName,
    required this.subjectCode,
    required this.totalClasses,
    required this.attendedClasses,
  });

  static fromJson(jsonData) {
    return AttendanceModel(
      subjectName: jsonData['subjectName'],
      subjectCode: jsonData['subjectCode'],
      totalClasses: jsonData['totalClasses'],
      attendedClasses: jsonData['attendedClasses'],
    );
  }

  Map<String, dynamic> toJson() => {
        'subjectName': subjectName,
        'subjectCode': subjectCode,
        'totalClasses': totalClasses,
        'attendedClasses': attendedClasses,
      };
}
