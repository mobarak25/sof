import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/bloc/student_home_bloc.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/basic_info.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dashboard_due_task.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/dashboard_notice.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/next_class.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/widgets/subject_list.dart';

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
          ),
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
                        roll: "Roll: ${state.profile.data!.classRollNo}",
                        classInfo:
                            '${state.profile.data!.className!} ${state.profile.data!.sectionName!}',
                        schoolName: state.profile.data!.schoolName!,
                        isLoading: false,
                        isFailed: true,
                      )
                    else
                      const TextB(text: "loading"),
                    const NextClassBody(
                      isLoading: false,
                      subjectName: 'sdf',
                      subjectGroupID: 2,
                      roomNo: '',
                      startTime: '',
                      isError: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //UpcomingHomeworkQuizCount(isShowPresent: false),
                    Container(
                      width: double.infinity,
                      height: 1,
                      margin: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      color: kScaffoldBGColor,
                    ),
                    SubjectList(subjects: state.subjectList),
                  ],
                ),
              ),

              // dashboard notice=============
              const Gap(20),
              if (state.notice.noticeList != null)
                DashboardNotice(
                  notice: state.notice,
                  pressToViewAll: () {
                    Navigator.pushNamed(
                        navigatorKey.currentState!.context, noticeList);
                  },
                  pressToDetails: (int id) {
                    Navigator.pushNamed(
                        navigatorKey.currentState!.context, noticeDetailsScreen,
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
              const Gap(120),
            ],
          ),
        );
      },
    );
  }
}
