import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:ai_resume/userhome.dart';

class ViewVacancyPage extends StatefulWidget {
  @override
  State<ViewVacancyPage> createState() => _ViewVacancyPageState();
}

class _ViewVacancyPageState extends State<ViewVacancyPage> {
  late Future<List<Job>> _futureJobs;

  @override
  void initState() {
    super.initState();
    _futureJobs = fetchVacancies();
  }

  Future<List<Job>> fetchVacancies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await http.post(
      Uri.parse("${prefs.getString("ip")}/user_view_vaccancy_and_request"),
      body: {"id": prefs.getString("lid").toString()},
    );

    var jsonData = json.decode(response.body);
    List<Job> jobs = [];

    for (var item in jsonData["message"]) {
      jobs.add(Job(
        item["id"].toString(),
        item["job_title"].toString(),
        item["job_description"].toString(),
        item["required_skills"].toString(),
        item["experience"].toString(),
        item["salary_range"].toString(),
        item["fromdate"].toString(),
        item["todate"].toString(),
        item["applied"] == true ? "true" : "false",
        item["applied_date"].toString(),
        item["status"].toString(),
      ));
    }
    return jobs;
  }

  Future<void> applyJob(String jobId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      withData: true,
    );

    if (result == null) return;

    Uint8List? fileBytes = result.files.first.bytes;
    if (fileBytes == null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest(
        'POST', Uri.parse("${prefs.getString("ip")}/apply_job"));

    request.fields['job_id'] = jobId;
    request.fields['user_id'] = prefs.getString("uid").toString();

    request.files.add(
      http.MultipartFile.fromBytes(
        'resume',
        fileBytes,
        filename: result.files.first.name,
      ),
    );

    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    var jsonResp = json.decode(respStr);

    if (jsonResp["success"] == true || jsonResp["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Application submitted successfully"),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        _futureJobs = fetchVacancies();
      });
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "accepted":
        return Colors.green;
      case "rejected":
        return Colors.red;
      case "pending":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: FutureBuilder<List<Job>>(
        future: _futureJobs,
        builder: (context, snapshot) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              /// 🔥 Smooth Scrollable Gradient AppBar
              SliverAppBar(
                expandedHeight: 160,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => userhome()),
                    );
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    "Available Vacancies",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),

              /// Loading
              if (snapshot.connectionState == ConnectionState.waiting)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )

              /// Empty
              else if (!snapshot.hasData || snapshot.data!.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "No Vacancies Available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )

              /// Job List
              else
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var job = snapshot.data![index];
                        return _jobCard(job);
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _jobCard(Job job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  job.applied == "true"
                      ? "Applied on ${job.appliedDate}"
                      : "Not Applied Yet",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          /// Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _info("Description", job.description),
                _info("Skills", job.skills),
                _info("Experience", job.experience),
                _info("Salary", job.salary),
                _info("From", job.fromDate),
                _info("To", job.toDate),

                const SizedBox(height: 12),

                /// Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(job.status).withOpacity(.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job.status.toUpperCase(),
                    style: TextStyle(
                      color: getStatusColor(job.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                job.applied == "false"
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => applyJob(job.id),
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Apply Now"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "Already Applied",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _info(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          text: "$title: ",
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}

class Job {
  final String id;
  final String title;
  final String description;
  final String skills;
  final String experience;
  final String salary;
  final String fromDate;
  final String toDate;
  final String applied;
  final String appliedDate;
  final String status;

  Job(
    this.id,
    this.title,
    this.description,
    this.skills,
    this.experience,
    this.salary,
    this.fromDate,
    this.toDate,
    this.applied,
    this.appliedDate,
    this.status,
  );
}
