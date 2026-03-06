import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttendMockInterviewPage extends StatelessWidget {
  const AttendMockInterviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MockInterviewScreen();
  }
}

class MockInterviewScreen extends StatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  List questions = [];
  Map<String, String> userAnswers = {};

  int currentIndex = 0;
  String? baseUrl;
  String? userLid;
  String? interviewId;

  bool isSubmitting = false;
  bool isLoading = true;
  bool noInterview = false;

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString("ip");
    userLid = prefs.getString("uid");
    await fetchMockInterview();
  }

  Future<void> fetchMockInterview() async {
    try {
      var url = Uri.parse("$baseUrl/get_mock_interview/");
      var res = await http.post(url, body: {"user_id": userLid ?? ""});
      var data = json.decode(res.body);

      if (data['success'] == true && data['questions'] != null) {
        setState(() {
          interviewId = data['interview_id'].toString();
          questions = data['questions'];

          if (questions.isEmpty) {
            noInterview = true;
          } else {
            answerController.text =
                userAnswers[questions[0]['id'].toString()] ?? "";
          }
          isLoading = false;
        });
      } else {
        setState(() {
          noInterview = true;
          isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        noInterview = true;
        isLoading = false;
      });
    }
  }

  Future<void> submitInterview() async {
    setState(() => isSubmitting = true);

    var res = await http.post(
      Uri.parse("$baseUrl/submit_mock_interview_answers/"),
      body: {
        "interview_id": interviewId ?? "",
        "answers": jsonEncode(userAnswers),
      },
    );

    var data = json.decode(res.body);
    setState(() => isSubmitting = false);

    if (data['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MockResultScreen(
            totalScore: data['total_score'],
            results: data['results'],
          ),
        ),
      );
    }
  }

  Future<bool> _confirmExit() async {
    bool? exit = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Exit Interview?"),
        content: const Text("Your progress will be lost."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Exit")),
        ],
      ),
    );
    return exit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (noInterview) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B0F1A),
          elevation: 0,
          title: const Text("Mock Interview"),
        ),
        body: _buildEmptyState(),
      );
    }

    var q = questions[currentIndex];

    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B0F1A),
          elevation: 0,
          title: const Text("Mock Interview"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _buildProgress(),
              const SizedBox(height: 30),
              _buildQuestionCard(q),
              const SizedBox(height: 20),
              Expanded(
                child: _buildAnswerBox(q),
              ),
              const SizedBox(height: 20),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: LinearProgressIndicator(
        minHeight: 8,
        value: (currentIndex + 1) / questions.length,
        backgroundColor: Colors.white12,
        valueColor: const AlwaysStoppedAnimation(Colors.indigoAccent),
      ),
    );
  }

  Widget _buildQuestionCard(q) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Text(
        "Q${currentIndex + 1}. ${q['question']}",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAnswerBox(q) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: TextField(
        controller: answerController,
        maxLines: null,
        expands: true,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          userAnswers[q['id'].toString()] = value;
        },
        decoration: const InputDecoration(
          hintText: "Write your answer clearly and professionally...",
          hintStyle: TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        if (currentIndex > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  currentIndex--;
                  answerController.text =
                      userAnswers[questions[currentIndex]['id'].toString()] ??
                          "";
                });
              },
              child: const Text("Previous"),
            ),
          ),
        if (currentIndex > 0) const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent),
            onPressed: currentIndex < questions.length - 1
                ? () {
                    setState(() {
                      currentIndex++;
                      answerController.text = userAnswers[
                              questions[currentIndex]['id'].toString()] ??
                          "";
                    });
                  }
                : (isSubmitting ? null : submitInterview),
            child: isSubmitting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : Text(currentIndex < questions.length - 1 ? "Next" : "Submit"),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.assignment_late, size: 80, color: Colors.white24),
          SizedBox(height: 20),
          Text(
            "No Mock Interview Found",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "Please check back later.",
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }
}

class MockResultScreen extends StatelessWidget {
  final int totalScore;
  final List results;

  const MockResultScreen(
      {super.key, required this.totalScore, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F1A),
        elevation: 0,
        title: const Text("Interview Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text(
                    "TOTAL SCORE",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$totalScore",
                    style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            results[index]['question'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Text(
                          "${results[index]['score']}/10",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
