import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/doc_viewer_page.dart';
import 'package:school_of_future/core/widgets/image_view_page.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/features/presentation/app_common/filter_sidebar/bloc/filter_sidebar_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/selected_students/bloc/select_students_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/selected_students/view/selected_students_screen.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/bloc/student_assignment_details_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_details/view/student_assignment_details_screen.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_submit/bloc/student_assignment_submit_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_submit/view/student_assignment_submit_screen.dart';
import 'package:school_of_future/features/presentation/assignment/student_feedback/bloc/student_feedback_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_feedback/view/student_feedback_screen.dart';
import 'package:school_of_future/features/presentation/assignment/student_submission_details/bloc/student_submission_details_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_submission_details/view/student_assignment_submission_details.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/bloc/assignment_create_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_create/view/assignment_create_screen.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_view_submission/bloc/teacher_view_submission_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_view_submission/view/teacher_view_submission_screen.dart';
import 'package:school_of_future/features/presentation/attendance/absent_student/bloc/absent_student_bloc.dart';
import 'package:school_of_future/features/presentation/attendance/absent_student/view/absent_student_screen.dart';
import 'package:school_of_future/features/presentation/attendance/take_attendance/bloc/take_attendance_bloc.dart';
import 'package:school_of_future/features/presentation/attendance/take_attendance/view/take_attendance_screen.dart';
import 'package:school_of_future/features/presentation/change_password/bloc/change_password_bloc.dart';
import 'package:school_of_future/features/presentation/change_password/view/change_password_screen.dart';
import 'package:school_of_future/features/presentation/class_work/classwork_details/bloc/classwork_details_bloc.dart';
import 'package:school_of_future/features/presentation/class_work/classwork_details/view/classwork_details_screen.dart';
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_create/bloc/class_work_create_bloc.dart';
import 'package:school_of_future/features/presentation/class_work/teacher_classwork_create/view/teacher_classwork_create_screen.dart';
import 'package:school_of_future/features/presentation/forgot_password_1/bloc/forgot_password_bloc.dart';
import 'package:school_of_future/features/presentation/forgot_password_2/bloc/forgot_password2_bloc.dart';
import 'package:school_of_future/features/presentation/forgot_password_2/view/step-2.dart';
import 'package:school_of_future/features/presentation/forgot_password_1/view/step_1.dart';
import 'package:school_of_future/features/presentation/leave/leave_details/bloc/leave_details_bloc.dart';
import 'package:school_of_future/features/presentation/leave/leave_details/view/leave_details_screen.dart';
import 'package:school_of_future/features/presentation/leave/parent_apply_leave/bloc/apply_leave_bloc.dart';
import 'package:school_of_future/features/presentation/leave/parent_apply_leave/view/parent_apply_leave_screen.dart';
import 'package:school_of_future/features/presentation/leave/teacher_apply_leave/bloc/teacher_apply_leave_bloc.dart';
import 'package:school_of_future/features/presentation/leave/teacher_apply_leave/view/teacher_apply_leave.screen.dart';
import 'package:school_of_future/features/presentation/leave/teacher_leave_details/bloc/teacher_leave_details_bloc.dart';
import 'package:school_of_future/features/presentation/leave/teacher_leave_details/view/teacher_leave_details_screen.dart';
import 'package:school_of_future/features/presentation/lesson_plan/attach_resource/bloc/attach_resource_bloc.dart';
import 'package:school_of_future/features/presentation/lesson_plan/attach_resource/view/attach_resource_screen.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_create/bloc/lesson_plan_create_bloc.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_create/view/lesson_plan_create_screen.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_details/bloc/lesson_plan_details_bloc.dart';
import 'package:school_of_future/features/presentation/lesson_plan/lesson_plan_details/view/lesson_plan_details_screen.dart';
import 'package:school_of_future/features/presentation/login/bloc/login_bloc.dart';
import 'package:school_of_future/features/presentation/login/view/login_screen.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_create/bloc/meeting_create_bloc.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_create/view/meeting_create_screen.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_details/bloc/meeting_details_bloc.dart';
import 'package:school_of_future/features/presentation/meeting/meeting_details/view/meeting_details_screen.dart';
import 'package:school_of_future/features/presentation/menu/bloc/menu_bloc.dart';
import 'package:school_of_future/features/presentation/menu/view/menu_screen.dart';
import 'package:school_of_future/features/presentation/question_bank/question_create/bloc/question_create_bloc.dart';
import 'package:school_of_future/features/presentation/question_bank/question_create/view/question_create_screen.dart';
import 'package:school_of_future/features/presentation/question_paper/add_question/bloc/add_question_bloc.dart';
import 'package:school_of_future/features/presentation/question_paper/add_question/view/add_question_screen.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_create/bloc/question_paper_create_bloc.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_create/view/question_paper_create_screen.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_details/bloc/question_paper_details_bloc.dart';
import 'package:school_of_future/features/presentation/question_paper/question_paper_details/view/question_paper_details_screen.dart';
import 'package:school_of_future/features/presentation/resources/resources_details/bloc/resources_details_bloc.dart';
import 'package:school_of_future/features/presentation/resources/resources_details/view/resources_details_screen.dart';
import 'package:school_of_future/features/presentation/resources/teacher_resources_create/bloc/resources_create_bloc.dart';
import 'package:school_of_future/features/presentation/resources/teacher_resources_create/view/resources_create_screen.dart';
import 'package:school_of_future/features/presentation/select_child/bloc/select_child_bloc.dart';
import 'package:school_of_future/features/presentation/select_child/view/select_child_screen.dart';
import 'package:school_of_future/features/presentation/splash/bloc/splash_bloc.dart';
import 'package:school_of_future/features/presentation/splash/view/splash.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/bloc/student_dashboard_bloc.dart';
import 'package:school_of_future/features/presentation/app_dashboard/dashboard/view/student_dashboard_screen.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_class_quiz/bloc/syllabus_class_quiz_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_class_quiz/view/syllabus_class_quiz_screen.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_create/bloc/syllabus_create_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_create/view/syllabus_create_screen.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_details/bloc/syllabus_details_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/syllabus_details/view/syllabus_details_screen.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_details/bloc/teacher_full_syllabus_details_bloc.dart';
import 'package:school_of_future/features/presentation/syllabus/teacher_full_syllabus_details/view/teacher_full_syllabus_details_screen.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    print(settings.name.toString());
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SplashBloc(
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            child: const Splash(),
          ),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(getIt<IFlutterNavigator>(),
                getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
            child: LoginScreen(),
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
      case studentDashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentDashboardBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            ),
            child: const StudentDhasboard(),
          ),
        );
      case menuScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => MenuBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            ),
            child: const MenuScreen(),
          ),
        );
      case forgotPasswordStep1:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPasswordBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
            ),
            child: const ForgotPasswordStep1Screen(),
          ),
        );
      case forgotPasswordStep2:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ForgotPassword2Bloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
            ),
            child: const ForgotPasswordStep2Screen(),
          ),
        );
      case changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ChangePasswordBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
            ),
            child: ChangePasswordScreen(),
          ),
        );
      case selectChild:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SelectChildBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
            child: SelectChildScreen(),
          ),
        );
      case studentAssignmentDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentAssignmentDetailsBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(GetDetails(assingmentId: id)),
            child: const StudentAssignmentDetailsScreen(),
          ),
        );
      case studentAssignmentSubmitScreen:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentAssignmentSubmitBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(SubmitAssignment(id: data['id'])),
            child: StudentAssignmentSubmitScreen(
              title: data['title'],
              subject: data['subject'],
            ),
          ),
        );
      case studentAssignmentSubmissionDetailsScreen:
        final assignmentSubmissionId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentSubmissionDetailsBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(GetSubmissionDetails(id: assignmentSubmissionId)),
            child: const StudentAssignmentSubmissionDetailsScreen(),
          ),
        );
      case studentAssignmentFeedbackScreen:
        final assignmentSubmissionId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => StudentFeedbackBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(GetFeedback(id: assignmentSubmissionId)),
            child: const StudentFeedbackScreen(),
          ),
        );

      case teacherAssignmentViewSubmissionScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TeacherViewSubmissionBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(GetAssignmentDtls(id: id)),
            child: const TeacherViewSubmissionScreen(),
          ),
        );

      case teacherAssignmentCreateScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => AssignmentCreateBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(AssignmentIdForEdit(assignmentId: id)),
            child: const AssignmentCreateScreen(),
          ),
        );

      case selectedStudentsScreen:
        final students = settings.arguments as List<CheckUncheckStudents>;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => SelectStudentsBloc()
              ..add(GetInitialStudents(students: students)),
            child: const SelectedStudentsScreen(),
          ),
        );

      case teacherClassworkCreateSreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ClassWorkCreateBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(ClassworkIdForEdit(classworkId: id)),
            child: const ClassWorkCreateScreen(),
          ),
        );
      case classworkDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ClassworkDetailsBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(GetClassworkDetails(classworkId: id)),
            child: const ClassworkDetailsScreen(),
          ),
        );
      case teacherResourcesCreateScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ResourcesCreateBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(ResourceIdForEdit(resourceId: id)),
            child: const ResourcesCreateScreen(),
          ),
        );
      case resourcesDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ResourcesDetailsBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(GetResourceDetails(resourcesId: id)),
            child: const ResourcesDetailsScreen(),
          ),
        );
      case teacherlessonPlanCreateScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => LessonPlanCreateBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(PlanIdForEdit(planId: id)),
            child: const LessonPlanCreateScreen(),
          ),
        );

      case teacherAttachResourceScreen:
        final resources = settings.arguments as List<int>;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => AttachResourceBloc(getIt<ApiRepo>())
              ..add(GetResourcesCheckedIds(idList: resources)),
            child: const AttecheResourceScreen(),
          ),
        );
      case lessonPlanDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => LessonPlanDetailsBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(GetLessonPlanDetails(planId: id)),
            child: const LessonPlanDetailsScreen(),
          ),
        );

      case teacherMeetingCreateScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => MeetingCreateBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(MeetingIdForEdit(meetingId: id)),
            child: const MeetingCreateScreen(),
          ),
        );

      case meetingDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => MeetingDetailsBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(GetMeetingDetails(meetingId: id)),
            child: const MeetingDetailsScreen(),
          ),
        );

      case syllabusClassQuizScreen:
        final params = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => SyllabusClassQuizBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(GetList(queryParams: params)),
            child: const SyllabusClassQuizScreen(),
          ),
        );

      case syllabusDetailsScreen:
        final syllabusId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => SyllabusDetailsBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(GetSyllabusDetails(id: syllabusId)),
            child: const SyllabusDetailsScreen(),
          ),
        );
      case teacherFullSyllabusDtlsScreen:
        final syllabusId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => TeacherFullSyllabusDetailsBloc(
              getIt<ApiRepo>(),
            )..add(GetTeacherSyllabusDetails(syllabusId: syllabusId)),
            child: const TeacherFullSyllabusDetailsScreen(),
          ),
        );

      case teacherSyllabusCreateScreen:
        final syllabusId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => MultiBlocProvider(
            providers: [
              BlocProvider<FilterSidebarBloc>(
                create: (context) => FilterSidebarBloc(
                    getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
              ),
              BlocProvider<SyllabusCreateBloc>(
                create: (context) => SyllabusCreateBloc(
                    getIt<ApiRepo>(),
                    getIt<IFlutterNavigator>(),
                    getIt<LocalStorageRepo>(),
                    getIt<FilePickerRepo>())
                  ..add(SyllabusIdForEdit(syllabusId: syllabusId)),
              ),
            ],
            child: const SyllabusCreateScreen(),
          ),
        );

      case leaveDetailsScreen:
        final leaveId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => LeaveDetailsBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(GetLeaveDetails(leaveId: leaveId)),
            child: const LeaveDetailsScreen(),
          ),
        );
      case teacherLeaveDetailsScreen:
        final leaveId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => TeacherLeaveDetailsBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(GetTeacherLeaveDetails(leaveId: leaveId)),
            child: const TeacherLeaveDetailsScreen(),
          ),
        );

      case parentApplyLeaveScreen:
        final leaveId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => ApplyLeaveBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(LeaveIdForEdit(leaveId: leaveId)),
            child: const ParentApplyLeaveScreen(),
          ),
        );
      case teacherOwnApplyLeaveScreen:
        final leaveId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => TeacherApplyLeaveBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(OwnLeaveIdForEdit(leaveId: leaveId)),
            child: const TeacherApplyLeaveScreen(),
          ),
        );
      case teacherTakeAttendanceScreen:
        final params = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => TakeAttendanceBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(
                GetParams(
                  subjectId: params["subject_id"],
                  batchId: params["batch_id"],
                  classInfo: params["class_name"],
                  isViewDetails: params["is_view_details"],
                ),
              ),
            child: const TakeAttendanceScreen(),
          ),
        );
      case absentStudentsScreen:
        final params = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => AbsentStudentBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(
                GetStudents(
                  subjectId: params["subject_id"],
                  batchId: params["batch_id"],
                  classInfo: params["class_name"],
                ),
              ),
            child: const AbsentStudentsScreen(),
          ),
        );

      case questionCreateScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => QuestionCreateBloc(
                getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(),
                getIt<LocalStorageRepo>(),
                getIt<FilePickerRepo>())
              ..add(QuestionIdForEdit(qId: id)),
            child: const QuestionCreateScreen(),
          ),
        );
      case questionPaperCreateScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => QuestionPaperCreateBloc(
              getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(),
              getIt<LocalStorageRepo>(),
            )..add(QuestionPaperIdForEdit(qPaperId: id)),
            child: const QuestionPaperCreateScreen(),
          ),
        );
      case addQuestionPScreen:
        final tempQst = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => MultiBlocProvider(
            providers: [
              BlocProvider<AddQuestionBloc>(
                create: (context) => AddQuestionBloc(getIt<ApiRepo>(),
                    getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
                  ..add(GetQuestion(
                      tempQst: tempQst["selectedQstns"],
                      subjectId: tempQst['subject_id'])),
              ),
              BlocProvider<FilterSidebarBloc>(
                create: (context) => FilterSidebarBloc(
                    getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
              ),
            ],
            child: const AddQuestionScreen(),
          ),
        );

      case questionPaperDtlsScreen:
        final qPaperId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => BlocProvider(
            create: (context) => QuestionPaperDetailsBloc(getIt<ApiRepo>(),
                getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>())
              ..add(QuestionPaperDetails(paperId: qPaperId)),
            child: const QuestionPaperDetailScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Text("Page Not Found"),
          ),
        );
    }
  }
}
