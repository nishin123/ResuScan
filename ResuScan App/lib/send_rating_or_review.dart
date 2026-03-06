import 'dart:convert';
import 'package:ai_resume/userhome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const send_rating_or_review());
}

class send_rating_or_review extends StatelessWidget {
  const send_rating_or_review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: send_rating_or_reviewsub(),
    );
  }
}

class send_rating_or_reviewsub extends StatefulWidget {
  const send_rating_or_reviewsub({Key? key}) : super(key: key);

  @override
  State<send_rating_or_reviewsub> createState() =>
      _send_rating_or_reviewsubState();
}

class _send_rating_or_reviewsubState extends State<send_rating_or_reviewsub> {
  final TextEditingController reviews = TextEditingController();
  final TextEditingController rating = TextEditingController();

  double _currentRating = 0.0;
  bool _isLoading = false;

  List companyList = [];
  String selectedCompanyId = "";
  List myReviews = [];

  @override
  void initState() {
    super.initState();
    loadCompanies();
    loadMyReviews();
  }

  loadCompanies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await http.get(
      Uri.parse("${prefs.getString("ip")}/user_view_companies"),
    );

    var decodedata = json.decode(data.body);
    if (decodedata['status'] == "ok") {
      setState(() {
        companyList = decodedata['data'];
      });
    }
  }

  loadMyReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await http.post(
      Uri.parse("${prefs.getString("ip")}/user_view_my_reviews"),
      body: {'uid': prefs.getString("uid").toString()},
    );

    var decodedata = json.decode(data.body);
    if (decodedata['status'] == "ok") {
      setState(() {
        myReviews = decodedata['data'];
      });
    }
  }

  Future<void> _submitReview() async {
    if (selectedCompanyId == "") {
      _showError("Please select a company");
      return;
    }

    if (_currentRating == 0) {
      _showError("Please select a rating");
      return;
    }

    if (reviews.text.trim().isEmpty) {
      _showError("Please enter your review");
      return;
    }

    setState(() => _isLoading = true);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = await http.post(
      Uri.parse("${prefs.getString("ip")}/user_send_rating_or_review"),
      body: {
        'review': reviews.text.trim(),
        'rating': _currentRating.toString(),
        'uid': prefs.getString("uid").toString(),
        'cid': selectedCompanyId,
      },
    );

    var decodedata = json.decode(data.body);

    if (decodedata['status'] == 'ok') {
      reviews.clear();
      rating.clear();
      setState(() {
        _currentRating = 0;
      });
      loadMyReviews();
    } else {
      _showError("Submission failed");
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCompanyDropdown(),
                    const SizedBox(height: 30),
                    _buildRatingSection(),
                    const SizedBox(height: 30),
                    _buildReviewField(),
                    const SizedBox(height: 30),
                    _buildSubmitButton(),
                    const SizedBox(height: 40),
                    const Text(
                      "My Reviews",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    _buildReviewList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            "Rate & Review",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildCompanyDropdown() {
    return DropdownButtonFormField(
      dropdownColor: const Color(0xff1e293b),
      decoration: InputDecoration(
        labelText: "Select Company",
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      items: companyList.map((e) {
        return DropdownMenuItem(
          value: e['id'].toString(),
          child: Text(
            e['name'],
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          selectedCompanyId = val.toString();
        });
      },
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Rating",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () {
                setState(() {
                  _currentRating = (index + 1).toDouble();
                });
              },
              icon: Icon(
                index < _currentRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 40,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReviewField() {
    return TextField(
      controller: reviews,
      maxLines: 4,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Write your review",
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xff1e293b),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitReview,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                "SUBMIT REVIEW",
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
      ),
    );
  }

  Widget _buildReviewList() {
    if (myReviews.isEmpty) {
      return const Text(
        "No reviews yet.",
        style: TextStyle(color: Colors.white70),
      );
    }

    return Column(
      children: myReviews.map((e) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff1e293b),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e['company'],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  int.parse(e['rating']),
                  (index) =>
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                e['review'],
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 6),
              Text(
                e['date'],
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

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
              child: const Text("OK",
                  style: TextStyle(color: Colors.indigoAccent)))
        ],
      ),
    );
  }
}
