import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/assignment/selected_students/bloc/select_students_bloc.dart';

class SelectedStudentsScreen extends StatelessWidget {
  const SelectedStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchFocusNode = FocusNode();
    final searchController = TextEditingController();

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
            child: state.allStudents.isNotEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: TextFieldB(
                          focusNode: searchFocusNode,
                          controller: searchController,
                          borderColor: bGray12,
                          hintText: LocaleKeys.search.tr(),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                            color: kPrimaryColor,
                          ),
                          onChanged: (String value) {
                            bloc.add(ChageSearch(search: value));
                          },
                        ),
                      ),
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
                            if (state.copyStudents.isEmpty)
                              ...List.generate(state.allStudents.length,
                                  (position) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: TextB(
                                          text:
                                              state.allStudents[position].name,
                                          fontSize: 13,
                                        ),
                                        value: state
                                            .allStudents[position].isChecked,
                                        onChanged: (bool? value) {
                                          bloc.add(ToggleCheckbox(
                                              value: value!,
                                              id: state
                                                  .allStudents[position].id));
                                        },
                                      ),
                                    ),
                                    TextB(
                                      text: state
                                          .allStudents[position].admissionRoll,
                                      fontSize: 13,
                                    )
                                  ],
                                );

                                // TextB(text: students.data![position].name!);
                              })
                            else
                              ...List.generate(state.copyStudents.length,
                                  (position) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: TextB(
                                          text:
                                              state.copyStudents[position].name,
                                          fontSize: 13,
                                        ),
                                        value: state
                                            .copyStudents[position].isChecked,
                                        onChanged: (bool? value) {
                                          bloc.add(ToggleCheckbox(
                                              value: value!,
                                              id: state
                                                  .copyStudents[position].id));
                                        },
                                      ),
                                    ),
                                    TextB(
                                      text: state
                                          .copyStudents[position].admissionRoll,
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
                            Navigator.pop(context, state.allStudents);
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
