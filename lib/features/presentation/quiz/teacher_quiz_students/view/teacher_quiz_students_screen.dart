import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/domain/entities/quiz_students_response.dart';

import 'package:school_of_future/features/presentation/quiz/teacher_quiz_students/bloc/teacher_quiz_students_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_students/widgets/student_items.dart';

class TeacherQuizStudentsScreen extends StatelessWidget {
  const TeacherQuizStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();

    return BlocBuilder<TeacherQuizStudentsBloc, TeacherQuizStudentsState>(
      builder: (context, state) {
        final bloc = context.read<TeacherQuizStudentsBloc>();
        final data = state.students.data;
        final details = state.quizDtls.data;
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.quizDetails.tr(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  color: bWhite,
                  child: data != null
                      ? ListView(
                          controller: scroll,
                          children: [
                            Column(
                              children: [
                                TextB(
                                  text: details!.title!,
                                  textStyle: bHead6M,
                                  alignMent: TextAlign.center,
                                  fontHeight: 1.2,
                                ),
                                const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextB(
                                      text: details.subject!.name!,
                                      fontColor: kPrimaryColor,
                                    ),
                                    TextB(
                                      text:
                                          " | ${details.subject!.subjectClass!.name!}",
                                    ),
                                  ],
                                ),
                                TextB(
                                  text:
                                      "${LocaleKeys.marks.tr()}: ${details.totalMark}",
                                ),
                                const Gap(25),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: bGray12,
                                ),
                                const Gap(25),
                              ],
                            ),
                            StduntItem(
                              data: data,
                              pressToReview: (QuizStudentItem student) {
                                if (student.quizTime != null) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(teacherReviewScreen,
                                          arguments: {
                                        "student": student,
                                        "quiz_id": state.quizId
                                      });
                                }
                              },
                            ),
                            if (!state.incrementLoader && state.isEndList)
                              const Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: TextB(
                                  text: "End of the list",
                                  textStyle: bBase2M,
                                  fontColor: bRed,
                                ),
                              ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              if (state.incrementLoader)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
