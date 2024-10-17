import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RadiusChart extends StatelessWidget {
  const RadiusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            animation: true,
            animationDuration: 1000,
            radius: 70.0,
            lineWidth: 10.0,
            percent:
                0.8, //attendanceSummary.present! / attendanceSummary.classes!,
            center: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "${((attendanceSummary.present! / attendanceSummary.classes!) * 100).toInt()}%",
                //   style: const TextStyle(
                //       fontSize: 30, fontWeight: FontWeight.w600),
                // ),
                Text(
                  "80%",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Text("Overall\nPresent"),
              ],
            ),
            progressColor: const Color(0xFF01A39B),
            backgroundColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}
