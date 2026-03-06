import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ViewShortlistedList());
}

class ViewShortlistedList extends StatelessWidget {
  const ViewShortlistedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewShortlistedListSub(),
    );
  }
}

class ViewShortlistedListSub extends StatefulWidget {
  const ViewShortlistedListSub({Key? key}) : super(key: key);

  @override
  State<ViewShortlistedListSub> createState() => _ViewShortlistedListSubState();
}

class _ViewShortlistedListSubState extends State<ViewShortlistedListSub> {
  bool isLoading = true;
  List<ShortlistedJob> shortlistedJobs = [];

  @override
  void initState() {
    super.initState();
    fetchShortlisted();
  }

  Future<void> fetchShortlisted() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String baseUrl = prefs.getString("ip") ?? "";
      String userId = prefs.getString("lid") ?? "";

      var response = await http.post(
        Uri.parse("$baseUrl/user_view_shortlisted_list"),
        body: {"id": userId},
      );

      var data = json.decode(response.body);

      if (data["status"] == "ok") {
        List temp = data["message"];
        shortlistedJobs = temp.map((e) => ShortlistedJob.fromJson(e)).toList();
      }
    } catch (e) {}

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Stack(
        children: [
          /// 🔵 Gradient Header
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// 🔙 Back + Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => userhome()),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Shortlisted Jobs",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🟡 Info Banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.pending_actions, color: Colors.white),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "You are shortlisted! Final decision pending.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// 📄 Content Area
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : shortlistedJobs.isEmpty
                          ? const Center(
                              child: Text(
                                "No shortlisted jobs found",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: shortlistedJobs.length,
                              itemBuilder: (context, index) {
                                final job = shortlistedJobs[index];

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(.07),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Job Title
                                      Text(
                                        job.jobTitle,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      _row(Icons.calendar_today, job.date),
                                      _row(Icons.access_time, job.time),

                                      const SizedBox(height: 12),

                                      const Text(
                                        "Description",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(job.jobDescription),

                                      const SizedBox(height: 12),

                                      const Text(
                                        "Required Skills",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(job.requiredSkills),

                                      const SizedBox(height: 18),

                                      /// 🟢 Shortlisted Badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.withOpacity(.15),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Text(
                                          "Status: Shortlisted",
                                          style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _row(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////
// MODEL
//////////////////////////////////////////////////////////

class ShortlistedJob {
  final String id;
  final String jobTitle;
  final String jobDescription;
  final String requiredSkills;
  final String date;
  final String time;

  ShortlistedJob({
    required this.id,
    required this.jobTitle,
    required this.jobDescription,
    required this.requiredSkills,
    required this.date,
    required this.time,
  });

  factory ShortlistedJob.fromJson(Map<String, dynamic> json) {
    return ShortlistedJob(
      id: json["id"].toString(),
      jobTitle: json["job_title"] ?? "",
      jobDescription: json["job_description"] ?? "",
      requiredSkills: json["required_skills"] ?? "",
      date: json["date"] ?? "",
      time: json["time"] ?? "",
    );
  }
}
