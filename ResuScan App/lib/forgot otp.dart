import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'forgotpass.dart';

class forgototp extends StatefulWidget {
  const forgototp({Key? key}) : super(key: key);

  @override
  State<forgototp> createState() => _forgototpState();
}

class _forgototpState extends State<forgototp> {
  List<TextEditingController> otp =
      List.generate(6, (_) => TextEditingController());

  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool _loading = false;

  @override
  void dispose() {
    for (var c in otp) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String getOtp() => otp.map((e) => e.text).join();

  Future<void> _verifyOtp() async {
    String enteredOtp = getOtp();

    if (enteredOtp.length != 6) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Enter 6 digit OTP")));
      return;
    }

    setState(() => _loading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      final ip = sh.getString("ip");
      final savedOtp = sh.getString("otpp");

      if (ip == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Server not configured")));
        return;
      }

      await http.post(
        Uri.parse("$ip/forgototp"),
        body: {'otp': enteredOtp},
      );

      if (enteredOtp == savedOtp) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => forgotpass()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Invalid OTP")));
      }
    } finally {
      setState(() => _loading = false);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildIcon(),
                  const SizedBox(height: 30),
                  _buildTitle(),
                  const SizedBox(height: 40),
                  _buildOtpFields(),
                  const SizedBox(height: 40),
                  _buildVerifyButton(),
                ],
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
            "Verify OTP",
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
        Icons.verified_user,
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
          "Enter Verification Code",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "We sent a 6-digit OTP to your email",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // ---------- OTP INPUT ----------

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
        (i) => Container(
          width: 48,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: otp[i],
            focusNode: focusNodes[i],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: const Color(0xff1e293b),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && i < 5) {
                FocusScope.of(context).requestFocus(focusNodes[i + 1]);
              }
              if (value.isEmpty && i > 0) {
                FocusScope.of(context).requestFocus(focusNodes[i - 1]);
              }
            },
          ),
        ),
      ),
    );
  }

  // ---------- BUTTON ----------

  Widget _buildVerifyButton() {
    return SizedBox(
      width: 220,
      height: 55,
      child: ElevatedButton(
        onPressed: _loading ? null : _verifyOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: _loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : const Text(
                "VERIFY",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
      ),
    );
  }
}
