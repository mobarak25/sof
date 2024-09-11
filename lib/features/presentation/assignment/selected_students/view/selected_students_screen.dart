import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/check_box.dart';
import 'package:school_of_future/features/presentation/assignment/selected_students/bloc/select_students_bloc.dart';

class SelectedStudentsScreen extends StatelessWidget {
  const SelectedStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectStudentsBloc, SelectStudentsState>(
      builder: (context, state) {
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.selectedStudents.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: state.allStudents.data != null
                ? Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            ...List.generate(state.allStudents.data!.length,
                                (position) {
                              return CheckboxB(
                                label: state.allStudents.data![position].name!,
                                press: (bool value) {},
                                defaultValue: true,
                              );

                              // TextB(text: students.data![position].name!);
                            })
                          ],
                        ),
                      ),
                      const Gap(10),
                      ButtonB(
                          heigh: 60,
                          text: "Save",
                          press: () {
                            Navigator.pop(context, "mobarak========");
                          }),
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
