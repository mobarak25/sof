import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/custom_tab.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/bloc/teacher_attendance_bloc.dart';
import 'package:school_of_future/core/widgets/month_week_day_calander.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/widgets/info_card.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/widgets/radial_chart.dart';

class TeacherAttendanceScreen extends StatelessWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherAttendanceBloc, TeacherAttendanceState>(
      builder: (context, state) {
        final bloc = context.read<TeacherAttendanceBloc>();

        if (state.isFirstTime) {
          return Body(
            isFullScreen: true,
            appBar: FutureAppBar(
              actions: const [SizedBox()],
              title: context.tr(LocaleKeys.attendance),
              isLoading: state.loading,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                color: bInnerBg,
              ),
              child: state.bacthAsSection.data != null
                  ? CustomTab(
                      showSearch: false,
                      loading: state.loading,
                      tabList: [
                        context.tr(LocaleKeys.classWise),
                        context.tr(LocaleKeys.subjectWise),
                      ],
                      onTabChanged: (int tabIndex) {
                        bloc.add(DataForTab(tabIndex: tabIndex.toString()));
                      },
                      search: (String value) {
                        // bloc.add(ChangeSearch(
                        //     searchText: value, filterBloc: filterBloc));
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: state.activeTab == '0'
                                ? ListView(
                                    children: listOfClass(
                                      state.bacthAsSection.data!,
                                      press: (int batchId, String className) {
                                        bloc.add(GetIdList(
                                          subjectId: -1,
                                          batchId: batchId,
                                          className: className,
                                        ));
                                      },
                                    ),
                                  )
                                : ListView(
                                    children: listOfSubjects(
                                      state.bacthAsSection.data!,
                                      context,
                                      press: (int subjectId, int batchId,
                                          String className) {
                                        bloc.add(GetIdList(
                                            subjectId: subjectId,
                                            batchId: batchId,
                                            className: className));
                                      },
                                    ),
                                  ),
                          ),
                          const Gap(70),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        }

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: context.tr(LocaleKeys.attendance),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13),
            color: bInnerBg,
            child: state.attendanceOverview.data != null
                ? ListView(
                    children: [
                      MonthWeekDayCalendar(
                        onDateChanged: (date) {
                          bloc.add(GetDate(date: date));
                        },
                      ),
                      const Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ButtonB(
                          heigh: 70,
                          bgColor: bJungleGreen,
                          text: context.tr(LocaleKeys.takeAttendance),
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              teacherTakeAttendanceScreen,
                              arguments: {
                                "subject_id": state.subjectId,
                                "batch_id": state.batchId,
                                "class_name": state.className,
                                "is_view_details": false,
                              },
                            );
                          },
                        ),
                      ),
                      const Gap(30),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        decoration: BoxDecoration(
                          color: bWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Gap(20),
                                RadiusChart(overView: state.attendanceOverview),
                                const Gap(40),
                                Expanded(
                                  child: Wrap(
                                    runSpacing: 20,
                                    spacing: 30,
                                    children: [
                                      OverviewInfo(
                                          title: state.attendanceOverview.data!
                                              .totalStudent!,
                                          subTitle: "Students"),
                                      OverviewInfo(
                                        title: state
                                            .attendanceOverview.data!.present!,
                                        subTitle: "Present",
                                        color: kPrimaryColor,
                                      ),
                                      OverviewInfo(
                                        title: state
                                            .attendanceOverview.data!.absent!,
                                        subTitle: "Absent",
                                        color: bRed,
                                      ),
                                      OverviewInfo(
                                        title: state
                                            .attendanceOverview.data!.leave!,
                                        subTitle: "Leave",
                                        color: bJungleGreen,
                                      ),
                                      OverviewInfo(
                                        title: state
                                            .attendanceOverview.data!.late!,
                                        subTitle: "Late",
                                        color: kSecondaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(40),
                            ButtonB(
                              heigh: 60,
                              svgIcon: rightArrowSvg,
                              text: context.tr(LocaleKeys.viewDetails),
                              borderColor: bGray12,
                              textColor: const Color(0XFF9B9BA5),
                              bgColor: bGray100.withOpacity(0.04),
                              press: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  teacherTakeAttendanceScreen,
                                  arguments: {
                                    "subject_id": state.subjectId,
                                    "batch_id": state.batchId,
                                    "class_name": state.className,
                                    "is_view_details": true,
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Gap(30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ButtonB(
                          heigh: 70,
                          svgIcon: rightArrowSvg,
                          text: " 3+ ${context.tr(LocaleKeys.daysAbsentList)}",
                          borderColor: bGray4,
                          textColor: const Color(0XFF9B9BA5),
                          bgColor: bWhite,
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              absentStudentsScreen,
                              arguments: {
                                "subject_id": state.subjectId,
                                "batch_id": state.batchId,
                                "class_name": state.className,
                              },
                            );
                          },
                        ),
                      ),
                      const Gap(100),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }

  List<Widget> listOfClass(List<DataItem> data, {required Function press}) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      final classList = data[i].classes!;
      for (int j = 0; j < classList.length; j++) {
        final sections = classList[j].subjects![0].sections!;
        for (int k = 0; k < sections.length; k++) {
          list.add(
            Column(
              children: [
                Material(
                  color: bWhite,
                  child: InkWell(
                    onTap: () {
                      press(sections[k].batchId,
                          "${classList[j].className} - ${sections[k].sectionName}");
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: TextB(
                        text:
                            "Version: ${data[i].versionName!}, ${classList[j].className!}, Section: ${sections[k].sectionName}",
                      ),
                    ),
                  ),
                ),
                const Gap(15),
              ],
            ),
          );
        }
      }
    }

    return list;
  }

  List<Widget> listOfSubjects(List<DataItem> data, BuildContext ctx,
      {required Function press}) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      final classList = data[i].classes!;
      for (int j = 0; j < classList.length; j++) {
        final subjects = classList[j].subjects!;
        for (int k = 0; k < subjects.length; k++) {
          final sections = subjects[k].sections!;
          list.add(
            Column(
              children: [
                Container(
                  width: double.infinity,
                  color: bWhite,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  child: Theme(
                    data: Theme.of(ctx)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      shape: null,
                      title: TextB(
                        text:
                            "Version: ${data[i].versionName!}, ${classList[j].className!}, Subject: ${subjects[k].subjectName}",
                      ),
                      children: List.generate(
                        sections.length,
                        (index) => ListTile(
                          onTap: () {
                            press(
                                subjects[k].subjectId,
                                sections[index].batchId,
                                "${classList[j].className} - ${subjects[k].subjectName} - ${sections[index].sectionName}");
                          },
                          title: TextB(
                            text: sections[index].sectionName!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(15),
              ],
            ),
          );
        }
      }
    }

    return list;
  }
}
