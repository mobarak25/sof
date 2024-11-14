import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class TimerRadius extends StatelessWidget {
  const TimerRadius({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: bWhite, // Circular background color
        shape: BoxShape.circle,
      ),
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1000,
        radius: 75.0,
        lineWidth: 12.0,
        percent: 0.9,
        progressColor: kSecondaryColor,
        backgroundColor: const Color(0XFFF0F5F9),
        center: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextB(
                  text: "12",
                  textStyle: bHead5B,
                ),
                TextB(
                  text: "min",
                  textStyle: bBase2,
                  fontColor: bGray32,
                ),
              ],
            ),
            Column(
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
                  text: "12",
                  textStyle: bHead5B,
                ),
                TextB(
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
