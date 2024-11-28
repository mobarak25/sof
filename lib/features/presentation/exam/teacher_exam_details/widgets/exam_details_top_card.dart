import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/exam_details_response.dart';

class ExamDetailsTopCard extends StatelessWidget {
  const ExamDetailsTopCard({
    super.key,
    required this.details,
  });
  final ExamDetails details;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 200),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFF37BFD7), Color(0XFF17799C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              decoration: BoxDecoration(
                color: bWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextB(
                text: details.data!.examGroup!.examCategory!.name!,
                textStyle: bBase,
                fontColor: bJungleGreen,
              ),
            ),
            const Gap(20),
            TextB(
              text: details.data!.examGroup!.name!,
              textStyle: bHead5B,
              fontColor: bWhite,
            ),
            const Gap(7),
            Row(
              children: [
                TextB(
                  text: details.data!.subject!.name!,
                  textStyle: bBase2,
                  fontColor: bWhite,
                ),
                TextB(
                  text: " | Section: ${details.data!.batch!.section!.name}",
                  textStyle: bBase2,
                  fontColor: bWhite,
                ),
              ],
            ),
            const Gap(4),
            TextB(
              text: "Date: ${details.data!.date}",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            const Gap(4),
            TextB(
              text:
                  "${LocaleKeys.time.tr()}: ${convertTo12HourFormat(details.data!.startTime!)} - ${convertTo12HourFormat(details.data!.endTime!)}",
              textStyle: bBase2,
              fontColor: bWhite,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              decoration: BoxDecoration(
                color: bWhite.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextB(
                    text: LocaleKeys.syllabus.tr(),
                    textStyle: bBody2M,
                    fontColor: bWhite,
                  ),
                  const Gap(5),
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: bWhite,
                    ),
                  ),
                ],
              ),
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
