import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/view/filter_sidebar.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/bloc/student_attendance_bloc.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/widgets/attendance_calender.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/widgets/filterbar.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/widgets/student_radius_chart.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/widgets/info_card.dart';

class StudentAttendanceScreen extends StatelessWidget {
  const StudentAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentAttendanceBloc, StudentAttendanceState>(
      builder: (context, state) {
        final bloc = context.read<StudentAttendanceBloc>();
        final filterBloc = context.read<FilterSidebarBloc>();

        if (state.isFirstTime) {
          bloc.add(GetStudentOverView(filterBloc: filterBloc));
        }

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: context.tr(LocaleKeys.attendance),
            isLoading: state.loading,
          ),
          drawerChild: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 10,
              right: 10,
            ),
            child: SingleChildScrollView(
              child: FilterSidebar(
                showStartDate: true,
                showEndDate: true,
                showSubjectForStudent: true,
                btnText: LocaleKeys.filter.tr(),
                pressFilterBtn: () {
                  bloc.add(PressFilter(filterBloc: filterBloc));
                },
              ),
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 13),
              color: bInnerBg,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: bWhite),
                    child: state.studentOverview.data != null &&
                            state.todayStatus.data != null
                        ? Column(
                            children: [
                              const FilterBar(),
                              const Divider(
                                height: 1,
                                thickness: 1,
                                color: bGray32,
                              ),
                              const Gap(30),
                              Row(
                                children: [
                                  const Gap(20),
                                  StudentRadiusChart(
                                    overView: state.studentOverview,
                                  ),
                                  const Gap(40),
                                  Expanded(
                                    child: Wrap(
                                      runSpacing: 20,
                                      spacing: 30,
                                      children: [
                                        OverviewInfo(
                                            title: state
                                                .studentOverview.data!.classes!,
                                            subTitle: context
                                                .tr(LocaleKeys.classDay)),
                                        OverviewInfo(
                                          title: state
                                              .studentOverview.data!.present!,
                                          subTitle:
                                              context.tr(LocaleKeys.present),
                                          color: kPrimaryColor,
                                        ),
                                        OverviewInfo(
                                          title: state
                                              .studentOverview.data!.absent!,
                                          subTitle:
                                              context.tr(LocaleKeys.absent),
                                          color: bRed,
                                        ),
                                        OverviewInfo(
                                          title: state
                                              .studentOverview.data!.leave!,
                                          subTitle:
                                              context.tr(LocaleKeys.leave),
                                          color: bJungleGreen,
                                        ),
                                        OverviewInfo(
                                          title:
                                              state.studentOverview.data!.late!,
                                          subTitle: context.tr(LocaleKeys.late),
                                          color: kSecondaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ButtonB(
                                  fontSize: 20,
                                  heigh: 60,
                                  text: statusWithColor(
                                          state.todayStatus.data!.presentStatus)
                                      .status,
                                  textColor: statusWithColor(
                                          state.todayStatus.data!.presentStatus)
                                      .color,
                                  press: () {},
                                  bgColor: bGray12,
                                ),
                              ),
                              const Gap(10),
                            ],
                          )
                        : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                  const Gap(30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: const BoxDecoration(
                      color: bWhite,
                    ),
                    child: AttendanceCalendarWidget(
                      loading: false,
                      studentEvents: state.events,
                      onMonthChanged: (date) {
                        bloc.add(GetCalanderOverView(date: date));
                      },
                      onDateChanged: (date) {},
                    ),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  StatusColor statusWithColor(dynamic presentStatus) {
    switch (presentStatus) {
      case 0:
        return StatusColor("Absent Today", bRed);
      case 1:
        return StatusColor("Present Today", kPrimaryColor);
      case 2:
        return StatusColor("Leave Today", bJungleGreen);
      case 3:
        return StatusColor("Late Today", kSecondaryColor);
      default:
        return StatusColor("Attendance Not Taken", bGray100);
    }
  }
}

class StatusColor {
  StatusColor(this.status, this.color);

  final String status;
  final Color color;
}
