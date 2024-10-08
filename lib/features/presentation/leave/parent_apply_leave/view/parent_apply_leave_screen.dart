import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/check_box.dart';
import 'package:school_of_future/core/widgets/date_picker.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/grid_view_file_image.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/leave/parent_apply_leave/bloc/apply_leave_bloc.dart';

class ParentApplyLeaveScreen extends StatelessWidget {
  const ParentApplyLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleFocusnode = FocusNode();
    final startDateFocusnode = FocusNode();
    final endDateFocusnode = FocusNode();
    final descriptionFocusnode = FocusNode();

    final titleController = TextEditingController();
    final startController = TextEditingController();
    final endController = TextEditingController();
    final descriptionController = TextEditingController();

    return BlocBuilder<ApplyLeaveBloc, ApplyLeaveState>(
      builder: (context, state) {
        final bloc = context.read<ApplyLeaveBloc>();
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
                  const Gap(10),
                  DropdownFieldB(
                    dropdownHeight: 55,
                    label: "Leave Type",
                    dropDownValue: state.leaveType,
                    selected: (dynamic type) {
                      bloc.add(SelectLeaveType(value: type));
                    },
                    items: const [
                      DropdownItem(name: "Sick leave", value: 0),
                      DropdownItem(name: "Casual leave", value: 1),
                    ],
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
                    // errorText:
                    //     state.forms == Forms.invalid && state.dateFrom.isEmpty
                    //         ? 'Select date from'
                    //         : '',
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
                    // errorText:
                    //     state.forms == Forms.invalid && state.dateTo.isEmpty
                    //         ? 'Select date to'
                    //         : '',
                  ),
                  if (state.tempDateCount > 0)
                    TextB(
                      text:
                          "${state.tempDateCount.plural('day')} you have selected for leave",
                      textStyle: bBody2,
                      fontColor: bGray100,
                    ),
                  if (state.dateCount < 0)
                    const TextB(
                      text: "Start date must be getter then end date",
                      textStyle: bBody2,
                      fontColor: bRed,
                    ),
                  const Gap(12),
                  CheckboxB(
                    label: "Half Day Leave",
                    press: (bool value) {
                      bloc.add(GetIsHalfDay(isHalfDay: value));
                    },
                    defaultValue: state.isHalfDay,
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
                  ),
                  const Gap(30),
                  ButtonB(
                    heigh: 55,
                    text: "Attach",
                    press: () {
                      //bloc.add(OpenBottomSheet());
                      bloc.add(GetFile());
                    },
                    iconPosition: "left",
                    svgIcon: "assets/images/file_attach_icon.svg",
                  ),
                  GridViewFileImageB(
                    crossAxisCount: 6,
                    images: state.leaveFile,
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonB(
                          heigh: 55,
                          text: "Apply",
                          press: () {},
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
