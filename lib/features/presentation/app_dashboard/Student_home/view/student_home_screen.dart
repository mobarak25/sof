import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/bloc/student_home_bloc.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/basic_info.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dahsboard_exam.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dashboard_due_task.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dashboard_home_work.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dashboard_notice.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dashboard_student_homework.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/next_class.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/subject_list.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/upcoming_homework_quiz_count.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return BlocBuilder<StudentHomeBloc, StudentHomeState>(
      builder: (context, state) {
        final bloc = context.read<StudentHomeBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            title: "Student home",
            isDashboard: true,
            version: state.version,
            isLoading: state.loading,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(RefreshScreen());
            },
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 25),
                  decoration: const BoxDecoration(
                    color: bWhite,
                  ),
                  child: Column(
                    children: [
                      if (state.profile.data != null)
                        BasicInfo(
                          imageUrl: state.profile.data!.imageUrl ?? '',
                          name: state.profile.data!.fullname!,
                          classInfo:
                              '${state.profile.data!.className!} ${state.profile.data!.sectionName!}',
                          roll:
                              "${context.tr(LocaleKeys.roll)}: ${state.profile.data!.admissionNumber}",
                          schoolName: state.profile.data!.schoolName!,
                          isLoading: false,
                          isFailed: true,
                        )
                      else
                        const TextB(text: "loading"),
                      if (state.nextClass.data != null)
                        NextClassBody(
                          isLoading: false,
                          subjectName: state.nextClass.data!.subjectName!,
                          subjectGroupID: state.nextClass.data!.subjectGroupId!,
                          roomNo: state.nextClass.data!.roomNo ?? '',
                          startTime: convertTo12HourFormat(
                              state.nextClass.data!.startTime!),
                          isError: false,
                        )
                      else
                        const TextB(text: "loading"),
                      const Gap(20),
                      if (state.todayActivity.data != null)
                        UpcomingHomeWorkQuizCount(
                          homeWortCount:
                              state.todayActivity.data!.totalHomework!,
                          quizCount: state.todayActivity.data!.totalQuiz!,
                        )
                      else
                        const TextB(text: "loading"),
                      Container(
                        width: double.infinity,
                        height: 1,
                        margin: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        color: kScaffoldBGColor,
                      ),
                      if (state.subjectList.data != null)
                        SubjectList(subjects: state.subjectList.data!)
                      else
                        const TextB(text: "loading"),
                    ],
                  ),
                ),

                // dashboard notice=============
                const Gap(20),
                if (state.notice.data != null)
                  DashboardNotice(
                    notice: state.notice,
                    pressToViewAll: () {
                      Navigator.pushNamed(
                          navigatorKey.currentState!.context, noticeList);
                    },
                    pressToDetails: (int id) {
                      Navigator.pushNamed(navigatorKey.currentState!.context,
                          noticeDetailsScreen,
                          arguments: id);
                    },
                  )
                else
                  const TextB(text: "loading..."),

                // dashboard due task=============
                const Gap(20),
                if (state.dueTaskList.data != null)
                  DashboardDueTask(
                    dueTask: state.dueTaskList,
                    pressToViewAll: () {},
                    pressToDetails: () {},
                  )
                else
                  const TextB(text: "loading..."),
                // dashboard home work=============
                const Gap(20),

                if (state.isTeacher)
                  Column(
                    children: [
                      if (state.homework.data != null)
                        DashboarHomework(
                          homework: state.homework,
                          pressToViewAll: () {
                            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                teacherAssignmentListScreen,
                                ModalRoute.withName('/'));
                          },
                          pressToDelEdit: (String pressTo, int id) {
                            bloc.add(PressToDelEdit(id: id, type: pressTo));
                          },
                        )
                    ],
                  )
                else
                  Column(
                    children: [
                      if (state.studentHomework.data != null)
                        DashboarStudentHomework(
                          homework: state.studentHomework,
                          pressToViewAll: () {
                            navigatorKey.currentState!.pushNamedAndRemoveUntil(
                                studentAssignmentListScreen,
                                ModalRoute.withName('/'));
                          },
                          pressToDetails: () {},
                        )
                    ],
                  ),

                const Gap(20),
                if (state.examList.data != null)
                  DashboarExam(
                    examList: state.examList,
                    pressToViewAll: () {},
                    pressToDetails: () {},
                  ),

                const Gap(120),
              ],
            ),
          ),
        );
      },
    );
  }
}
