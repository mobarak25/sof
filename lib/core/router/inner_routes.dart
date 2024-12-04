import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/widgets/doc_viewer_page.dart';
import 'package:school_of_future/core/widgets/image_view_page.dart';
import 'package:school_of_future/features/data/data_sources/local_db_keys.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/bloc/student_assignment_list_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/view/student_assinment_list_screen.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/bloc/teacher_assignment_list_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/view/teacher_assinment_list_screen.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/bloc/student_attendance_bloc.dart';
import 'package:school_of_future/features/presentation/attendance/student_attendance/view/student_attendance_screen.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/bloc/teacher_attendance_bloc.dart';
import 'package:school_of_future/features/presentation/attendance/teacher_attendance/view/teacher_attendance_screen.dart';
import 'package:school_of_future/features/presentation/class_work/student_classwork_list/bloc/student_classwork_list_bloc.dart';
import 'package:school_of_future/features/presentation/class_work/student_classwork_list/view/student_classwork_list_screen.dart';
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_list/bloc/classwork_list_bloc.dart';
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_list/view/teacher_classwork_list_screen.dart';
import 'package:school_of_future/features/presentation/event/event_list/bloc/event_bloc.dart';
import 'package:school_of_future/features/presentation/event/event_list/view/event_screen.dart';
import 'package:school_of_future/features/presentation/exam/teacher_exam_list/bloc/teacher_exam_list_bloc.dart';
import 'package:school_of_future/features/presentation/exam/teacher_exam_list/view/teacher_exam_list_screen.dart';
import 'package:school_of_future/features/presentation/leave/student_leave_list/bloc/student_leave_list_bloc.dart';
import 'package:school_of_future/features/presentation/leave/student_leave_list/view/student_leave_list_screen.dart';
import 'package:school_of_future/features/presentation/leave/teacher_own_leave_list/bloc/teacher_own_leave_bloc.dart';
import 'package:school_of_future/features/presentation/leave/teacher_own_leave_list/view/teacher_own_leave_list_screen.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_list/bloc/lesson_plan_list_bloc.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_list/view/lesson_plan_list_screen.dart';
import 'package:school_of_future/features/presentation/meeting/teacher_meeting_list/bloc/theacher_meeting_list_bloc.dart';
import 'package:school_of_future/features/presentation/meeting/teacher_meeting_list/view/teacher_meetign_list_screen.dart';
import 'package:school_of_future/features/presentation/notice/notice_details/bloc/notice_details_bloc.dart';
import 'package:school_of_future/features/presentation/notice/notice_details/view/notice_details_screen.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/bloc/notice_list_bloc.dart';
import 'package:school_of_future/features/presentation/notice/notice_list/view/notice_list_scree.dart';
import 'package:school_of_future/features/presentation/profile/student/bloc/student_profile_bloc.dart';
import 'package:school_of_future/features/presentation/profile/student/view/student_profile_screen.dart';
import 'package:school_of_future/features/presentation/profile/teacher/bloc/teacher_profile_bloc.dart';
import 'package:school_of_future/features/presentation/profile/teacher/view/teacher_profile_screen.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/bloc/student_home_bloc.dart';
import 'package:school_of_future/features/presentation/app_dashboard/Student_home/view/student_home_screen.dart';
import 'package:school_of_future/features/presentation/question_bank/question_list/bloc/question_bank_bloc.dart';
import 'package:school_of_future/features/presentation/question_bank/question_list/view/question_bank_screen.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_list/bloc/question_paper_list_bloc.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_list/view/question_paper_list_screen.dart';
import 'package:school_of_future/features/presentation/quiz/student_quiz_list/bloc/student_quiz_list_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/student_quiz_list/view/student_quiz_list_screen.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_list/bloc/quiz_list_screen_bloc.dart';
import 'package:school_of_future/features/presentation/quiz/teacher_quiz_list/view/quiz_list_screen.dart';
import 'package:school_of_future/features/presentation/repository/repository_list/bloc/repository_list_bloc.dart';
import 'package:school_of_future/features/presentation/repository/repository_list/view/repository_list_screen.dart';
import 'package:school_of_future/features/presentation/resources/resources_list/bloc/teacher_resource_list_bloc.dart';
import 'package:school_of_future/features/presentation/resources/resources_list/view/teacher_resources_list_screen.dart';
import 'package:school_of_future/features/presentation/routine/teacher_routine/bloc/teacher_routine_bloc.dart';
import 'package:school_of_future/features/presentation/routine/teacher_routine/view/teacher_routine_screen.dart';
import 'package:school_of_future/features/presentation/syllabus/student_syllabus/bloc/student_syllabus_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/student_syllabus/view/student_syllabus_screen.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_list/bloc/teacher_syllabus_list_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_list/view/teacher_syllabus_list_screen.dart';
import 'package:school_of_future/features/presentation/transport/transport/bloc/transport_bloc.dart';
import 'package:school_of_future/features/presentation/transport/transport/view/transport_screen.dart';

