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
import 'package:school_of_future/features/presentation/exam/teacher_mark_entry/bloc/theacher_mark_entry_bloc.dart';

class TeacherMarkEntryScreen extends StatelessWidget {
  const TeacherMarkEntryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TheacherMarkEntryBloc, TheacherMarkEntryState>(
      builder: (context, state) {
        final bloc = context.read<TheacherMarkEntryBloc>();
        final data = state.students.data;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.marksEntry.tr(),
          ),
          child: Container(
              padding: const EdgeInsets.only(top: 10),
              color: bWhite,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: const BoxDecoration(
                      color: bGray4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.studentDetails.tr(),
                          fontSize: 16,
                          fontColor: bBlack,
                        ),
                        TextB(
                          text: LocaleKeys.marks.tr(),
                          fontSize: 16,
                          fontColor: bBlack,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: data != null
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 65,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(color: bGray12),
                                        ),
                                        child: NetworkImageB(
                                            imageUrl: data[index].imageUrl!),
                                      ),
                                      const Gap(10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextB(
                                              text: data[index].fullName!,
                                              textStyle: bSub2M,
                                              fontColor: bGray100,
                                              maxLines: 1,
                                            ),
                                            const Gap(4),
                                            TextB(
                                              text:
                                                  "Roll: ${data[index].admissionNumber}",
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(5),
                                      SizedBox(
                                        width: 80,
                                        child: TextFieldB(
                                          textInputType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          hintText: LocaleKeys.marks.tr(),
                                          borderColor: bGray12,
                                          focusNode: state
                                              .tempExamMark[index].focusnode,
                                          controller: state.tempExamMark[index]
                                              .textEditingController,
                                          onChanged: (String value) {},
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(14),
                                ],
                              );
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ButtonB(
                      heigh: 60,
                      loading: state.loading,
                      text: "Save",
                      press: () {
                        bloc.add(SaveMark());
                      },
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
