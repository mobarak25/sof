import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:gap/gap.dart';
import 'package:quill_json_to_html/json_to_html.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_time_picker.dart';
import 'package:school_of_future/core/widgets/dotted_button.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/show_file_name.dart';
import 'package:school_of_future/core/widgets/switch_view.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/bloc/assignment_create_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/widgets/batch_card.dart';

class AssignmentCreateScreen extends StatelessWidget {
  const AssignmentCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AssignmentCreateBloc>();
    final titleFocusnode = FocusNode();
    final markFocusnode = FocusNode();
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();

    final titleController = TextEditingController();
    final markController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();

    QuillController qController = QuillController.basic();
    MultiValueDropDownController cntMulti = MultiValueDropDownController();

    return BlocBuilder<AssignmentCreateBloc, AssignmentCreateState>(
      builder: (context, state) {
        if (state.isFirstTime && state.assingmentDtls.data != null) {
          final data = state.assingmentDtls.data!;
          bloc.add(AddData(
            title: data.title!,
            description: data.description!,
            mark: data.marks!,
            startDate: data.publishedAt!,
            endDate: data.dueAt!,
            selectedVersionId: data.subject!.versionId!,
            selectedClassId: data.subject!.classId!,
            selectedSubjectId: data.subject!.id,
            assignToBatchId: const [1],
          ));
        }

        titleController.text = state.title;
        markController.text = state.mark;
        startController.text = state.startDate;
        endController.text = state.endDate;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.createHomeWork.tr(),
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
                    TextB(
                      text: LocaleKeys.description.tr(),
                      textStyle: const TextStyle(fontSize: 16),
                      fontColor: bGray100,
                    ),
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
                          QuillToolbar.simple(
                            configurations: QuillSimpleToolbarConfigurations(
                              // sharedConfigurations: const QuillSharedConfigurations(
                              //   locale: Locale('de'),
                              // ),
                              controller: qController,
                              multiRowsDisplay: false,
                              toolbarSize: 50,
                            ),
                          ),
                          Expanded(
                            child: QuillEditor.basic(
                              configurations: QuillEditorConfigurations(
                                  controller: qController,
                                  padding: const EdgeInsets.all(10),
                                  readOnly: false,
                                  showCursor: true

                                  // sharedConfigurations: const QuillSharedConfigurations(
                                  //   locale: Locale('de'),
                                  // ),
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
                        bloc.add(GetFile());
                      },
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.onlineSubmission.tr(),
                          textStyle: bBody1,
                        ),
                        SwitchView(
                          onChanged: (bool value) {
                            bloc.add(Submitable(isSubmitable: value));
                          },
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextB(
                          text: LocaleKeys.assessment.tr(),
                          textStyle: bBody1,
                        ),
                        SwitchView(
                          onChanged: (bool value) {
                            bloc.add(Assessment(isAssessment: value));
                          },
                        ),
                      ],
                    ),
                    const Gap(20),
                    TextFieldB(
                      hintText: LocaleKeys.enterMark.tr(),
                      textInputType: TextInputType.number,
                      borderColor: bGray12,
                      focusNode: markFocusnode,
                      controller: markController,
                      isReadOnly: !state.isAssessment,
                      onChanged: (String value) {
                        bloc.add(ChangeMark(mark: value));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.isAssessment &&
                              state.mark.isEmpty
                          ? LocaleKeys.enterMark.tr()
                          : '',
                    ),
                    const Gap(20),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.startDate.tr(),
                      hintText: LocaleKeys.selectDate.tr(),
                      textInputType: TextInputType.number,
                      borderColor: bGray12,
                      focusNode: startDateFocusnode,
                      controller: startController,
                      isReadOnly: true,
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: bGray32,
                      ),
                      onChanged: (String value) {},
                      onTouch: () async {
                        startController.text = await showDateTimePickerDialog(
                                context,
                                initialdate: state.startDate) ??
                            '';
                        bloc.add(StartDate(startDate: startController.text));
                      },
                    ),
                    if (state.forms == Forms.invalid && state.startDate.isEmpty)
                      TextB(
                        text: LocaleKeys.noStartDate.tr(),
                        fontColor: bRed,
                      ),
                    const Gap(20),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.endDate.tr(),
                      hintText: LocaleKeys.selectEndDate.tr(),
                      borderColor: bGray12,
                      focusNode: endDateFocusnode,
                      controller: endController,
                      isReadOnly: true,
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: bGray32,
                      ),
                      onChanged: (String value) {},
                      onTouch: () async {
                        endController.text = await showDateTimePickerDialog(
                                context,
                                initialdate: state.endDate) ??
                            '';
                        bloc.add(EndDate(endDate: endController.text));
                      },
                    ),
                    if (state.forms == Forms.invalid && state.endDate.isEmpty)
                      TextB(
                        text: LocaleKeys.noEndDate.tr(),
                        fontColor: bRed,
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
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.subject.tr(),
                      labelColor: bBlack,
                      setState: state.setSubject,
                      dropDownValue: state.selectedSubjectId,
                      selected: (dynamic type) {
                        bloc.add(SelectSubjectId(id: type));
                        cntMulti.clearDropDown();
                      },
                      items: state.subjectList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedSubjectId == -1)
                      TextB(text: LocaleKeys.subject.tr(), fontColor: bRed),
                    const Gap(10),
                    TextB(text: LocaleKeys.section.tr(), textStyle: bBody1),
                    SizedBox(
                      height: 50,
                      child: DropDownTextField.multiSelection(
                        dropDownIconProperty: IconProperty(
                          icon: Icons.keyboard_arrow_down,
                          color: bGray,
                        ),
                        textFieldDecoration: InputDecoration(
                            hintText: "Select",
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: bGray,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            fillColor: bWhite,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: bGray12),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: bGray12),
                              borderRadius: BorderRadius.circular(7),
                            )),
                        controller: cntMulti,
                        displayCompleteItem: true,
                        clearOption: false,
                        checkBoxProperty:
                            CheckBoxProperty(activeColor: bPrimaryColor),
                        dropDownList: state.sectionList,
                        onChanged: (list) {
                          bloc.add(SelectSectionList(sectionList: list));
                        },
                      ),
                    ),
                    if (state.forms == Forms.invalid &&
                        state.assignToBatchId.isEmpty)
                      TextB(text: LocaleKeys.section.tr(), fontColor: bRed),
                    const Gap(10),
                    if (state.batchWiseStudent.isNotEmpty &&
                        !state.batchLoading)
                      BachCard(
                        assignToBatchId: state.assignToBatchId,
                        selectedBatchName: state.selectedBatchName,
                        selecteClassName: state.selecteClassName,
                        press: (int index) {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(selectedStudentsScreen,
                                  arguments:
                                      state.listOfCheckUncheckStudent[index])
                              .then((value) {
                            final backWithUnselected =
                                value as List<CheckUncheckStudents>;

                            bloc.add(BackWithUnselected(
                                students: backWithUnselected, index: index));
                          });
                        },
                      ),
                    if (state.batchLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    const Gap(30),
                    ButtonB(
                      heigh: 60,
                      text: LocaleKeys.create.tr(),
                      press: () {
                        List jsonContent =
                            qController.document.toDelta().toJson();

                        final htmlContent =
                            QuillJsonToHTML.encodeJson(jsonContent);

                        bloc.add(
                          PressToCreate(
                            isDraft: false,
                            content: htmlContent,
                            titleFocusnode: titleFocusnode,
                            markFocusnode: markFocusnode,
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
                                  qController.document.toDelta().toJson();

                              final htmlContent =
                                  QuillJsonToHTML.encodeJson(jsonContent);
                              bloc.add(
                                PressToCreate(
                                  isDraft: true,
                                  content: htmlContent,
                                  titleFocusnode: titleFocusnode,
                                  markFocusnode: markFocusnode,
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
