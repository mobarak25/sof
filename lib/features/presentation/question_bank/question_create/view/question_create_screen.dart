import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/dotted_button.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/show_file_name.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/question_bank/question_create/bloc/question_create_bloc.dart';

class QuestionCreateScreen extends StatelessWidget {
  const QuestionCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<QuestionCreateBloc>();
    final titleFocusnode = FocusNode();
    final markFocusnode = FocusNode();
    final titleController = TextEditingController();
    final markController = TextEditingController();

    return BlocBuilder<QuestionCreateBloc, QuestionCreateState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.questionDtls.data != null) {
            final data = state.questionDtls.data!;

            //here data.resourceType == 1 is means video

            bloc.add(
              AddData(
                title: data.title!,
                selectedVersionId: data.subject!.versionId!,
                selectedClassId: data.subject!.classId!,
                selectedSubjectId: data.subjectId,
              ),
            );
          } else if (state.questionDtls.data == null && state.qId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.createLessonPlan.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        titleController.text = state.title;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.questionBank.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.title.tr(),
                      hintText: LocaleKeys.enterTitle.tr(),
                      borderColor: bGray12,
                      focusNode: titleFocusnode,
                      controller: titleController,
                      onChanged: (String value) {
                        bloc.add(ChangeTitle(title: value));
                      },
                      errorText:
                          state.forms == Forms.invalid && state.title.isEmpty
                              ? LocaleKeys.enterTitle.tr()
                              : '',
                    ),
                    Column(
                      children: [
                        const Gap(15),
                        ShowFileName(
                          selectedFile: state.fileList,
                          press: (int index) {
                            bloc.add(RemoveFile(index: index));
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    DottedButtonB(
                      title: LocaleKeys.attachment.tr(),
                      verticalPadding: 20,
                      bgColor: kPrimaryColor,
                      borderColor: kPrimaryColor,
                      textColor: bWhite,
                      svgIcon: fileAttachSvg,
                      svgColor: bWhite,
                      svgHeight: 30,
                      press: () {
                        bloc.add(GetFile());
                      },
                    ),
                    const Gap(20),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.version.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectedVersionId,
                      selected: (dynamic type) {
                        bloc.add(SelectVersionId(id: type));
                      },
                      items: state.versionList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedVersionId == -1)
                      TextB(
                          text: LocaleKeys.selectVersion.tr(), fontColor: bRed),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      setState: state.setClass,
                      label: LocaleKeys.classStr.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectedClassId,
                      selected: (dynamic type) {
                        bloc.add(SelectClassId(id: type));
                      },
                      items: state.classList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedClassId == -1)
                      TextB(text: LocaleKeys.selectClass.tr(), fontColor: bRed),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.subject.tr(),
                      labelColor: bBlack,
                      setState: state.setSubject,
                      dropDownValue: state.selectedSubjectId,
                      selected: (dynamic type) {
                        bloc.add(SelectSubjectId(id: type));
                      },
                      items: state.subjectList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedSubjectId == -1)
                      TextB(
                          text: LocaleKeys.selectSubject.tr(), fontColor: bRed),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.quesLevel.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectLevelId,
                      selected: (dynamic type) {
                        bloc.add(SelectLeevelId(id: type));
                      },
                      items: state.questionLevel,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectLevelId == -1)
                      TextB(text: LocaleKeys.quesLevel.tr(), fontColor: bRed),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      textInputType: TextInputType.number,
                      fieldTitle: LocaleKeys.quesMark.tr(),
                      hintText: LocaleKeys.enterQuesMark.tr(),
                      borderColor: bGray12,
                      focusNode: markFocusnode,
                      controller: markController,
                      onChanged: (String value) {
                        bloc.add(ChangeMark(mark: value));
                      },
                      errorText:
                          state.forms == Forms.invalid && state.mark.isEmpty
                              ? LocaleKeys.enterQuesMark.tr()
                              : '',
                    ),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.questionType.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.questionTypeId,
                      selected: (dynamic type) {
                        bloc.add(SelectQuestionTypeId(id: type));
                      },
                      items: const [
                        DropdownItem(name: "Select", value: -1),
                        DropdownItem(name: "MCQ", value: 1),
                        DropdownItem(name: "True False", value: 2),
                        DropdownItem(name: "Short Question", value: 3),
                      ],
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectLevelId == -1)
                      TextB(text: LocaleKeys.quesLevel.tr(), fontColor: bRed),
                    //==============MCQ===============================================
                    const Gap(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextB(
                          text: LocaleKeys.ansOption.tr(),
                          textStyle: bBase,
                        ),
                        const Gap(10),
                        ...List.generate(
                          state.mcqOptions.length,
                          (index) => Container(
                            color: bGray4,
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  leading: SizedBox(
                                    width: 40,
                                    child: Radio<int>(
                                      value: index,
                                      groupValue: state.selectedMcqOption,
                                      onChanged: (int? value) {
                                        bloc.add(SelectMcqOptions(
                                            optionIndex: value));
                                      },
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: TextFieldB(
                                          borderColor: bGray12,
                                          focusNode:
                                              state.mcqOptions[index].focusnode,
                                          controller: state.mcqOptions[index]
                                              .textEditingController,
                                          onChanged: (String value) {
                                            // bloc.add(ChangeTitle(title: value));
                                          },
                                        ),
                                      ),
                                      const Gap(10),
                                      GestureDetector(
                                        onTap: () {
                                          bloc.add(GetOptionFile(index: index));
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                              color: kSecondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: SvgPicture.asset(
                                            fileAttachSvg,
                                            colorFilter: const ColorFilter.mode(
                                                bWhite, BlendMode.srcIn),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (getFileName(
                                        state.optionImage[index].path) !=
                                    "02943e5368adf6cc72f4a2e0a435090b.pdf")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextB(
                                        text: getFileName(
                                            state.optionImage[index].path),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          bloc.add(
                                              RemoveOptionFile(index: index));
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: bRed,
                                        ),
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              child: const TextB(
                                text: "+ Add New",
                                textStyle: bSub1,
                                fontColor: kSecondaryColor,
                              ),
                              onPressed: () {
                                bloc.add(AddOptions());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(10),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.explanation.tr(),
                      hintText: LocaleKeys.explanation.tr(),
                      borderColor: bGray12,
                      focusNode: markFocusnode,
                      controller: markController,
                      onChanged: (String value) {
                        bloc.add(Explanation(explanation: value));
                      },
                      errorText:
                          state.forms == Forms.invalid && state.mark.isEmpty
                              ? LocaleKeys.enterQuesMark.tr()
                              : '',
                    ),
                    const Gap(20),
                    ButtonB(
                      heigh: 60,
                      text: state.qId == -1
                          ? LocaleKeys.create.tr()
                          : LocaleKeys.save.tr(),
                      press: () {
                        bloc.add(
                          PressToCreate(
                            isDraft: false,
                            titleFocusnode: titleFocusnode,
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonB(
                            heigh: 60,
                            fontSize: 15,
                            bgColor: kSecondaryColor,
                            horizontalPadding: 5,
                            text: LocaleKeys.saveAsDraft.tr(),
                            press: () {
                              bloc.add(
                                PressToCreate(
                                  isDraft: true,
                                  titleFocusnode: titleFocusnode,
                                ),
                              );
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
