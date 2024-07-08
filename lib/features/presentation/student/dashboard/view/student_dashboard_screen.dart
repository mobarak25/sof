import 'package:flutter/material.dart';
import 'package:school_of_future/core/widgets/text.dart';

class StudentDhasboard extends StatelessWidget {
  const StudentDhasboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: TextB(text: "Student dashboard"),
        ),
      ),
    );
  }
}
