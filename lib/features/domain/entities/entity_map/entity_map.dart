import 'package:school_of_future/features/domain/entities/assignment_assign_student_response.dart';
import 'package:school_of_future/features/domain/entities/assignment_details_response.dart';
import 'package:school_of_future/features/domain/entities/assignment_feedback_response.dart';
import 'package:school_of_future/features/domain/entities/assignment_list_response.dart';
import 'package:school_of_future/features/domain/entities/attendance_overvview_response.dart';
import 'package:school_of_future/features/domain/entities/batch_wise_student.dart';
import 'package:school_of_future/features/domain/entities/chapter_response.dart';
import 'package:school_of_future/features/domain/entities/child_list_response.dart';
import 'package:school_of_future/features/domain/entities/classwork_details_response.dart';
import 'package:school_of_future/features/domain/entities/classwork_list_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/due_task_response.dart';
import 'package:school_of_future/features/domain/entities/entity_map/student_full_syllabus_response.dart';
import 'package:school_of_future/features/domain/entities/entity_map/student_leave_details_response.dart';
import 'package:school_of_future/features/domain/entities/entity_map/syllabus_details_response.dart';
import 'package:school_of_future/features/domain/entities/full_syllabus_details_response.dart';
import 'package:school_of_future/features/domain/entities/full_syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/leave_types_response.dart';
import 'package:school_of_future/features/domain/entities/lesson_plan_details_response.dart';
import 'package:school_of_future/features/domain/entities/lesson_plan_list_response.dart';
import 'package:school_of_future/features/domain/entities/login_response.dart';
import 'package:school_of_future/features/domain/entities/me_response.dart';
import 'package:school_of_future/features/domain/entities/meeting_details_response.dart';
import 'package:school_of_future/features/domain/entities/meeting_list_response.dart';
import 'package:school_of_future/features/domain/entities/notice_details_response.dart';
import 'package:school_of_future/features/domain/entities/notice_response.dart';
import 'package:school_of_future/features/domain/entities/profile_attendance_response.dart';
import 'package:school_of_future/features/domain/entities/resource_details_response.dart';
import 'package:school_of_future/features/domain/entities/resources_response.dart';
import 'package:school_of_future/features/domain/entities/routine_response.dart';
import 'package:school_of_future/features/domain/entities/student_assignment_submissign_details_response.dart';
import 'package:school_of_future/features/domain/entities/student_for_attendance_response.dart';
import 'package:school_of_future/features/domain/entities/student_leave_list_response.dart';
import 'package:school_of_future/features/domain/entities/student_profile_response.dart';
import 'package:school_of_future/features/domain/entities/subject_item_response.dart';
import 'package:school_of_future/features/domain/entities/syllabus_teacher_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_assignment_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_leave_details_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_own_leave_list_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_profile_response.dart';
import 'package:school_of_future/features/domain/entities/teacher_summited_assinent_response.dart';
import 'package:school_of_future/features/domain/entities/transport_response.dart';

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
      case const (AssignmentAssignStudent):
        return AssignmentAssignStudent.fromJson(json) as T;
      case const (ClassworkList):
        return ClassworkList.fromJson(json) as T;
      case const (ClassworkDetails):
        return ClassworkDetails.fromJson(json) as T;
      case const (Chapter):
        return Chapter.fromJson(json) as T;
      case const (Resources):
        return Resources.fromJson(json) as T;
      case const (ResourceDetails):
        return ResourceDetails.fromJson(json) as T;
      case const (LessonPlan):
        return LessonPlan.fromJson(json) as T;
      case const (LessonPlanDetails):
        return LessonPlanDetails.fromJson(json) as T;
      case const (MeetingDetails):
        return MeetingDetails.fromJson(json) as T;
      case const (MeetingList):
        return MeetingList.fromJson(json) as T;
      case const (Routine):
        return Routine.fromJson(json) as T;
      case const (FullSyllabusTeacher):
        return FullSyllabusTeacher.fromJson(json) as T;
      case const (SyllabusTeacher):
        return SyllabusTeacher.fromJson(json) as T;
      case const (SyllabusDetails):
        return SyllabusDetails.fromJson(json) as T;
      case const (StudentFullSyllabus):
        return StudentFullSyllabus.fromJson(json) as T;
      case const (FullSyllabusDetails):
        return FullSyllabusDetails.fromJson(json) as T;
      case const (StudentLeaveList):
        return StudentLeaveList.fromJson(json) as T;
      case const (StudentLeaveLDetails):
        return StudentLeaveLDetails.fromJson(json) as T;
      case const (LeaveTypes):
        return LeaveTypes.fromJson(json) as T;
      case const (TeacherOwnLeaveList):
        return TeacherOwnLeaveList.fromJson(json) as T;
      case const (TeacherLeaveDetails):
        return TeacherLeaveDetails.fromJson(json) as T;
      case const (Transport):
        return Transport.fromJson(json) as T;
      case const (AttendanceOverview):
        return AttendanceOverview.fromJson(json) as T;
      case const (StudentsForAttendance):
        return StudentsForAttendance.fromJson(json) as T;

      default:
        throw Exception('Unknown class');
    }
  }
}
