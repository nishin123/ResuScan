import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot otp.dart';

class forgotemail extends StatefulWidget {
  const forgotemail({Key? key}) : super(key: key);

  @override
  State<forgotemail> createState() => _forgotemailState();
}

class _forgotemailState extends State<forgotemail> {
  final TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      final ip = sh.getString("ip");

      if (ip == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Server not configured")));
        return;
      }

      sh.setString("email", email.text);

      var res = await http.post(
        Uri.parse("$ip/forgotemail"),
        body: {'email': email.text},
      );

      var data = json.decode(res.body);

      if (data["status"] == "ok") {
        sh.setString("otpp", data["otpp"].toString());
        sh.setString("otp_generated_time", DateTime.now().toIso8601String());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => forgototp()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Email not found")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Connection error")));
    } finally {
      setState(() => _isLoading = false);
    }
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
                    children: [
                      const SizedBox(height: 40),
                      _buildIcon(),
                      const SizedBox(height: 30),
                      _buildTitle(),
                      const SizedBox(height: 30),
                      _buildEmailField(),
                      const SizedBox(height: 30),
                      _buildButton(),
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

  // ---------- HEADER ----------

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1e293b), Color(0xff334155)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 20),
          const Text(
            "Forgot Password",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // ---------- ICON ----------

  Widget _buildIcon() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.deepPurple],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.4),
            blurRadius: 25,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Icon(
        Icons.lock_reset,
        size: 55,
        color: Colors.white,
      ),
    );
  }

  // ---------- TITLE ----------

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          "Reset Your Password",
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Enter your registered email to receive OTP",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // ---------- EMAIL FIELD ----------

  Widget _buildEmailField() {
    return TextFormField(
      controller: email,
      style: const TextStyle(color: Colors.white),
      validator: (v) =>
          v == null || !v.contains("@") ? "Enter valid email" : null,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff1e293b),
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ---------- BUTTON ----------

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _sendOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigoAccent,
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
                "SEND OTP",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
      ),
    );
  }
}
