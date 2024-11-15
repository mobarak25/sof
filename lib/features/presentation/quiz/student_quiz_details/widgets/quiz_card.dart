import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/quiz_details_for_student_response.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(
      {super.key,
      required this.title,
      required this.subject,
      required this.startTime,
      required this.endTime});
  final String title, startTime, endTime;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 190),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFF37BFD7), Color(0XFF17799C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextB(
              text: title,
              textStyle: bHead5B,
              fontColor: bWhite,
              fontHeight: 1.2,
              alignMent: TextAlign.center,
            ),
            const Gap(15),
            Container(
              width: 65,
              height: 5,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const Gap(20),
            TextB(
              text: "Class: ${subject.subjectClass!.name}",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            TextB(
              text: "Subject: ${subject.name}",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            TextB(
              text:
                  "Start Time: ${getDate(value: startTime, formate: 'yyyy-MM-dd hh:mma')}",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            TextB(
              text:
                  "End Time: ${getDate(value: endTime, formate: 'yyyy-MM-dd hh:mma')}",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
          ],
        ),
      ),
    );
    // Title and Subtitle
  }
}

// Custom Clipper for Curved Background
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
