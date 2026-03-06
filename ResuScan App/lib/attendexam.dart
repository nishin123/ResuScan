import 'dart:async';
import 'dart:convert';
import 'package:ai_resume/view_exam_date.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AttendExamPage extends StatelessWidget {
  final String? vid;
  const AttendExamPage({Key? key, this.vid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AttendExamScreen(vid: vid);
  }
}

class AttendExamScreen extends StatefulWidget {
  final String? vid;
  const AttendExamScreen({Key? key, this.vid}) : super(key: key);

  @override
  State<AttendExamScreen> createState() => _AttendExamScreenState();
}

class _AttendExamScreenState extends State<AttendExamScreen> {
  List<ExamQuestion> questions = [];
  Map<String, String> userAnswers = {};

  int currentIndex = 0;
  int timeRemaining = 3600;
  Timer? timer;

  String? baseUrl;
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    baseUrl = prefs.getString("ip");
    userId = prefs.getString("uid");
    await fetchQuestions();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeRemaining > 0) {
        setState(() => timeRemaining--);
      } else {
        t.cancel();
        submitExam();
      }
    });
  }

  Future<void> fetchQuestions() async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/get_exam_questions"),
        body: {"request_id": widget.vid!},
      );

      var data = json.decode(response.body);

      if (data['success'] == true && data['questions'] != null) {
        List<ExamQuestion> loadedQuestions = [];

        for (var q in data['questions']) {
          loadedQuestions.add(
            ExamQuestion(
              id: q['id'].toString(),
              question: q['question'].toString(),
              options: List<String>.from(q['options']),
            ),
          );
        }

        setState(() {
          questions = loadedQuestions;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  Future<void> submitExam() async {
    timer?.cancel();

    var response = await http.post(
      Uri.parse("$baseUrl/submit_exam_answers"),
      body: {
        "request_id": widget.vid!,
        "user_id": userId!,
        "answers": jsonEncode(userAnswers),
      },
    );

    var data = json.decode(response.body);

    if (data['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ExamResultScreen(
            totalScore: data['total_score'] ?? 0,
            correctCount: data['correct_count'] ?? 0,
            totalQuestions: data['total_questions'] ?? 0,
            results: data['results'] ?? [],
          ),
        ),
      );
    }
  }

  String formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  Future<bool> _confirmExit() async {
    bool? exit = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Exit Exam?"),
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

    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(
          child: Text("No questions found",
              style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    ExamQuestion q = questions[currentIndex];

    return WillPopScope(
      onWillPop: _confirmExit,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0F1A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0B0F1A),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () async {
              if (await _confirmExit()) {
                Navigator.pop(context);
              }
            },
          ),
          title: const Text("Exam Session"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${currentIndex + 1}/${questions.length}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  _buildTimer(),
                ],
              ),

              const SizedBox(height: 20),

              LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                minHeight: 6,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation(Colors.indigoAccent),
              ),

              const SizedBox(height: 30),

              _buildQuestionCard(q),

              const SizedBox(height: 25),

              Expanded(child: _buildOptions(q)),

              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimer() {
    bool danger = timeRemaining < 300;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        gradient: danger
            ? const LinearGradient(colors: [Colors.red, Colors.deepOrange])
            : const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        formatTime(timeRemaining),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildQuestionCard(ExamQuestion q) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        q.question,
        style: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildOptions(ExamQuestion q) {
    return ListView.builder(
      itemCount: q.options.length,
      itemBuilder: (_, i) {
        String opt = q.options[i];
        bool selected = userAnswers[q.id] == opt;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)])
                : null,
            color: selected ? null : const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            onTap: () => setState(() => userAnswers[q.id] = opt),
            leading: Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: Colors.white,
            ),
            title: Text(opt, style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      children: [
        if (currentIndex > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() => currentIndex--),
              child: const Text("Previous"),
            ),
          ),
        if (currentIndex > 0) const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: currentIndex < questions.length - 1
                ? () => setState(() => currentIndex++)
                : submitExam,
            style: ElevatedButton.styleFrom(
              backgroundColor: currentIndex == questions.length - 1
                  ? Colors.green
                  : Colors.indigoAccent,
            ),
            child: Text(
                currentIndex < questions.length - 1 ? "Next" : "Submit Exam"),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

class ExamQuestion {
  final String id;
  final String question;
  final List<String> options;

  ExamQuestion({
    required this.id,
    required this.question,
    required this.options,
  });
}

class ExamResultScreen extends StatelessWidget {
  final int totalScore;
  final int correctCount;
  final int totalQuestions;
  final List results;

  const ExamResultScreen({
    required this.totalScore,
    required this.correctCount,
    required this.totalQuestions,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    double percentage =
        totalQuestions > 0 ? (correctCount / totalQuestions) * 100 : 0;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => view_exam_date()),
            );
          },
        ),
        title: const Text("Exam Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score: $totalScore",
                style: const TextStyle(fontSize: 28, color: Colors.white)),
            const SizedBox(height: 10),
            Text("Accuracy: ${percentage.toStringAsFixed(1)}%",
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => view_exam_date()),
                );
              },
              child: const Text("Back to Exams"),
            )
          ],
        ),
      ),
    );
  }
}
