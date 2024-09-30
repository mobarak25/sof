import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:gap/gap.dart';
import 'package:quill_json_to_html/json_to_html.dart';
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
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_create/bloc/lesson_plan_create_bloc.dart';

class LessonPlanCreateScreen extends StatelessWidget {
  const LessonPlanCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LessonPlanCreateBloc>();
    final titleFocusnode = FocusNode();
    final titleController = TextEditingController();

    QuillController qcontroller = QuillController.basic();
    QuillController objController = QuillController.basic();

    return BlocBuilder<LessonPlanCreateBloc, LessonPlanCreateState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.planDtls.data != null) {
            final data = state.planDtls.data!;

            var noteDelta = HtmlToDelta().convert(data.content!);
            qcontroller.document = Document.fromDelta(noteDelta);

            var objDelta = HtmlToDelta().convert(data.objectives!);
            objController.document = Document.fromDelta(objDelta);

            //here data.resourceType == 1 is means video

            bloc.add(
              AddData(
                title: data.title!,
                selectedVersionId: data.version!.id!,
                selectedClassId: data.dataClass!.id!,
                selectedSubjectId: data.subject!.id!,
                selectedSectionId: data.section!.id!,
              ),
            );
          } else if (state.planDtls.data == null && state.planId != -1) {
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
            title: LocaleKeys.createLessonPlan.tr(),
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
                    const Gap(20),
                    //==============Notes===================================
                    TextB(
                      text: LocaleKeys.notes.tr(),
                      textStyle: const TextStyle(fontSize: 16),
                      fontColor: bGray100,
                    ),
                    const Gap(5),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: bWhite,
                        border: Border.all(color: bGray12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 240,
                      child: Column(
                        children: [
                          QuillSimpleToolbar(
                            controller: qcontroller,
                            configurations:
                                const QuillSimpleToolbarConfigurations(
                              multiRowsDisplay: false,
                              toolbarSize: 45,
                            ),
                          ),
                          Expanded(
                            child: QuillEditor.basic(
                              controller: qcontroller,
                              configurations: const QuillEditorConfigurations(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        bloc.add(OpenBottomSheet());
                      },
                    ),
                    Column(
                      children: [
                        const Gap(5),
                        TextB(
                          text:
                              "${state.checkedIds.length.plural('resource')} is selected",
                          textStyle: bBaseM,
                          fontColor: bJungleGreen,
                        ),
                      ],
                    ),
                    const Gap(20),
                    //==============learning Objectives===================
                    TextB(
                      text: LocaleKeys.learningObjectives.tr(),
                      textStyle: const TextStyle(fontSize: 16),
                      fontColor: bGray100,
                    ),
                    const Gap(5),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: bWhite,
                        border: Border.all(color: bGray12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 240,
                      child: Column(
                        children: [
                          QuillSimpleToolbar(
                            controller: objController,
                            configurations:
                                const QuillSimpleToolbarConfigurations(
                              multiRowsDisplay: false,
                              toolbarSize: 45,
                            ),
                          ),
                          Expanded(
                            child: QuillEditor.basic(
                              controller: objController,
                              configurations: const QuillEditorConfigurations(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
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
                      label: LocaleKeys.section.tr(),
                      labelColor: bBlack,
                      setState: state.setSection,
                      dropDownValue: state.selectSectionId,
                      selected: (dynamic type) {
                        bloc.add(SelectSectionId(id: type));
                      },
                      items: state.sectionList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectSectionId == -1)
                      TextB(
                          text: LocaleKeys.selectSection.tr(), fontColor: bRed),
                    const Gap(20),
                    ButtonB(
                      heigh: 60,
                      text: state.planId == -1
                          ? LocaleKeys.create.tr()
                          : LocaleKeys.save.tr(),
                      press: () {
                        List noteContent =
                            qcontroller.document.toDelta().toJson();
                        final noteHtmlContent =
                            QuillJsonToHTML.encodeJson(noteContent);

                        List objectivesContent =
                            objController.document.toDelta().toJson();
                        final objHtmlContent =
                            QuillJsonToHTML.encodeJson(objectivesContent);

                        bloc.add(
                          PressToCreate(
                            isDraft: false,
                            content: noteHtmlContent,
                            objectiveContent: objHtmlContent,
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
                              List noteContent =
                                  qcontroller.document.toDelta().toJson();
                              final noteHtmlContent =
                                  QuillJsonToHTML.encodeJson(noteContent);

                              List objectivesContent =
                                  objController.document.toDelta().toJson();
                              final objHtmlContent =
                                  QuillJsonToHTML.encodeJson(objectivesContent);
                              bloc.add(
                                PressToCreate(
                                  isDraft: true,
                                  content: noteHtmlContent,
                                  objectiveContent: objHtmlContent,
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
