import 'package:ai_resume/attend_interview.dart';
import 'package:ai_resume/attend_mock_interview.dart';
import 'package:ai_resume/change_password.dart';
import 'package:ai_resume/send_complaint_and_send_reply.dart';
import 'package:ai_resume/send_feedback.dart';
import 'package:ai_resume/send_rating_or_review.dart';
import 'package:ai_resume/view_applied_list.dart';
import 'package:ai_resume/view_exam_date.dart';
import 'package:ai_resume/view_profile.dart';
import 'package:ai_resume/view_selected_list.dart';
import 'package:ai_resume/view_shortlisted_list.dart';
import 'package:ai_resume/view_vaccancy_and_request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class userhome extends StatelessWidget {
  const userhome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const userhome_sub();
  }
}

class userhome_sub extends StatefulWidget {
  const userhome_sub({Key? key}) : super(key: key);

  @override
  State<userhome_sub> createState() => _userhome_subState();
}

class _userhome_subState extends State<userhome_sub> {
  String username = "User";

  // ================= COLOR CONTROLLER =================

  // Scaffold & AppBar
  Color scaffoldBg = const Color(0xFF000000);
  Color appBarBg = const Color(0xFF000000);

  // Hero Card
  List<Color> heroGradient = [
    const Color(0xFF21262D),
    const Color(0xFF161B22),
  ];

  // Grid
  Color gridCardBg = const Color(0xFF1F2933);
  Color gridTextColor = Colors.white;

  // Drawer
  Color drawerBg = const Color(0xFF161B22);
  Color drawerHeaderBg = const Color(0xFF21262D);
  Color drawerTextColor = Colors.white;
  Color drawerIconColor = Colors.white;

  // ====================================================

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "User";
    });
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MyHomePage(title: "")),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: appBarBg,
        centerTitle: true,
        title: const Text(
          "CAREER DASHBOARD",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeroCard(),
            const SizedBox(height: 30),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              childAspectRatio: 1,
              children: [
                _card(
                    context,
                    "Vacancies",
                    Icons.work_outline,
                    Colors.blue,
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ViewVacancyPage()))),
                _card(
                    context,
                    "Applications",
                    Icons.list_alt,
                    Colors.orange,
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ViewAppliedList()))),
                _card(
                    context,
                    "Shortlisted",
                    Icons.thumb_up,
                    Colors.green,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ViewShortlistedList()))),
                _card(
                    context,
                    "Selected",
                    Icons.check_circle,
                    Colors.purple,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => view_selected_list()))),
                _card(
                    context,
                    "Exams",
                    Icons.calendar_today,
                    Colors.teal,
                    () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => view_exam_date()))),
                // _card(
                //     context,
                //     "Interview",
                //     Icons.video_call,
                //     Colors.redAccent,
                //     () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => AttendInterviewPage()))),
                _card(
                    context,
                    "Mock Interview",
                    Icons.smart_display,
                    Colors.deepOrange,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AttendMockInterviewPage()))),
                // _card(
                //     context,
                //     "Reviews",
                //     Icons.star,
                //     Colors.amber,
                //     () => Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) => send_rating_or_review()))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: heroGradient),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome, $username 👋",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          const Text(
            "Manage your career journey from one powerful dashboard.",
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, String title, IconData icon, Color color,
      VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: gridCardBg,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: gridTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: drawerBg,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            decoration: BoxDecoration(color: drawerHeaderBg),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 15),
                Text(username,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: drawerTextColor)),
              ],
            ),
          ),
          _drawerItem(context, "Profile", Icons.person, view_profile()),
          _drawerItem(
              context, "Change Password", Icons.lock, ChangePasswordPage()),
          _drawerItem(context, "Feedback", Icons.feedback, send_feedback()),
          _drawerItem(context, "Support", Icons.message,
              send_complaint_and_send_reply()),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: logout,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      leading: Icon(icon, color: drawerIconColor),
      title: Text(title, style: TextStyle(color: drawerTextColor)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}
