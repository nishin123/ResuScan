import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ViewAppliedList());
}

class ViewAppliedList extends StatelessWidget {
  const ViewAppliedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewAppliedListSub(),
    );
  }
}

class ViewAppliedListSub extends StatefulWidget {
  const ViewAppliedListSub({Key? key}) : super(key: key);

  @override
  State<ViewAppliedListSub> createState() => _ViewAppliedListSubState();
}

class _ViewAppliedListSubState extends State<ViewAppliedListSub> {
  Future<List<ApplicationModel>> fetchAppliedJobs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse("${prefs.getString("ip")}/user_view_applied_list"),
      body: {"uid": prefs.getString("uid")},
    );

    var jsonData = json.decode(response.body);

    List<ApplicationModel> list = [];

    for (var item in jsonData["message"]) {
      list.add(
        ApplicationModel(
          id: item["id"].toString(),
          date: item["date"].toString(),
          time: item["time"].toString(),
          jobTitle: item["job_title"].toString(),
          jobDescription: item["job_description"].toString(),
          requiredSkills: item["required_skills"].toString(),
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔷 HEADER
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
                    "My Applications",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            /// 🔷 BODY
            Expanded(
              child: FutureBuilder<List<ApplicationModel>>(
                future: fetchAppliedJobs(),
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

                  final jobs = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return _applicationCard(job);
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

  /// 🔷 APPLICATION CARD
  Widget _applicationCard(ApplicationModel job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1e293b),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            job.jobTitle,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          /// Date + Time
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 16, color: Colors.indigoAccent),
              const SizedBox(width: 6),
              Text(
                job.date,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(width: 20),
              const Icon(Icons.access_time,
                  size: 16, color: Colors.indigoAccent),
              const SizedBox(width: 6),
              Text(
                job.time,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// Description
          const Text(
            "Job Description",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            job.jobDescription,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),

          const SizedBox(height: 15),

          /// Skills
          const Text(
            "Required Skills",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            job.requiredSkills,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }

  /// 🔷 EMPTY STATE
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.work_outline,
            size: 70,
            color: Colors.white24,
          ),
          SizedBox(height: 20),
          Text(
            "No Applications Found",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            "Start applying to jobs to see them here.",
            style: TextStyle(color: Colors.white38),
          ),
        ],
      ),
    );
  }
}

class ApplicationModel {
  final String id;
  final String date;
  final String time;
  final String jobTitle;
  final String jobDescription;
  final String requiredSkills;

  ApplicationModel({
    required this.id,
    required this.date,
    required this.time,
    required this.jobTitle,
    required this.jobDescription,
    required this.requiredSkills,
  });
}
