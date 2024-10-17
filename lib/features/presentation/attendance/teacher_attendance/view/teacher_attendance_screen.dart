import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/bloc/teacher_attendance_bloc.dart';

import 'package:school_of_future/core/widgets/month_week_day_calander.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/widgets/radial_chart.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<TeacherAttendanceBloc, TeacherAttendanceState>(
      builder: (context, state) {
        final bloc = context.read<TeacherAttendanceBloc>();

        // scroll.addListener(() {
        //   if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        //     bloc.add(PageIncrement());
        //   }
        // });

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.routine.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            color: bInnerBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MonthWeekDayCalendar(
                  onDateChanged: (date) {
                    // bloc.add(GetDate(date: date));
                  },
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonB(
                    heigh: 70,
                    text: LocaleKeys.takeAttendance.tr(),
                    press: () {},
                  ),
                ),
                const Gap(30),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                    color: bWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      RadiusChart(),
                      Gap(50),
                      TextB(text: "text"),
                    ],
                  ),
                ),
                // if (!state.loading &&
                //     state.routine.data != null &&
                //     state.routine.data!.isEmpty)
                //   Container(
                //     padding: const EdgeInsets.all(15),
                //     child: TextB(
                //       text: LocaleKeys.noResultFound.tr(),
                //       textStyle: bBody1B,
                //       fontColor: bRed,
                //     ),
                //   ),
                // Expanded(
                //   child: !state.loading && state.routine.data != null
                //       ? ListView(
                //           controller: scroll,
                //           padding: const EdgeInsets.symmetric(horizontal: 15),
                //           children: [
                //             ...List.generate(
                //               state.routine.data!.length,
                //               (index) {
                //                 return TimeLineRow(
                //                   isTeacher: state.isTeacher,
                //                   data: state.routine.data![index],
                //                 );
                //               },
                //             ),
                //             if (state.incrementLoader)
                //               const Center(
                //                 child: Padding(
                //                   padding: EdgeInsets.symmetric(vertical: 20),
                //                   child: CircularProgressIndicator(),
                //                 ),
                //               ),
                //             if (!state.incrementLoader && state.isEndList)
                //               const Padding(
                //                 padding: EdgeInsets.only(top: 15, bottom: 30),
                //                 child: TextB(
                //                   text: "End of the list",
                //                   textStyle: bBase2M,
                //                   fontColor: bRed,
                //                   alignMent: TextAlign.center,
                //                 ),
                //               ),
                //           ],
                //         )
                //       : const Center(
                //           child: CircularProgressIndicator(),
                //         ),
                // ),

                const Gap(70),
              ],
            ),
          ),
        );
      },
    );
  }
}