Route<dynamic>? studentsRoutes(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case studentProfile:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) =>
              StudentProfileBloc(getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
          child: const StudentProfileScreen(),
        ),
      );
    case teacherProfile:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) =>
              TeacherProfileBloc(getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
          child: const TeacherProfileScreen(),
        ),
      );
    case noticeList:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => NoticeListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const NoticeList(),
        ),
      );
    case noticeDetailsScreen:
      final id = settings.arguments as int;
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) =>
              NoticeDetailsBloc(getIt<ApiRepo>(), getIt<IFlutterNavigator>())
                ..add(GetNoticeDetails(noticeId: id)),
          child: const NoticeDetailsScreen(),
        ),
      );

    case docViewScreen:
      final url = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => DocViewerScreen(
          url: url,
        ),
      );
    case imageViewScreen:
      final url = settings.arguments as String;
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => ImageViewerScreen(
          imageUrl: url,
        ),
      );
    case leaveListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => StudentLeaveListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const StudentLeaveListScreen(),
        ),
      );
    case teacherOwnleaveListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => TeacherOwnLeaveBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const TeacherOwnLeaveListScreen(),
        ),
      );
    case studentAssignmentListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => StudentAssignmentListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const StudentAssinmentListScreen(),
        ),
      );

    case teacherAssignmentListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => TeacherAssignmentListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const TeacherAssinmentListScreen(),
        ),
      );
    case classworkListScreen:
      // final students = settings.arguments as List<CheckUncheckStudents>;
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<ClassworkListBloc>(
              create: (context) => ClassworkListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const TeacherClassworkListScreen(),
        ),
      );

    case studentClassworkListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => StudentClassworkListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const StudentClassworkListScreen(),
        ),
      );
    case routineScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => TeacherRoutineBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const RoutineScreen(),
        ),
      );

    case teacherResourcesListScreen:
      // final students = settings.arguments as List<CheckUncheckStudents>;
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<TeacherResourceListBloc>(
              create: (context) => TeacherResourceListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const TeacherResourcesListScreen(),
        ),
      );
    case lessonPlanListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<LessonPlanListBloc>(
              create: (context) => LessonPlanListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const LessonPlanListScreen(),
        ),
      );

    case teacherMeetingListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<TheacherMeetingListBloc>(
              create: (context) => TheacherMeetingListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const TeacherMeetingListScreen(),
        ),
      );

    case teacherSyllabusListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<TeacherSyllabusListBloc>(
              create: (context) => TeacherSyllabusListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const TeacherSyllabusListScreen(),
        ),
      );

    case studentSyllabusListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => StudentSyllabusBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const StudentSyllabusScreen(),
        ),
      );

    case transportScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => TransportBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const TransportScreen(),
        ),
      );
    case teacherAttendanceScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => TeacherAttendanceBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const TeacherAttendanceScreen(),
        ),
      );

    case studentAttendanceScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<StudentAttendanceBloc>(
              create: (context) => StudentAttendanceBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const StudentAttendanceScreen(),
        ),
      );

    case questionBankScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<QuestionBankBloc>(
              create: (context) => QuestionBankBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const QuestionBankScreen(),
        ),
      );

    case questionPaperListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<QuestionPaperListBloc>(
              create: (context) => QuestionPaperListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const QuestionPaperListScreen(),
        ),
      );

    case repositoryListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => RepositoryListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const RepositoryListScreen(),
        ),
      );
    case eventScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => EventBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const EventScreen(),
        ),
      );

    case quizListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<QuizListScreenBloc>(
              create: (context) => QuizListScreenBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const QuizListScreen(),
        ),
      );
    case studentQuizListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<StudentQuizListBloc>(
              create: (context) => StudentQuizListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const StudentQuizListScreen(),
        ),
      );

    case teacherExamListScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<TeacherExamListBloc>(
              create: (context) => TeacherExamListBloc(getIt<ApiRepo>(),
                  getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            ),
            BlocProvider<FilterSidebarBloc>(
              create: (context) => FilterSidebarBloc(
                  getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            ),
          ],
          child: const TeacherExamListScreen(),
        ),
      );

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => StudentHomeBloc(getIt<IFlutterNavigator>(),
              getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
          child: const StudentHomeScreen(),
        ),
      );
  }
}
