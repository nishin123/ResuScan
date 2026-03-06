import 'dart:convert';
import 'package:ai_resume/edit_profile.dart';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const view_profile());
}

class view_profile extends StatelessWidget {
  const view_profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: view_profilesub(),
    );
  }
}

class view_profilesub extends StatefulWidget {
  const view_profilesub({Key? key}) : super(key: key);

  @override
  State<view_profilesub> createState() => _view_profilesubState();
}

class _view_profilesubState extends State<view_profilesub> {
  List<Joke> _profileData = [];
  bool _isLoading = true;
  bool _hasError = false;

  Future<void> _loadProfileData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String uid = prefs.getString("uid").toString();

      var response = await http.post(
        Uri.parse(prefs.getString("ip").toString() + "/user_view_profile"),
        body: {"id": uid},
      );

      var jsonData = json.decode(response.body);
      List<Joke> temp = [];

      for (var item in jsonData["data"]) {
        temp.add(Joke(
          item["id"].toString(),
          item["name"].toString(),
          item["place"].toString(),
          item["pin"].toString(),
          item["post"].toString(),
          item["email"].toString(),
          item["phone"].toString(),
        ));
      }

      setState(() {
        _profileData = temp;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_hasError || _profileData.isEmpty) {
      return const Center(
        child: Text("Unable to load profile"),
      );
    }

    var i = _profileData[0];

    return Stack(
      children: [
        /// 🔥 Top Gradient Background
        Container(
          height: 280,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              /// 🔙 Back Button
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
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: _loadProfileData,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 👤 Avatar + Name
              Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          blurRadius: 15,
                        )
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 60, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    i.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    i.post,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// 💎 Main Info Card
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      _infoTile(Icons.location_on, "Location",
                          "${i.place}, ${i.pin}"),

                      _infoTile(Icons.email, "Email", i.email),

                      _infoTile(Icons.phone, "Phone", i.phone),

                      const Spacer(),

                      /// ✏️ Edit Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => edit_profilesub(
                                  id: i.id,
                                  name: i.name,
                                  place: i.place,
                                  pin: i.pin,
                                  post: i.post,
                                  email: i.email,
                                  phone: i.phone,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: const Color(0xFF2A5298),
                          ),
                          child: const Text(
                            "EDIT PROFILE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFF2A5298).withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF2A5298)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Joke {
  final String id;
  final String name;
  final String place;
  final String pin;
  final String post;
  final String email;
  final String phone;

  Joke(this.id, this.name, this.place, this.pin, this.post, this.email,
      this.phone);
}
