import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key});

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
            const TextB(
              text: "Newton's Law & its application",
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
            const TextB(
              text: "Morning Class IX - Mars",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            const TextB(
              text: "Subject: Physics",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            const TextB(
              text: "Start Time: 11/08/2021 10:30am",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            const TextB(
              text: "End Time: 11/08/2021 11:00am",
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
