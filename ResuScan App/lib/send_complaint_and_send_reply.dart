import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const send_complaint_and_send_reply());
}

class send_complaint_and_send_reply extends StatelessWidget {
  const send_complaint_and_send_reply({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: send_complaint_and_send_reeplysub(),
    );
  }
}

class send_complaint_and_send_reeplysub extends StatefulWidget {
  const send_complaint_and_send_reeplysub({Key? key}) : super(key: key);

  @override
  State<send_complaint_and_send_reeplysub> createState() =>
      _send_complaint_and_send_reeplysubState();
}

class _send_complaint_and_send_reeplysubState
    extends State<send_complaint_and_send_reeplysub> {
  final TextEditingController sendComplaint = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    sendComplaint.dispose();
    super.dispose();
  }

  Future<void> _submitComplaint() async {
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
        Uri.parse("$ip/user_send_complaint"),
        body: {
          'complaint': sendComplaint.text.trim(),
          'uid': uid,
        },
      );

      var decoded = json.decode(response.body);

      if (decoded['status'] == 'ok') {
        _showSuccessDialog();
      } else {
        _showError("Failed to submit complaint");
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
                        "Submit a Complaint",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Describe your issue clearly and our team will review it.",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 30),
                      _buildComplaintField(),
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
            "Support Center",
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
            colors: [Colors.redAccent, Colors.deepOrange],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 25,
              spreadRadius: 5,
            ),
          ],
        ),
        child: const Icon(Icons.support_agent, size: 55, color: Colors.white),
      ),
    );
  }

  // ================= TEXT FIELD =================

  Widget _buildComplaintField() {
    return TextFormField(
      controller: sendComplaint,
      maxLines: 6,
      style: const TextStyle(color: Colors.white),
      validator: (v) =>
          v == null || v.trim().isEmpty ? "Complaint cannot be empty" : null,
      decoration: InputDecoration(
        labelText: "Describe your issue",
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
        onPressed: _isLoading ? null : _submitComplaint,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
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
                "SUBMIT COMPLAINT",
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
        title: const Text("Success", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Your complaint has been submitted successfully.",
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
                style: TextStyle(color: Colors.redAccent)),
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
                  const Text("OK", style: TextStyle(color: Colors.redAccent)))
        ],
      ),
    );
  }
}
