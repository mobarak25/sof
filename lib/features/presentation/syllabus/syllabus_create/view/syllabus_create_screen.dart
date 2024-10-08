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
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_time_picker.dart';
import 'package:school_of_future/core/widgets/dotted_button.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/show_file_name.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_create/bloc/syllabus_create_bloc.dart';

class SyllabusCreateScreen extends StatelessWidget {
  const SyllabusCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SyllabusCreateBloc>();

    final titleFocusnode = FocusNode();
    final dateFocusnode = FocusNode();
    final marksFocusnode = FocusNode();

    final titleController = TextEditingController();
    final dateController = TextEditingController();
    final marksController = TextEditingController();

    QuillController qcontroller = QuillController.basic();

    return BlocBuilder<SyllabusCreateBloc, SyllabusCreateState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.details.data != null) {
            final data = state.details.data!;

            var noteDelta = HtmlToDelta().convert(data.content!);
            qcontroller.document = Document.fromDelta(noteDelta);

            bloc.add(
              AddData(
                title: data.title!,
                date: data.date!,
                marks: data.mark!.toString(),
                syllabusType: data.type,
                selectedVersionId: data.versionId,
                selectedClassId: data.classId,
                selectedSubjectId: data.subjectId,
                selectedSectionId: data.sectionId,
              ),
            );
          } else if (state.details.data == null && state.syllabusId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.syllabus.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        titleController.text = state.title;
        dateController.text = state.date;
        marksController.text = state.marks;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.syllabus.tr(),
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
                    //==============Contents===================================
                    const TextB(
                      text: "Contents",
                      textStyle: TextStyle(fontSize: 16),
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
                      title: LocaleKeys.uploadSyllabus.tr(),
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
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.date.tr(),
                      hintText: "yyyy-mm-dd",
                      textInputType: TextInputType.number,
                      borderColor: bGray12,
                      focusNode: dateFocusnode,
                      controller: dateController,
                      isReadOnly: true,
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: bGray32,
                      ),
                      onChanged: (String value) {},
                      onTouch: () async {
                        dateController.text = await showDateTimePickerDialog(
                                context,
                                initialdate: state.date) ??
                            '';
                        bloc.add(PublishDate(publishedAt: dateController.text));
                      },
                    ),
                    if (state.forms == Forms.invalid && state.date.isEmpty)
                      TextB(
                        text: LocaleKeys.noDateIsSelected.tr(),
                        fontColor: bRed,
                      ),
                    const Gap(10),
                    TextFieldB(
                      textInputType: TextInputType.number,
                      fieldTitle: LocaleKeys.marks.tr(),
                      hintText: LocaleKeys.enterMark.tr(),
                      borderColor: bGray12,
                      focusNode: marksFocusnode,
                      controller: marksController,
                      onChanged: (String value) {
                        bloc.add(ChangeMarks(marks: value));
                      },
                    ),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.type.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.syllabusType,
                      selected: (dynamic type) {
                        bloc.add(SelectSyllabusType(type: type));
                      },
                      items: const [
                        DropdownItem(name: "Select", value: -1),
                        DropdownItem(name: "Class test", value: "class-test"),
                        DropdownItem(name: "Quiz test", value: "quiz-test"),
                      ],
                    ),
                    if (state.forms == Forms.invalid &&
                        state.syllabusType == -1)
                      TextB(
                          text: LocaleKeys.noTypeIsSelected.tr(),
                          fontColor: bRed),
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
                    const Gap(30),
                    ButtonB(
                      heigh: 60,
                      text: state.syllabusId == -1
                          ? LocaleKeys.create.tr()
                          : LocaleKeys.save.tr(),
                      press: () {
                        List jsonContent =
                            qcontroller.document.toDelta().toJson();

                        final htmlContent =
                            QuillJsonToHTML.encodeJson(jsonContent);

                        bloc.add(
                          PressToCreate(
                            isDraft: false,
                            content: htmlContent,
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
                              List jsonContent =
                                  qcontroller.document.toDelta().toJson();

                              final htmlContent =
                                  QuillJsonToHTML.encodeJson(jsonContent);

                              bloc.add(
                                PressToCreate(
                                  isDraft: true,
                                  content: htmlContent,
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
