import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/ioc/global.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/widgets/doc_viewer_page.dart';
import 'package:school_of_future/core/widgets/image_view_page.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/bloc/student_assignment_list_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/student_assignment_list/view/student_assinment_list_screen.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/bloc/teacher_assignment_list_bloc.dart';
import 'package:school_of_future/features/presentation/assignment/teacher_assignment_list/view/teacher_assinment_list_screen.dart';
import 'package:school_of_future/features/presentation/leave/apply_leave/bloc/apply_leave_bloc.dart';
import 'package:school_of_future/features/presentation/leave/apply_leave/view/parent_apply_leave_screen.dart';
import 'package:school_of_future/features/presentation/leave/leave_details/view/leave_details_screen.dart';
import 'package:school_of_future/features/presentation/leave/leave_list/view/leave_list_screen.dart';
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
          create: (context) => NoticeListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const LeaveListScreen(),
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
    case leaveDetailsScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => NoticeListBloc(getIt<ApiRepo>(),
              getIt<IFlutterNavigator>(), getIt<LocalStorageRepo>()),
          child: const LeaveDetailsScreen(),
        ),
      );
    case parentApplyLeaveScreen:
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => BlocProvider(
          create: (context) => ApplyLeaveBloc(getIt<IFlutterNavigator>(),
              getIt<ImagePicker>(), getIt<FilePickerRepo>()),
          child: const ParentApplyLeave(),
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
