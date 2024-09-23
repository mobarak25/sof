import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
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
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/widgets/batch_card.dart';
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_create/bloc/class_work_create_bloc.dart';

class ClassWorkCreateScreen extends StatelessWidget {
  const ClassWorkCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClassWorkCreateBloc>();
    final titleFocusnode = FocusNode();
    final publishedAtFocusnode = FocusNode();

    final titleController = TextEditingController();
    final publishedAtController = TextEditingController();

    QuillController qcontroller = QuillController.basic();
    MultiValueDropDownController cntMulti = MultiValueDropDownController();

    return BlocBuilder<ClassWorkCreateBloc, ClassWorkCreateState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.classworkDtls.data != null &&
              state.classworkDtls.data!.assignStudents!.isNotEmpty) {
            final data = state.classworkDtls.data!;

            var delta = HtmlToDelta().convert(data.description!);
            qcontroller.document = Document.fromDelta(delta);

            List<int> batchIds = [];
            List<DropDownValueModel> modalData = [];

            for (int i = 0; i < data.sections!.length; i++) {
              batchIds.add(data.sections![i].id!);
            }

            for (int i = 0; i < state.sectionList.length; i++) {
              if (batchIds.contains(state.sectionList[i].value)) {
                modalData.add(DropDownValueModel(
                    name: state.sectionList[i].name,
                    value: state.sectionList[i].value));
              }
            }
            cntMulti = MultiValueDropDownController(
              data: modalData,
            );
            bloc.add(SelectSectionList(sectionList: modalData));

            bloc.add(AddData(
              title: data.title!,
              publishAt: data.publishedAt!,
              selectedVersionId: data.subject!.versionId!,
              selectedClassId: data.subject!.classId!,
              selectedSubjectId: data.subject!.id!,
            ));
          } else if (state.classworkDtls.data == null &&
              state.classWorkId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.createHomeWork.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        titleController.text = state.title;
        publishedAtController.text = state.publishedAt;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.createClassWork.tr(),
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
                              configurations: QuillEditorConfigurations(
                                placeholder: LocaleKeys.enterDescription.tr(),
                                padding: const EdgeInsets.symmetric(
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
                        bloc.add(GetFile());
                      },
                    ),
                    const Gap(20),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.publish.tr(),
                      hintText: "yyyy-mm-dd",
                      textInputType: TextInputType.number,
                      borderColor: bGray12,
                      focusNode: publishedAtFocusnode,
                      controller: publishedAtController,
                      isReadOnly: true,
                      suffixIcon: const Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: bGray32,
                      ),
                      onChanged: (String value) {},
                      onTouch: () async {
                        publishedAtController.text =
                            await showDateTimePickerDialog(context,
                                    initialdate: state.publishedAt) ??
                                '';
                        bloc.add(PublishDate(
                            publishedAt: publishedAtController.text));
                      },
                    ),
                    if (state.forms == Forms.invalid &&
                        state.publishedAt.isEmpty)
                      TextB(
                        text: LocaleKeys.publish.tr(),
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

                    //==============Section================
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

                    //==============Batch================
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
                      text: state.classWorkId == -1
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
