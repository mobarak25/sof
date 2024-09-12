import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/check_box.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/features/presentation/assignment/selected_students/bloc/select_students_bloc.dart';

class SelectedStudentsScreen extends StatelessWidget {
  const SelectedStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectStudentsBloc, SelectStudentsState>(
      builder: (context, state) {
        final bloc = context.read<SelectStudentsBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.selectedStudents.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            color: bWhite,
            child: state.allStudents.data != null
                ? Column(
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
                            Flexible(
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: const Text('Student Name'),
                                value: state.selectAll,
                                onChanged: (bool? value) {
                                  bloc.add(ToggleSelectAll(value: value!));
                                },
                              ),
                            ),
                            // CheckboxB(
                            //   label: "Student Name",
                            //   fontColor: bBlack,
                            //   press: (bool value) {
                            //     bloc.add(ToggleSelectAll(value: value));
                            //   },
                            //   defaultValue: state.selectAll,
                            // ),
                            const TextB(
                              text: "Roll",
                              fontSize: 16,
                              fontColor: bBlack,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          children: [
                            ...List.generate(state.allStudents.data!.length,
                                (position) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // CheckboxB(
                                  //   fontSize: 13,
                                  //   label:
                                  //       state.allStudents.data![position].name!,
                                  //   press: (bool value) {
                                  //     bloc.add(ToggleCheckbox(
                                  //         value: value, index: position));
                                  //   },
                                  //   defaultValue:
                                  //       state.selectedOptions[position],
                                  // ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: TextB(
                                        text: state
                                            .allStudents.data![position].name!,
                                        fontSize: 13,
                                      ),
                                      value: state.selectedOptions[position],
                                      onChanged: (bool? value) {
                                        print(value);
                                        bloc.add(ToggleCheckbox(
                                            value: value!, index: position));
                                      },
                                    ),
                                  ),
                                  TextB(
                                    text: state.allStudents.data![position]
                                        .admissionNumber!,
                                    fontSize: 13,
                                  )
                                ],
                              );

                              // TextB(text: students.data![position].name!);
                            })
                          ],
                        ),
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ButtonB(
                          heigh: 60,
                          text: "Save",
                          press: () {
                            Navigator.pop(context, state.selectedOptions);
                          },
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        );
      },
    );
  }
}
