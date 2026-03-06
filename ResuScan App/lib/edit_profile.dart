import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class edit_profilesub extends StatefulWidget {
  final String id;
  final String name;
  final String place;
  final String pin;
  final String post;
  final String email;
  final String phone;

  const edit_profilesub({
    Key? key,
    required this.id,
    required this.name,
    required this.place,
    required this.pin,
    required this.post,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  State<edit_profilesub> createState() => _edit_profilesubState();
}

class _edit_profilesubState extends State<edit_profilesub> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController post = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool _isEditing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    name.text = widget.name;
    place.text = widget.place;
    pin.text = widget.pin;
    post.text = widget.post;
    email.text = widget.email;
    phone.text = widget.phone;
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
                      _buildTextField("Full Name", name),
                      _buildTextField("Place", place),
                      _buildTextField("PIN Code", pin,
                          keyboard: TextInputType.number, validator: (value) {
                        if (value == null || value.length != 6) {
                          return "Enter valid 6-digit PIN";
                        }
                        return null;
                      }),
                      _buildTextField("Post", post),
                      _buildTextField("Email", email,
                          keyboard: TextInputType.emailAddress,
                          validator: (value) {
                        if (value == null ||
                            !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      }),
                      _buildTextField("Phone", phone,
                          keyboard: TextInputType.phone, validator: (value) {
                        if (value == null || value.length < 10) {
                          return "Enter valid phone number";
                        }
                        return null;
                      }),
                      const SizedBox(height: 30),
                      _isEditing ? _buildSaveButton() : _buildEditButton(),
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

  // ---------------- HEADER ----------------

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
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => userhome()),
              );
            },
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                "Manage your personal details",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ---------------- TEXT FIELD ----------------

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboard = TextInputType.text,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        enabled: _isEditing,
        keyboardType: keyboard,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: const Color(0xff1e293b),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ---------------- BUTTONS ----------------

  Widget _buildEditButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isEditing = true;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: const Text(
          "START EDITING",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "SAVE CHANGES",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  // ---------------- SAVE FUNCTION ----------------

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = await http.post(
      Uri.parse(prefs.getString("ip").toString() + '/user_edit_profile'),
      body: {
        'username': name.text,
        'place': place.text,
        'pin': pin.text,
        'post': post.text,
        'email': email.text,
        'phone': phone.text,
        'uid': prefs.getString('uid').toString()
      },
    );

    var decodedata = json.decode(data.body);

    if (decodedata['status'] == 'ok') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => userhome()),
      );
    }

    setState(() => _isLoading = false);
  }
}
