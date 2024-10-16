import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/doc_viewer.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_details/bloc/teacher_full_syllabus_details_bloc.dart';

class StudentSyllabusScreen extends StatelessWidget {
  const StudentSyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<TeacherFullSyllabusDetailsBloc,
        TeacherFullSyllabusDetailsState>(
      builder: (context, state) {
        final bloc = context.read<TeacherFullSyllabusDetailsBloc>();

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.syllabus.tr(),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: DocViewer(
                url: state.studentFullSyllabus.data![index].url!,
              ),
            ),
          ),
        );
      },
    );
  }
}
