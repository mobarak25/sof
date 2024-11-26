import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/assignment/student_feedback/bloc/student_feedback_bloc.dart';

class StudentFeedbackScreen extends StatelessWidget {
  const StudentFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = ScrollController();
    return BlocBuilder<StudentFeedbackBloc, StudentFeedbackState>(
      builder: (context, state) {
        final bloc = context.read<StudentFeedbackBloc>();
        scroll.addListener(() {
          if (scroll.position.pixels == scroll.position.maxScrollExtent) {
            bloc.add(PageIncrement());
          }
        });
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.feedback.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bWhite,
            child: state.feedback.data != null
                ? ListView(
                    controller: scroll,
                    children: state.feedback.data!.isEmpty
                        ? [
                            Center(
                                child: TextB(
                              text: LocaleKeys.noFeedBackAvailable.tr(),
                              fontColor: bRed,
                              textStyle: bBody1B,
                            ))
                          ]
                        : [
                            const TextB(
                              text: "All Feedbacks",
                              textStyle: bHead6B,
                            ),
                            const Gap(40),
                            ...List.generate(
                              state.feedback.data!.length,
                              (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextB(
                                    text: getDate(
                                        value: state
                                            .feedback.data![index].createdAt!,
                                        formate: "dd/MM/yyyy"),
                                    fontColor: bBlueColor,
                                  ),
                                  const Gap(10),
                                  TextB(
                                    text: state.feedback.data![index].content!,
                                    fontColor: bGray52,
                                  ),
                                  const Gap(30),
                                ],
                              ),
                            ),
                            if (state.incrementLoader)
                              const Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 30),
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ),
                            if (!state.incrementLoader && state.isEndList)
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 30),
                                child: TextB(
                                  text: context.tr(LocaleKeys.endOfTheList),
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
        );
      },
    );
  }
}

//TODO: Add pagination
