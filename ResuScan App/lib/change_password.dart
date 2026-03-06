import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChangePasswordScreen();
  }
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController current_password = TextEditingController();
  final TextEditingController new_password = TextEditingController();
  final TextEditingController confirm_password = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => userhome()),
            );
          },
        ),
        title: const Text("Security Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Change Password",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Protect your account with a strong password",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 40),
            _buildField(
              controller: current_password,
              label: "Current Password",
              obscure: obscureCurrent,
              toggle: () => setState(() => obscureCurrent = !obscureCurrent),
            ),
            const SizedBox(height: 25),
            _buildField(
              controller: new_password,
              label: "New Password",
              obscure: obscureNew,
              toggle: () => setState(() => obscureNew = !obscureNew),
            ),
            const SizedBox(height: 25),
            _buildField(
              controller: confirm_password,
              label: "Confirm Password",
              obscure: obscureConfirm,
              toggle: () => setState(() => obscureConfirm = !obscureConfirm),
            ),
            const SizedBox(height: 40),
            const Text(
              "Password must:",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            const Text("• Be at least 8 characters",
                style: TextStyle(color: Colors.white54)),
            const Text("• Include uppercase & lowercase",
                style: TextStyle(color: Colors.white54)),
            const Text("• Include numbers & symbols",
                style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handlePasswordChange,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "UPDATE PASSWORD",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              suffixIcon: IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: toggle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handlePasswordChange() async {
    setState(() => isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String current = current_password.text.trim();
    String newPass = new_password.text.trim();
    String confirm = confirm_password.text.trim();

    // Validate current password
    if (prefs.getString("password").toString() != current) {
      _showError("Invalid current password");
      setState(() => isLoading = false);
      return;
    }

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      _showError("All fields are required");
      setState(() => isLoading = false);
      return;
    }

    if (newPass.length < 8) {
      _showError("Password must be at least 8 characters long");
      setState(() => isLoading = false);
      return;
    }

    if (!RegExp(r'[A-Z]').hasMatch(newPass)) {
      _showError("Include at least one uppercase letter");
      setState(() => isLoading = false);
      return;
    }

    if (!RegExp(r'[a-z]').hasMatch(newPass)) {
      _showError("Include at least one lowercase letter");
      setState(() => isLoading = false);
      return;
    }

    if (!RegExp(r'[0-9]').hasMatch(newPass)) {
      _showError("Include at least one number");
      setState(() => isLoading = false);
      return;
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPass)) {
      _showError("Include at least one special character");
      setState(() => isLoading = false);
      return;
    }

    if (newPass == current) {
      _showError("New password must be different from current password");
      setState(() => isLoading = false);
      return;
    }

    if (newPass != confirm) {
      _showError("New password and confirm password do not match");
      setState(() => isLoading = false);
      return;
    }

    var data = await http.post(
      Uri.parse(prefs.getString("ip").toString() + '/user_change_password'),
      body: {
        'current_password': current,
        'new_password': newPass,
        'confirm_password': confirm,
        'uid': prefs.getString('uid').toString()
      },
    );

    var decodedata = json.decode(data.body);

    if (decodedata['status'] == 'ok') {
      _showSuccess();
    } else {
      _showError("Password update failed. Try again.");
    }

    setState(() => isLoading = false);
  }

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Error", style: TextStyle(color: Colors.white)),
        content: Text(msg, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Success", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Password updated successfully",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => login()),
              );
            },
            child: const Text("Go to Login"),
          )
        ],
      ),
    );
  }
}
