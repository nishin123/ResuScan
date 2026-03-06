import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const send_feedback());
}

class send_feedback extends StatelessWidget {
  const send_feedback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: send_feedbacksub(),
    );
  }
}

class send_feedbacksub extends StatefulWidget {
  const send_feedbacksub({Key? key}) : super(key: key);

  @override
  State<send_feedbacksub> createState() => _send_feedbacksubState();
}

class _send_feedbacksubState extends State<send_feedbacksub> {
  final TextEditingController feedback = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    feedback.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString("ip");
      final uid = prefs.getString("uid");

      if (ip == null || uid == null) {
        _showError("Session expired. Please login again.");
        return;
      }

      var response = await http.post(
        Uri.parse("$ip/user_send_feedback"),
        body: {
          'feedback': feedback.text.trim(),
          'uid': uid,
        },
      );

      var decoded = json.decode(response.body);

      if (decoded['status'] == 'ok') {
        _showSuccessDialog();
      } else {
        _showError("Failed to submit feedback");
      }
    } catch (e) {
      _showError("Connection error");
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIcon(),
                      const SizedBox(height: 30),
                      const Text(
                        "Share Your Feedback",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Help us improve your experience by sharing your thoughts.",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 30),
                      _buildFeedbackField(),
                      const SizedBox(height: 40),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1e293b), Color(0xff334155)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
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
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            "Feedback",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  // ================= ICON =================

  Widget _buildIcon() {
    return Center(
      child: Container(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.tealAccent, Colors.teal],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.4),
              blurRadius: 25,
              spreadRadius: 5,
            ),
          ],
        ),
        child: const Icon(Icons.feedback, size: 55, color: Colors.white),
      ),
    );
  }

  // ================= FIELD =================

  Widget _buildFeedbackField() {
    return TextFormField(
      controller: feedback,
      maxLines: 6,
      style: const TextStyle(color: Colors.white),
      validator: (v) =>
          v == null || v.trim().isEmpty ? "Feedback cannot be empty" : null,
      decoration: InputDecoration(
        labelText: "Write your feedback",
        labelStyle: const TextStyle(color: Colors.white70),
        alignLabelWithHint: true,
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= BUTTON =================

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitFeedback,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Text(
                "SUBMIT FEEDBACK",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
      ),
    );
  }

  // ================= SUCCESS =================

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xff1e293b),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Thank You!", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Your feedback has been submitted successfully.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => userhome()),
              );
            },
            child: const Text("Back to Home",
                style: TextStyle(color: Colors.tealAccent)),
          )
        ],
      ),
    );
  }

  // ================= ERROR =================

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xff1e293b),
        title: const Text("Error", style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("OK", style: TextStyle(color: Colors.tealAccent)))
        ],
      ),
    );
  }
}
