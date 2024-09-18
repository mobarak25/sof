import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';
import 'package:quill_json_to_html/json_to_html.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/dotted_button.dart';
import 'package:school_of_future/core/widgets/show_file_name.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_submit/bloc/student_assignment_submit_bloc.dart';

class StudentAssignmentSubmitScreen extends StatelessWidget {
  const StudentAssignmentSubmitScreen({
    super.key,
    required this.title,
    required this.subject,
  });

  final String title, subject;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentAssignmentSubmitBloc>();
    QuillController qController = QuillController.basic();
    // qController.addListener(() {
    //   List jsonContent = qController.document.toDelta().toJson();
    //   bloc.add(ChangeContent(content: jsonContent));
    // });

    return BlocBuilder<StudentAssignmentSubmitBloc,
        StudentAssignmentSubmitState>(
      builder: (context, state) {
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.submitHomeWork.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: ListView(
              children: [
                Column(
                  children: [
                    const Gap(20),
                    TextB(
                      text: LocaleKeys.homeWork.tr(),
                      textStyle: bSub1M,
                      fontColor: bBlack,
                    ),
                    const Gap(10),
                    TextB(
                      text: title,
                      textStyle: bSub2,
                      fontColor: bGray52,
                    ),
                    TextB(
                      text: subject,
                      textStyle: bSub2,
                      fontColor: bPrimaryColor,
                    ),
                    const Gap(80),
                    ShowFileName(
                      selectedFile: state.fileList,
                      press: (int index) {
                        bloc.add(RemoveFile(index: index));
                      },
                    ),
                    DottedButtonB(
                      title: LocaleKeys.upLoadHomeWork.tr(),
                      press: () {
                        bloc.add(GetFile());
                      },
                    ),
                    if (state.forms == Forms.invalid && state.fileList.isEmpty)
                      TextB(
                        text: LocaleKeys.upLoadHomeWork.tr(),
                        fontColor: bRed,
                      ),
                    const Gap(35),
                    Row(
                      children: [
                        TextB(
                          text: LocaleKeys.doHomeWork.tr(),
                          textStyle: bSub2M,
                          fontColor: bBlack,
                        ),
                      ],
                    ),
                    QuillSimpleToolbar(
                      controller: qController,
                      configurations: const QuillSimpleToolbarConfigurations(
                        multiRowsDisplay: false,
                        toolbarSize: 45,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: bWhite,
                        border: Border.all(color: bGray32),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 200,
                      child: Expanded(
                        child: QuillEditor.basic(
                          controller: qController,
                          configurations: const QuillEditorConfigurations(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                          ),
                        ),
                      ),
                    ),
                    if (state.forms == Forms.invalid &&
                        state.content == '<br> ')
                      TextB(
                        text: LocaleKeys.enterDescription.tr(),
                        fontColor: bRed,
                      ),
                    const Gap(30),
                    ButtonB(
                      heigh: 60,
                      text: LocaleKeys.submit.tr(),
                      loading: state.loading,
                      press: () {
                        List jsonContent =
                            qController.document.toDelta().toJson();

                        final htmlContent =
                            QuillJsonToHTML.encodeJson(jsonContent);
                        bloc.add(PressToSumit(work: htmlContent));
                      },
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonB(
                            heigh: 60,
                            fontSize: 15,
                            loading: state.loading,
                            bgColor: kSecondaryColor,
                            horizontalPadding: 5,
                            text: LocaleKeys.saveAsDraft.tr(),
                            press: () {
                              List jsonContent =
                                  qController.document.toDelta().toJson();

                              final htmlContent =
                                  QuillJsonToHTML.encodeJson(jsonContent);
                              bloc.add(PressToDraft(work: htmlContent));
                            },
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ButtonB(
                            heigh: 60,
                            bgColor: kTextDefaultColor.withOpacity(0.2),
                            textColor: kTextAnotherColor,
                            text: LocaleKeys.cancel.tr(),
                            press: () {
                              bloc.add(PressToCancel());
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
