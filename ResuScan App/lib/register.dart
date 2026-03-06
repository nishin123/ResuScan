import 'dart:convert';

import 'package:ai_resume/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const register());
}

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: registersub(),
    );
  }
}

class registersub extends StatefulWidget {
  const registersub({Key? key}) : super(key: key);

  @override
  State<registersub> createState() => _registersubState();
}

class _registersubState extends State<registersub> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final place = TextEditingController();
  final pin = TextEditingController();
  final post = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool _isLoading = false;
  bool _passVisible = false;
  bool _confirmVisible = false;

  @override
  void dispose() {
    name.dispose();
    place.dispose();
    pin.dispose();
    post.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final ip = prefs.getString("ip");

      if (ip == null) {
        _showError("Server not configured");
        return;
      }

      var response = await http.post(
        Uri.parse("$ip/user_register"),
        body: {
          'username': name.text.trim(),
          'place': place.text.trim(),
          'pin': pin.text.trim(),
          'post': post.text.trim(),
          'email': email.text.trim(),
          'phone': phone.text.trim(),
          'pwd': password.text.trim(),
        },
      );

      var decoded = json.decode(response.body);

      if (decoded['status'] == 'ok') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const login()),
        );
      } else {
        _showError("Registration failed");
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
                    children: [
                      _buildIcon(),
                      const SizedBox(height: 30),
                      _buildTitle(),
                      const SizedBox(height: 40),
                      _buildField(name, "Full Name", Icons.person),
                      const SizedBox(height: 20),
                      _buildField(place, "Place", Icons.location_on),
                      const SizedBox(height: 20),
                      _buildField(pin, "PIN Code", Icons.pin,
                          keyboard: TextInputType.number),
                      const SizedBox(height: 20),
                      _buildField(post, "Post", Icons.mail),
                      const SizedBox(height: 20),
                      _buildField(email, "Email", Icons.email,
                          keyboard: TextInputType.emailAddress, validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Email required";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(v)) {
                          return "Enter valid email";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildField(phone, "Phone", Icons.phone,
                          keyboard: TextInputType.phone, validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Phone required";
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
                          return "Enter valid 10-digit phone";
                        }
                        return null;
                      }),
                      const SizedBox(height: 20),
                      _buildPasswordField(
                          controller: password,
                          label: "Password",
                          visible: _passVisible,
                          toggle: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          }),
                      const SizedBox(height: 20),
                      _buildPasswordField(
                          controller: confirmPassword,
                          label: "Confirm Password",
                          visible: _confirmVisible,
                          toggle: () {
                            setState(() {
                              _confirmVisible = !_confirmVisible;
                            });
                          },
                          validator: (v) {
                            if (v != password.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          }),
                      const SizedBox(height: 40),
                      _buildRegisterButton(),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const login()),
                          );
                        },
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(color: Colors.indigoAccent),
                        ),
                      )
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1e293b), Color(0xff334155)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: const Row(
        children: [
          Text(
            "Create Account",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // ================= ICON =================

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
      child: const Icon(Icons.person_add, size: 55, color: Colors.white),
    );
  }

  // ================= TITLE =================

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          "Register New Account",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Fill in your details to continue",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  // ================= GENERIC FIELD =================

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.white),
      validator:
          validator ?? (v) => v == null || v.isEmpty ? "$label required" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= PASSWORD FIELD =================

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool visible,
    required VoidCallback toggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !visible,
      style: const TextStyle(color: Colors.white),
      validator: validator ??
          (v) => v == null || v.length < 6 ? "Minimum 6 characters" : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: toggle,
        ),
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= BUTTON =================

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _register,
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
                "REGISTER",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
      ),
    );
  }

  // ================= ERROR =================

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff1e293b),
        title: const Text("Error", style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK",
                  style: TextStyle(color: Colors.indigoAccent)))
        ],
      ),
    );
  }
}
