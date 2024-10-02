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
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/date_time_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/radio_button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/core/widgets/time_picker.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/widgets/batch_card.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_create/bloc/meeting_create_bloc.dart';

class MeetingCreateScreen extends StatelessWidget {
  const MeetingCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MeetingCreateBloc>();
    final titleFocusnode = FocusNode();
    final startDateFocusnode = FocusNode();
    final startTimeFocusnode = FocusNode();
    final endTimeFocusnode = FocusNode();
    final meetingLinkFocusnode = FocusNode();

    final titleController = TextEditingController();
    final startController = TextEditingController();
    final startTimeController = TextEditingController();
    final endTimeController = TextEditingController();
    final meetingLinkController = TextEditingController();

    QuillController qcontroller = QuillController.basic();
    MultiValueDropDownController cntMulti = MultiValueDropDownController();

    return BlocBuilder<MeetingCreateBloc, MeetingCreateState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.meetingDetails.data != null &&
              state.meetingDetails.data!.meetingStudents!.isNotEmpty) {
            final data = state.meetingDetails.data!;

            var delta = HtmlToDelta().convert(data.description!);
            qcontroller.document = Document.fromDelta(delta);

            List<int> batchIds = [];
            List<DropDownValueModel> modalData = [];
            List<AgendaInput> agenda = [];

            for (int i = 0; i < data.meetingBatches!.length; i++) {
              batchIds.add(data.meetingBatches![i]);
            }

            for (int i = 0; i < state.sectionList.length; i++) {
              if (batchIds.contains(state.sectionList[i].value)) {
                modalData.add(DropDownValueModel(
                    name: state.sectionList[i].name,
                    value: state.sectionList[i].value));
              }
            }

            for (int i = 0; i < data.agenda!.length; i++) {
              agenda.add(
                AgendaInput(
                  focusnode: FocusNode(),
                  textEditingController:
                      TextEditingController(text: data.agenda![i].title),
                ),
              );
            }

            cntMulti = MultiValueDropDownController(
              data: modalData,
            );
            bloc.add(SelectSectionList(sectionList: modalData));

            bloc.add(AddData(
              title: data.title!,
              startDate: data.date!,
              agenda: agenda,
              meetingType: data.meetingType!,
              link: data.meetingLink ?? '',
              selectedVersionId: data.batch!.versionId!,
              selectedClassId: data.batch!.classId!,
              startTime: data.startTime!,
              endTime: data.endTime!,
            ));
          } else if (state.meetingDetails.data == null &&
              state.meetingId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.meeting.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        titleController.text = state.title;
        meetingLinkController.text = state.link;
        startController.text = state.date;
        startTimeController.text = state.startTime;
        endTimeController.text = state.endTime;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.meeting.tr(),
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
                    const Gap(20),
                    const TextB(
                      text: "Agenda",
                      textStyle: bBaseM,
                      fontColor: bBlack,
                    ),
                    const Gap(10),
                    ...List.generate(
                      state.agenda.length,
                      (index) => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFieldB(
                                  borderColor: bGray12,
                                  focusNode: state.agenda[index].focusnode,
                                  controller:
                                      state.agenda[index].textEditingController,
                                  onChanged: (String value) {
                                    bloc.add(ChangeTitle(title: value));
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  bloc.add(DeleteAgenda(index: index));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: bRed,
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                        ],
                      ),
                    ),
                    if (state.agenda.isEmpty)
                      const TextB(
                        text: "No agenda is selected!",
                        textStyle: bBase2,
                        fontColor: bRed,
                      ),
                    const Gap(10),
                    Row(
                      children: [
                        TextButton(
                          child: const TextB(
                            text: "+ Add New",
                            textStyle: bSub1,
                            fontColor: kSecondaryColor,
                          ),
                          onPressed: () {
                            bloc.add(AddAgenda());
                          },
                        ),
                      ],
                    ),
                    const Gap(20),
                    const TextB(
                      text: "Meeting type",
                      fontColor: bBlack,
                      fontSize: 16,
                    ),
                    const Gap(10),
                    RadioGroupB(
                      radioValues: [
                        RadioValue(name: "Online", value: 1),
                        RadioValue(name: "Offline", value: 2),
                      ],
                      grid: 2,
                      color: bGray100,
                      defaultValue: state.meetingType, // state.condition,
                      value: (value) {
                        bloc.add(GetMeetingType(type: value));
                      },
                    ),
                    const Gap(20),

                    TextFieldB(
                      fieldTitle: LocaleKeys.meetingLink.tr(),
                      hintText: LocaleKeys.enterMeetingLinkHere.tr(),
                      borderColor: bGray12,
                      bgColor: state.meetingType == 2 ? bInnerBg : bWhite,
                      focusNode: meetingLinkFocusnode,
                      controller: meetingLinkController,
                      isReadOnly: state.meetingType == 2,
                      onChanged: (String value) {
                        bloc.add(ChangeMeetingLink(link: value));
                      },
                      errorText: state.forms == Forms.invalid &&
                              state.link.isEmpty &&
                              state.meetingType == 1
                          ? LocaleKeys.enterMeetingLinkHere.tr()
                          : '',
                    ),

                    const Gap(20),
                    TextFieldB(
                      isMandatory: true,
                      fieldTitle: LocaleKeys.date.tr(),
                      hintText: LocaleKeys.selectDate.tr(),
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
                                initialdate: state.date) ??
                            '';
                        bloc.add(StartDate(startDate: startController.text));
                      },
                    ),
                    if (state.forms == Forms.invalid && state.date.isEmpty)
                      TextB(
                        text: LocaleKeys.noDateIsSelected.tr(),
                        fontColor: bRed,
                      ),

                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.startTime.tr(),
                            hintText: LocaleKeys.selectTime.tr(),
                            borderColor: bGray12,
                            focusNode: startTimeFocusnode,
                            controller: startTimeController,
                            isReadOnly: true,
                            suffixIcon: const Icon(
                              Icons.schedule,
                              size: 30,
                              color: bGray32,
                            ),
                            onChanged: (String value) {},
                            onTouch: () async {
                              startTimeController
                                  .text = await showTimePickerDialog(context,
                                      initialTime:
                                          convertToDateTime(state.startTime)) ??
                                  '';

                              bloc.add(StartTime(
                                  startTime: startTimeController.text));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.startTime.isEmpty
                                ? LocaleKeys.noStartTime.tr()
                                : '',
                          ),
                        ),
                        const Gap(20),
                        Expanded(
                          child: TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.endTime.tr(),
                            hintText: LocaleKeys.selectTime.tr(),
                            borderColor: bGray12,
                            focusNode: endTimeFocusnode,
                            controller: endTimeController,
                            isReadOnly: true,
                            suffixIcon: const Icon(
                              Icons.schedule,
                              size: 30,
                              color: bGray32,
                            ),
                            onChanged: (String value) {},
                            onTouch: () async {
                              endTimeController
                                  .text = await showTimePickerDialog(context,
                                      initialTime:
                                          convertToDateTime(state.endTime)) ??
                                  '';
                              bloc.add(
                                  EndTime(endTime: endTimeController.text));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.endTime.isEmpty
                                ? LocaleKeys.noEndTime.tr()
                                : '',
                          ),
                        ),
                      ],
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
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      setState: state.setClass,
                      label: LocaleKeys.classStr.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectedClassId,
                      selected: (dynamic type) {
                        bloc.add(SelectClassId(id: type));
                        cntMulti.clearDropDown();
                      },
                      items: state.classList,
                    ),

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
                      TextB(
                          text: LocaleKeys.plsSelSection.tr(), fontColor: bRed),

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
                      text: state.meetingId == -1
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
                            dateFocusnode: startDateFocusnode,
                            startTimeFocusnode: startTimeFocusnode,
                            endTimeFocusnode: endTimeFocusnode,
                            linkFocusnode: meetingLinkFocusnode,
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
                                  dateFocusnode: startDateFocusnode,
                                  startTimeFocusnode: startTimeFocusnode,
                                  endTimeFocusnode: endTimeFocusnode,
                                  linkFocusnode: meetingLinkFocusnode,
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

  DateTime convertToDateTime(String time) {
    if (time.isNotEmpty) {
      DateTime dateTime = DateFormat.jm().parse(time);
      return dateTime;
    } else {
      return DateTime.now();
    }
  }
}
