import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';

import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/widgets/detail_description.dart';
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
                ? ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextB(
                                  text: "Parts Of Speech",
                                  textStyle: bSub1M,
                                ),
                                TextB(
                                  text: "English 2nd Paper",
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
                      DetailDescription(
                        description: state.details.data!.content ?? '',
                        attachments: state.details.data!.attachments!
                            .map((e) => e.url)
                            .toList(),
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
