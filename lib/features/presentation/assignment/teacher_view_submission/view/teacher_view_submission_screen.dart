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
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_view_submission/bloc/teacher_view_submission_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_view_submission/widgets/header.dart';

class TeacherViewSubmissionScreen extends StatelessWidget {
  const TeacherViewSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherViewSubmissionBloc, TeacherViewSubmissionState>(
      builder: (context, state) {
        final bloc = context.read<TeacherViewSubmissionBloc>();
        final entryMarkController = TextEditingController();
        final entryMarkFocusNode = FocusNode();
        // final data = state.details.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.viewSubmissions.tr(),
          ),
          child: state.details.data != null && state.submittedList.data != null
              ? ListView(
                  children: [
                    const Gap(15),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: bWhite,
                      child: Column(
                        children: [
                          TextB(
                            text: state.details.data!.title ?? '',
                            textStyle: bHead6B,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextB(
                                text: "${LocaleKeys.totalMark.tr()}: ",
                                textStyle: bSub2,
                              ),
                              TextB(
                                text: "${state.details.data!.marks!}",
                                textStyle: bSub2,
                                fontColor: bPrimaryColor,
                              ),
                            ],
                          ),
                          const Gap(20),
                          Header(
                            submitted:
                                state.details.data!.countSubmittedByStudent!,
                            due: state.details.data!.countAssignToStudent! -
                                state.details.data!.countSubmittedByStudent!,
                            late: state.details.data!.countViewedAssignment!,
                          ),
                          ...List.generate(
                            state.submittedList.data!.length,
                            (index) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: bGray12),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: NetworkImageB(
                                        imageUrl: state.submittedList
                                            .data![index].imageUrl!),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextB(
                                          text: state.submittedList.data![index]
                                              .fullName!,
                                          textStyle: bSub2M,
                                          maxLines: 1,
                                        ),
                                        TextB(
                                          text:
                                              "${LocaleKeys.roll.tr()}: ${state.submittedList.data![index].admissionNumber!}",
                                          textStyle: bBase2,
                                          fontColor: bGray32,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(5),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 60,
                                        child: TextFieldB(
                                          height: 55,
                                          paddingHeight: 10,
                                          paddingWidth: 5,
                                          hintText:
                                              state.controllers[index].text,
                                          textAlign: TextAlign.center,
                                          focusNode: entryMarkFocusNode,
                                          controller: state.controllers[index],
                                          onChanged: (String value) {
                                            bloc.add(UpdateMarkes(
                                              submissionId: state.submittedList
                                                  .data![index].submission!.id!,
                                              marks: value,
                                              status: 1,
                                            ));
                                          },
                                        ),
                                      ),
                                      const Gap(10),
                                      ButtonB(
                                        horizontalPadding: 0,
                                        heigh: 43,
                                        text: LocaleKeys.view.tr(),
                                        press: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
