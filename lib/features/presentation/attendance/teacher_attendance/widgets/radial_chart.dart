import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/features/domain/entities/attendance_overvview_response.dart';

class RadiusChart extends StatelessWidget {
  const RadiusChart({super.key, required this.overView});

  final AttendanceOverview overView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1000,
        radius: 75.0,
        lineWidth: 10.0,
        percent: overView.data!.present! / overView.data!.totalStudent!,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${overView.data!.percentage}%",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const Text("Overall\nPresent"),
          ],
        ),
        progressColor: kSecondaryColor,
        backgroundColor: const Color(0XFFF0F5F9),
      ),
    );
  }
}
