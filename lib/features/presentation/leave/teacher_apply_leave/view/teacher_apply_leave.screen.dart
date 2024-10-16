import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/dotted_button.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/show_file_name.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/leave/teacher_apply_leave/bloc/teacher_apply_leave_bloc.dart';

class TeacherApplyLeaveScreen extends StatelessWidget {
  const TeacherApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final descriptionFocusnode = FocusNode();

    final startController = TextEditingController();
    final endController = TextEditingController();
    final descriptionController = TextEditingController();

    return BlocBuilder<TeacherApplyLeaveBloc, TeacherApplyLeaveState>(
      builder: (context, state) {
        final bloc = context.read<TeacherApplyLeaveBloc>();

        if (state.isFirstTime) {
          if (state.details.data != null &&
              state.leaveList.data != null &&
              state.leaveDropdown.length > 1) {
            final data = state.details.data!;

            bloc.add(AddData(
              startDate: data.fromDate!,
              endDate: data.toDate!,
              desc: data.comment!,
              selectedType: data.leaveTypeId,
              isHalfDay: data.applicationType == 2 ? true : false,
              isEmergency: data.isEmergency == 1 ? true : false,
            ));
          } else if ((state.details.data == null ||
                  state.leaveList.data == null) &&
              state.leaveDropdown.length == 1 &&
              state.leaveId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.leave.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        startController.text = state.startDate;
        endController.text = state.endDate;
        descriptionController.text = state.description;
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.leave.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            color: bInnerBg,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownFieldB(
                    dropdownHeight: 55,
                    label: LocaleKeys.leaveType.tr(),
                    dropDownValue: state.leaveType,
                    selected: (dynamic type) {
                      bloc.add(SelectLeaveType(value: type));
                    },
                    items: state.leaveDropdown,
                  ),
                  if (state.forms == Forms.invalid && state.leaveType == -1)
                    TextB(
                      text: LocaleKeys.selectLeaveType.tr(),
                      textStyle: bBase2,
                      fontColor: bRed,
                    ),
                  const Gap(12),
                  TextFieldB(
                    fieldTitle: "Start Date",
                    hintText: "Select start date",
                    focusNode: startDateFocusnode,
                    controller: startController,
                    borderColor: bGray12,
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      size: 30,
                      color: bGray32,
                    ),
                    isReadOnly: true,
                    onChanged: () {},
                    onTouch: () {
                      datePicker(
                        context,
                        date: (DateTime date) {
                          bloc.add(
                            SelectStartDate(
                              startDate: date,
                              startController: startController,
                              endController: endController,
                            ),
                          );
                        },
                      );
                    },
                    errorText:
                        state.forms == Forms.invalid && state.startDate.isEmpty
                            ? LocaleKeys.noStartDate.tr()
                            : '',
                  ),
                  const Gap(12),
                  TextFieldB(
                    fieldTitle: "End Date",
                    hintText: "Select end date",
                    focusNode: endDateFocusnode,
                    controller: endController,
                    borderColor: bGray12,
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      size: 30,
                      color: bGray32,
                    ),
                    isReadOnly: true,
                    onChanged: (String title) {},
                    onTouch: () {
                      datePicker(
                        context,
                        intDate: state.startDate.isNotEmpty
                            ? DateTime.parse(state.startDate)
                            : null,
                        date: (DateTime date) {
                          bloc.add(
                            SelectEnd(
                              endDate: date,
                              startController: startController,
                              endController: endController,
                            ),
                          );
                        },
                      );
                    },
                    errorText:
                        state.forms == Forms.invalid && state.endDate.isEmpty
                            ? LocaleKeys.noEndDate.tr()
                            : '',
                  ),
                  if (state.tempDateCount > 0)
                    TextB(
                      text:
                          "${state.tempDateCount.plural('day')} you have selected for leave",
                      textStyle: bBody2,
                      fontColor: kSecondaryColor,
                    ),
                  if (state.dateCount < 0)
                    const TextB(
                      text: "Start date must be getter then end date",
                      textStyle: bBody2,
                      fontColor: bRed,
                    ),
                  const Gap(12),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const TextB(
                      text: "Half Day Leave",
                      fontSize: 16,
                    ),
                    value: state.isHalfDay,
                    onChanged: (bool? value) {
                      bloc.add(GetIsHalfDay(isHalfDay: value!));
                    },
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: TextB(
                      text: LocaleKeys.isEmergency.tr(),
                      fontSize: 16,
                    ),
                    value: state.isEmergency,
                    onChanged: (bool? value) {
                      bloc.add(GetIsEmergency(isEmergency: value!));
                    },
                  ),
                  const Gap(20),
                  TextFieldB(
                    fieldTitle: "Describe the reason of leave:",
                    hintText: "Enter Description",
                    focusNode: descriptionFocusnode,
                    controller: descriptionController,
                    borderColor: bGray12,
                    maxLines: 7,
                    onChanged: (String desc) {
                      bloc.add(ChangeDescription(desc: desc));
                    },
                    errorText: state.forms == Forms.invalid &&
                            state.description.isEmpty
                        ? LocaleKeys.enterDescription.tr()
                        : '',
                  ),
                  const Gap(20),
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
                  const Gap(30),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonB(
                          heigh: 55,
                          text: "Apply",
                          press: () {
                            bloc.add(PressToApply(
                              startFocusnode: startDateFocusnode,
                              endFocusnode: endDateFocusnode,
                              descFocusnode: descriptionFocusnode,
                            ));
                          },
                        ),
                      ),
                      const Gap(15),
                      Expanded(
                        child: ButtonB(
                          heigh: 55,
                          bgColor: bGray12,
                          textColor: bGray52,
                          text: "Cancel",
                          press: () {},
                        ),
                      ),
                    ],
                  ),
                  const Gap(120),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
