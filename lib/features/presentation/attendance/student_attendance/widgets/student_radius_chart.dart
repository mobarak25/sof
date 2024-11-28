import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/features/domain/entities/attendance_overvview_response.dart';

class StudentRadiusChart extends StatelessWidget {
  const StudentRadiusChart({super.key, required this.overView});

  final AttendanceOverview overView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1000,
        radius: 75.0,
        lineWidth: 10.0,
        percent: overView.data!.present != 0
            ? overView.data!.present! / overView.data!.classes!
            : 0,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${overView.data!.percentage}%",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              context.tr(LocaleKeys.overAll),
            ),
            Text(
              context.tr(LocaleKeys.present),
            ),
          ],
        ),
        progressColor: kSecondaryColor,
        backgroundColor: const Color(0XFFF0F5F9),
      ),
    );
  }
}
