import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/subject_image_generator.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/bloc/student_assignment_details_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/widgets/detail_description.dart';

class StudentAssignmentDetailsScreen extends StatelessWidget {
  const StudentAssignmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentAssignmentDetailsBloc,
        StudentAssignmentDetailsState>(
      builder: (context, state) {
        final bloc = context.read<StudentAssignmentDetailsBloc>();
        final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.homeWorkDetails.tr(),
          ),
          child: data != null
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                  color: bInnerBg,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child:
                                            appGenerateSvgWidgetFromId(id: 1),
                                      ),
                                    ),
                                    const Gap(15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextB(
                                          text: data.title ?? '',
                                          textStyle: bBody1,
                                          fontColor: kTextAnotherColor,
                                          maxLines: 2,
                                        ),
                                        const Gap(5),
                                        TextB(
                                          text: data.subject!.name ?? '',
                                          fontSize: 13,
                                          fontColor: kPrimaryColor,
                                        ),
                                        const Gap(5),
                                        Row(
                                          children: [
                                            TextB(
                                              text:
                                                  '${LocaleKeys.assignDate.tr()}: ',
                                              fontColor: kTextDefaultColor,
                                            ),
                                            TextB(
                                              text: getDate(
                                                  value: data.publishedAt!,
                                                  formate: "dd MMM, yyyy"),
                                              fontColor: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        Row(
                                          children: [
                                            TextB(
                                              text:
                                                  '${LocaleKeys.dueDateAssignment.tr()}: ',
                                              fontColor: kTextDefaultColor,
                                            ),
                                            TextB(
                                              text: getDate(
                                                  value: state
                                                      .details.data!.dueAt!,
                                                  formate: "dd MMM, yyyy"),
                                              fontColor: kPrimaryColor,
                                            ),
                                            Container(
                                              height: 15,
                                              width: 0.9,
                                              color: kDividerColor,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                            ),
                                            Row(
                                              children: [
                                                const Gap(5),
                                                TextB(
                                                  text: "${data.daysLeft!}",
                                                  fontColor: kErrorColor,
                                                ),
                                                const Gap(5),
                                                Text(
                                                  LocaleKeys.daysLeftAssignment
                                                      .tr(),
                                                  style: bSub1.copyWith(
                                                      color: kTextDefaultColor
                                                          .withOpacity(0.5),
                                                      fontSize: 10),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(30),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: kTextDefaultColor
                                            .withOpacity(0.05)),
                                    color: kPrimaryColor.withOpacity(0.1),
                                  ),
                                  child: Column(
                                    children: [
                                      const Gap(3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              TextB(
                                                text: LocaleKeys.markObtained
                                                    .tr(),
                                                textStyle: bBase2,
                                                fontColor: bGray52,
                                              ),
                                              TextB(
                                                text: "${data.obtainedMark}",
                                                textStyle: bHead6,
                                                fontColor: kPrimaryColor,
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              TextB(
                                                text: LocaleKeys.totalMark.tr(),
                                                textStyle: bBase2,
                                                fontColor: bGray52,
                                              ),
                                              TextB(
                                                text: "${data.marks}",
                                                textStyle: bHead6,
                                                fontColor: kPrimaryColor,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(38),
                                DetailDescription(
                                  description: data.description ?? '',
                                  attachments: data.attachments!
                                      .map((e) => e.url)
                                      .toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      if (data.assignStudent != null &&
                          data.assignStudent!.submissionStatus == 0)
                        Column(
                          children: [
                            ButtonB(
                              heigh: 55,
                              text: LocaleKeys.viewSubmissions.tr(),
                              press: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  studentAssignmentSubmissionDetailsScreen,
                                  arguments: data
                                      .assignStudent!.assignmentSubmission!.id,
                                );
                              },
                            ),
                            const Gap(10),
                            ButtonB(
                              heigh: 55,
                              bgColor: bWhite,
                              borderColor: bPrimaryColor,
                              textColor: bPrimaryColor,
                              text:
                                  "${LocaleKeys.viewFeedBack.tr()} (${data.assignStudent!.assignmentSubmission!.totalFeedbacks!})",
                              press: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                  studentAssignmentFeedbackScreen,
                                  arguments: data
                                      .assignStudent!.assignmentSubmission!.id,
                                );
                              },
                            ),
                          ],
                        ),
                      if (data.assignStudent != null &&
                          data.assignStudent!.submissionStatus == null)
                        ButtonB(
                          heigh: 55,
                          text: LocaleKeys.submitHomeWork.tr(),
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              studentAssignmentSubmitScreen,
                              arguments: {
                                "id": data.id,
                                "title": data.title,
                                "subject": data.subject!.name,
                              },
                            );
                          },
                        ),
                      if (state.isTeacher)
                        ButtonB(
                          heigh: 55,
                          text:
                              "${LocaleKeys.viewSubmissions.tr()} (${data.countSubmittedByStudent})",
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              teacherAssignmentViewSubmissionScreen,
                              arguments: data.id,
                            );
                          },
                        ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
