import 'package:school_of_future/features/data/data_sources/config.dart';

String version1 = "${baseUrl}main-fsms-v2/public/api/v1/";
String loginEndPoint = "${version1}login";
String meEndPoint = "${version1}me";
String forgetPasswordStep1EndPoint = "${version1}forget-password-step1";
String forgetPasswordStep2EndPoint = "${version1}forget-password-step2";
String resetPasswordEndPoint = "${version1}reset-password";
String studentProfileEndPoint({required String sId}) =>
    "${version1}profile/student-profile/$sId";
String profileAttendanceEndPoint({required String sId}) =>
    "${version1}profile/student-attendance/$sId";

String childListEndPoint = "${version1}common/get-students-for-guardian";
String teacherProfileEndPoint = "${version1}profile/teacher-profile";
String getAllSubjectEndPoint({required String sId}) =>
    "${version1}common/get-all-subject-for-student/$sId";
String noticeEndPoint = "${version1}notice";
String noticeDetailsEndPoint({required int id}) => "${version1}notice/$id";
String dueTaskEndPoint({required String sId}) =>
    "${version1}dashboard/student/due-task/$sId";
String studentAssignmentEndPoint({required String sId}) =>
    "${version1}assignment/student-assignment-list/$sId";
String assignmentDetailsEndPoint({required int dId, String? sId}) =>
    "${version1}assignment/$dId/$sId";
String assignmentSubmitEndPoint = "${version1}assignment/submit-assignment";
String submitAssignmentDtlsEndPoint({required int submitId}) =>
    "${version1}assignment/submit-assignment/$submitId";
String assignmentFeedbackEndPoint({required int submitId}) =>
    "${version1}assignment/feedback/$submitId";
String teacherAssignmentEndPoint = "${version1}assignment";
String assignmentMarkEntryEndPoint({required int id}) =>
    "${version1}assignment/mark-entry/$id";

String getBatchAsSectionsEndPoint = "${version1}common/get-batch-as-sections";
String deleteAssignmentEndPoint({required int id}) =>
    "${version1}assignment/$id";

String getBatchWiseStudentsEndpoint(
        {required int subjectId, required int batchId}) =>
    "${version1}common/get-batch-wise-students?subject_id=$subjectId&batch_id=$batchId";
