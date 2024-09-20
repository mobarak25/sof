import 'dart:math';

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
import 'package:school_of_future/core/widgets/network_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/detail_description.dart';
import 'package:school_of_future/features/presentation/assignment/student_submission_details/bloc/student_submission_details_bloc.dart';

class StudentAssignmentSubmissionDetailsScreen extends StatelessWidget {
  const StudentAssignmentSubmissionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentSubmissionDetailsBloc,
        StudentSubmissionDetailsState>(
      builder: (context, state) {
        final bloc = context.read<StudentSubmissionDetailsBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.homeWorkDetails.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bWhite,
            child: state.details.data != null
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (state.isTeacher)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: bGray12),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: NetworkImageB(
                                              imageUrl: state
                                                  .details
                                                  .data!
                                                  .studentAssignment!
                                                  .student!
                                                  .imageUrl!),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextB(
                                                text: state
                                                    .details
                                                    .data!
                                                    .studentAssignment!
                                                    .student!
                                                    .fullName!,
                                                textStyle: bSub2M,
                                                maxLines: 1,
                                              ),
                                              TextB(
                                                text:
                                                    "${LocaleKeys.roll.tr()}: ${state.details.data!.studentAssignment!.student!.admissionNumber!}",
                                                textStyle: bBase2,
                                                fontColor: bGray32,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(5)
                                      ],
                                    ),
                                  )
                                else
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextB(
                                          text: state
                                              .details
                                              .data!
                                              .studentAssignment!
                                              .assignment!
                                              .title!,
                                          textStyle: bSub1M,
                                        ),
                                        TextB(
                                          text: state
                                              .details
                                              .data!
                                              .studentAssignment!
                                              .assignment!
                                              .subject!
                                              .name!,
                                          fontColor: bGray32,
                                        ),
                                      ],
                                    ),
                                  ),
                                Container(
                                  width: 56,
                                  height: 40,
                                  margin: const EdgeInsets.only(left: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: kLabelColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextB(
                                    text: state.details.data!.marks!,
                                    textStyle: bSub1B,
                                    fontColor: bGray52,
                                  ),
                                )
                              ],
                            ),
                            const Gap(30),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: bGray12,
                            ),
                            const Gap(20),
                            DetailDescription(
                              description: state.details.data!.content ?? '',
                              attachments: state.details.data!.attachments!
                                  .map((e) => e.url)
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      if (state.isTeacher)
                        Column(
                          children: [
                            ButtonB(
                              heigh: 55,
                              text: LocaleKeys.accept.tr(),
                              press: () {
                                bloc.add(OpenAcceptSheet());
                              },
                            ),
                            const Gap(15),
                            Row(
                              children: [
                                Expanded(
                                  child: ButtonB(
                                    heigh: 55,
                                    bgColor: kSecondaryColor,
                                    text: LocaleKeys.resubmit.tr(),
                                    press: () {
                                      bloc.add(OpenResubmitSheet());
                                    },
                                  ),
                                ),
                                const Gap(15),
                                Expanded(
                                  child: ButtonB(
                                    heigh: 55,
                                    bgColor: bGray12,
                                    textColor: bGray,
                                    text: LocaleKeys.deny.tr(),
                                    press: () {
                                      bloc.add(OpenDenySheet());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
}
