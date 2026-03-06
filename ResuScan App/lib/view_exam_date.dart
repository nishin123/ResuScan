import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'attendexam.dart';

void main() {
  runApp(const view_exam_date());
}

class view_exam_date extends StatelessWidget {
  const view_exam_date({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: view_exam_datesub(),
    );
  }
}

class view_exam_datesub extends StatefulWidget {
  const view_exam_datesub({Key? key}) : super(key: key);

  @override
  State<view_exam_datesub> createState() => _view_exam_datesubState();
}

class _view_exam_datesubState extends State<view_exam_datesub> {
  Future<List<ExamModel>> _getExams() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid").toString();

    var response = await http.post(
      Uri.parse("${prefs.getString("ip")}/user_view_exam_date"),
      body: {"id": uid},
    );

    var jsonData = json.decode(response.body);

    List<ExamModel> exams = [];
    for (var item in jsonData["message"]) {
      exams.add(
        ExamModel(
          item["id"].toString(),
          item["date"].toString(),
          item["time"].toString(),
          item["venue"].toString(),
          item["job_title"].toString(),
          item["job_description"].toString(),
          item["required_skills"].toString(),
        ),
      );
    }

    return exams;
  }

  bool isExamToday(String examDate) {
    try {
      DateTime exam = DateTime.parse(examDate);
      DateTime now = DateTime.now();

      return exam.year == now.year &&
          exam.month == now.month &&
          exam.day == now.day;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff1e293b), Color(0xff334155)],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => userhome()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Exam Schedule",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            /// BODY
            Expanded(
              child: FutureBuilder<List<ExamModel>>(
                future: _getExams(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigoAccent,
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _emptyState();
                  }

                  final exams = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      bool canAttend = isExamToday(exam.date);
                      return _examCard(exam, canAttend);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _examCard(ExamModel exam, bool canAttend) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1e293b),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title + LIVE badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  exam.jobTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (canAttend)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "LIVE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),

          const SizedBox(height: 15),

          _detailRow(Icons.calendar_today, exam.date),
          _detailRow(Icons.access_time, exam.time),
          _detailRow(Icons.location_on, exam.venue),

          const SizedBox(height: 18),

          const Text(
            "Description",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            exam.jobDescription,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),

          const SizedBox(height: 15),

          const Text(
            "Required Skills",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            exam.requiredSkills,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),

          const SizedBox(height: 22),

          /// ACTION BUTTON
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: canAttend
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AttendExamScreen(vid: exam.id),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    canAttend ? Colors.green : Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                canAttend ? "Attend Exam" : "Exam Not Available Today",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.indigoAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available,
            size: 70,
            color: Colors.white24,
          ),
          SizedBox(height: 20),
          Text(
            "No Exams Scheduled",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            "Your upcoming exams will appear here.",
            style: TextStyle(color: Colors.white38),
          ),
        ],
      ),
    );
  }
}

class ExamModel {
  final String id;
  final String date;
  final String time;
  final String venue;
  final String jobTitle;
  final String jobDescription;
  final String requiredSkills;

  ExamModel(this.id, this.date, this.time, this.venue, this.jobTitle,
      this.jobDescription, this.requiredSkills);
}
