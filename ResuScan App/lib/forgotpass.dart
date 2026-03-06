import 'package:ai_resume/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class forgotpass extends StatefulWidget {
  const forgotpass({Key? key}) : super(key: key);

  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();

  bool _loading = false;
  bool _obscurePass = true;
  bool _obscureCpass = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pass.dispose();
    cpass.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    if (!_formKey.currentState!.validate()) return;

    if (pass.text != cpass.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      final ip = sh.getString("ip");

      if (ip == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Server not configured")),
        );
        return;
      }

      await http.post(
        Uri.parse("$ip/forgotpass"),
        body: {
          'email': sh.getString("email"),
          'password': pass.text,
        },
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => loginsub()),
        (route) => false,
      );
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
                      const SizedBox(height: 40),
                      _buildPasswordField(
                        controller: pass,
                        label: "New Password",
                        obscure: _obscurePass,
                        toggle: () {
                          setState(() {
                            _obscurePass = !_obscurePass;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildPasswordField(
                        controller: cpass,
                        label: "Confirm Password",
                        obscure: _obscureCpass,
                        toggle: () {
                          setState(() {
                            _obscureCpass = !_obscureCpass;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
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
            "Reset Password",
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
        Icons.lock_outline,
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
          "Create New Password",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Your new password must be secure",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // ---------- PASSWORD FIELD ----------

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: (v) =>
          v == null || v.length < 6 ? "Minimum 6 characters required" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff1e293b),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: toggle,
        ),
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
        onPressed: _loading ? null : _reset,
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
                "RESET PASSWORD",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
      ),
    );
  }
}
