import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class TimerRadius extends StatelessWidget {
  const TimerRadius({
    super.key,
    required this.minutes,
    required this.seconds,
    required this.parsentage,
  });

  final String minutes;
  final String seconds;
  final double parsentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: bWhite, // Circular background color
        shape: BoxShape.circle,
      ),
      child: CircularPercentIndicator(
        animation: false,
        animationDuration: 1000,
        radius: 75.0,
        lineWidth: 12.0,
        percent: parsentage,
        progressColor: kSecondaryColor,
        backgroundColor: const Color(0XFFF0F5F9),
        center: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextB(
                  text: minutes,
                  textStyle: bHead5B,
                ),
                const TextB(
                  text: "min",
                  textStyle: bBase2,
                  fontColor: bGray32,
                ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(45),
                TextB(
                  text: " : ",
                  textStyle: bHead5B,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextB(
                  text: seconds,
                  textStyle: bHead5B,
                ),
                const TextB(
                  text: "sec",
                  textStyle: bBase2,
                  fontColor: bGray32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
