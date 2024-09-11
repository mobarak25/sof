import 'package:school_of_future/features/domain/entities/assignment_details_response.dart';
import 'package:school_of_future/features/domain/entities/assignment_feedback_response.dart';
import 'package:school_of_future/features/domain/entities/assignment_list_response.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/child_list_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/due_task_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/login_response.dart';
import 'package:school_of_future/features/domain/entities/me_response.dart';
import 'package:school_of_future/features/domain/entities/notice_details_response.dart';
import 'package:school_of_future/features/domain/entities/notice_response.dart';
import 'package:school_of_future/features/domain/entities/profile_attendance_response.dart';
import 'package:school_of_future/features/domain/entities/student_assignment_submissign_details_response.dart';
import 'package:school_of_future/features/domain/entities/student_profile_response.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_assignment_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_profile_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_summited_assinent_response.dart';

class EntityMap {
  static T? fromJson<T, K>(dynamic json) {
    switch (T) {
      case const (DefaultResponse):
        return DefaultResponse.fromJson(json) as T;
      case const (LoginResponse):
        return LoginResponse.fromJson(json) as T;
      case const (MeResponse):
        return MeResponse.fromJson(json) as T;
      case const (StudentProfileResponse):
        return StudentProfileResponse.fromJson(json) as T;
      case const (ProfileAttendanceResponse):
        return ProfileAttendanceResponse.fromJson(json) as T;
      case const (ChildListResponse):
        return ChildListResponse.fromJson(json) as T;
      case const (TeacherProfileResponse):
        return TeacherProfileResponse.fromJson(json) as T;
      case const (SubjectResponse):
        return SubjectResponse.fromJson(json) as T;
      case const (NoticeResponse):
        return NoticeResponse.fromJson(json) as T;
      case const (DueTaskResponse):
        return DueTaskResponse.fromJson(json) as T;
      case const (NoticeDetailsResponse):
        return NoticeDetailsResponse.fromJson(json) as T;
      case const (AssignmentResponse):
        return AssignmentResponse.fromJson(json) as T;
      case const (AssignmentDetails):
        return AssignmentDetails.fromJson(json) as T;
      case const (StudentAssignmentDetails):
        return StudentAssignmentDetails.fromJson(json) as T;
      case const (AssignmentFeedback):
        return AssignmentFeedback.fromJson(json) as T;
      case const (TeacherAssignment):
        return TeacherAssignment.fromJson(json) as T;
      case const (TeacherSummitedAssinentView):
        return TeacherSummitedAssinentView.fromJson(json) as T;
      case const (GetBacthAsSections):
        return GetBacthAsSections.fromJson(json) as T;
      case const (BatchWiseStudent):
        return BatchWiseStudent.fromJson(json) as T;
      default:
        throw Exception('Unknown class');
    }
  }
}
