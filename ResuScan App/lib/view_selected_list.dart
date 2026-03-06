import 'dart:convert';
import 'package:ai_resume/send_rating_or_review.dart';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const view_selected_list());
}

class view_selected_list extends StatelessWidget {
  const view_selected_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: view_selected_listsub(),
    );
  }
}

class view_selected_listsub extends StatefulWidget {
  const view_selected_listsub({Key? key}) : super(key: key);

  @override
  State<view_selected_listsub> createState() => _view_selected_listsubState();
}

class _view_selected_listsubState extends State<view_selected_listsub> {
  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid").toString();

    var response = await http.post(
      Uri.parse(prefs.getString("ip").toString() + "/user_view_selected_list"),
      body: {"id": uid},
    );

    var jsonData = json.decode(response.body);
    List<Joke> list = [];

    for (var item in jsonData["message"]) {
      list.add(Joke(
        item["id"].toString(),
        item["date"].toString(),
        item["time"].toString(),
        item["venue"].toString(),
        item["job_title"].toString(),
        item["job_description"].toString(),
        item["required_skill"].toString(),
        item["cid"].toString(),
      ));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Stack(
        children: [
          /// 🔵 Top Gradient Header
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// 🔙 Back Button + Title
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
                            MaterialPageRoute(builder: (context) => userhome()),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Selected List",
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

                /// 🎉 Success Banner
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.emoji_events, color: Colors.white),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Congratulations! You’ve been selected 🎉",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// 📄 Content
                Expanded(
                  child: FutureBuilder<List<Joke>>(
                    future: _getJokes(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "No selected records found",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var i = snapshot.data![index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Job Title
                                Text(
                                  i.job_title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                _row(Icons.calendar_today, i.date),
                                _row(Icons.access_time, i.time),
                                _row(Icons.location_on, i.venue),

                                const SizedBox(height: 15),

                                const Text(
                                  "Description",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(i.job_description),

                                const SizedBox(height: 15),

                                const Text(
                                  "Required Skills",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 5),
                                Text(i.required_skill),

                                const SizedBox(height: 20),

                                /// Review Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF11998E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const send_rating_or_review(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "GIVE REVIEW",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
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

class Joke {
  final String id;
  final String date;
  final String time;
  final String venue;
  final String job_title;
  final String job_description;
  final String required_skill;
  final String cid;

  Joke(this.id, this.date, this.time, this.venue, this.job_title,
      this.job_description, this.required_skill, this.cid);
}
