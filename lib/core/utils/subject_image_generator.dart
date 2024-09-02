import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const commonSvgPath = 'assets/images/subject_images_svgs';

const english = '$commonSvgPath/english.svg';
const bangla = '$commonSvgPath/bangla.svg';
const math = '$commonSvgPath/math.svg';
const physics = '$commonSvgPath/physics.svg';
const science = '$commonSvgPath/science.svg';
const bangladeshStudies = '$commonSvgPath/bangladesh_studies.svg';
const agriculture = '$commonSvgPath/agriculture.svg';
const ict = '$commonSvgPath/ict.svg';
const physical = '$commonSvgPath/physical.svg';
const art = '$commonSvgPath/art.svg';
const homeScience = '$commonSvgPath/home_science.svg';
const workAndLifeStudy = '$commonSvgPath/work_and_life_study.svg';
const religiousStudy = '$commonSvgPath/religious_study.svg';
const higherMath = '$commonSvgPath/higher_math.svg';
const biology = '$commonSvgPath/biology.svg';
const chemistry = '$commonSvgPath/chemistry.svg';
const accounting = '$commonSvgPath/accounting.svg';
const additionalMath = '$commonSvgPath/additional_math.svg';
const economics = '$commonSvgPath/economics.svg';
const businessStudies = '$commonSvgPath/business_studies.svg';
const socialScience = '$commonSvgPath/social_science.svg';
const digitalRepInner = '$commonSvgPath/icon_digital_rep_inner.svg';

const careerEducation = '$commonSvgPath/career_education.svg';
const businessEntrepreneurship = '$commonSvgPath/business_entrepreneurship.svg';
const civics = '$commonSvgPath/civics.svg';
const financeBanking = '$commonSvgPath/finance_banking.svg';
const geographyAndEnvironment = '$commonSvgPath/geography.svg';
const history = '$commonSvgPath/history.svg';

const notFound = '$commonSvgPath/default_subject.svg';

const commonPathFeatures = 'assets/images/feature_icons_svg';

const calendar = '$commonPathFeatures/ic_academic_calendar.svg';
const attendance = '$commonPathFeatures/ic_attendance.svg';
const classWork = '$commonPathFeatures/ic_classwork.svg';
const digitalRep = '$commonPathFeatures/ic_digital_repository.svg';
const exams = '$commonPathFeatures/ic_exams.svg';
const homeWork = '$commonPathFeatures/ic_homework.svg';
const leave = '$commonPathFeatures/ic_leave.svg';
const lessonPlan = '$commonPathFeatures/ic_lesson_plan.svg';
const meeting = '$commonPathFeatures/ic_meeting.svg';
const notice = '$commonPathFeatures/ic_notice.svg';
const profile = '$commonPathFeatures/ic_profile.svg';
const quesPaper = '$commonPathFeatures/ic_question_paper.svg';
const quiz = '$commonPathFeatures/ic_quiz.svg';
const resource = '$commonPathFeatures/ic_resource.svg';
const result = '$commonPathFeatures/ic_result.svg';
const routine = '$commonPathFeatures/ic_routine';
const syllabus = '$commonPathFeatures/ic_syllabus';
const transport = '$commonPathFeatures/ic_transport';

Widget appGenerateImageWidgetFromId({required int id}) {
  return Image.asset(_generateImageLocationFromId(id: id));
}

ImageProvider appGenerateImageProviderFromId({required int id}) {
  return AssetImage(_generateImageLocationFromId(id: id));
}

Widget appGenerateSvgWidgetFromId({required int id}) {
  return SvgPicture.asset(_generateSvgImageLocationFromId(id: id));
}

String _generateImageLocationFromId({required int id}) {
  switch (id) {
    case 1:
      return 'assets/images/subject_images/english.png';
    case 2:
      return 'assets/images/subject_images/bangla.png';
    case 3:
      return 'assets/images/subject_images/math.png';
    case 4:
      return 'assets/images/subject_images/physics.png';
    case 5:
      return 'assets/images/subject_images/science.png';
    case 6:
      return 'assets/images/subject_images/bangladesh_studies.png';
    case 7:
      return 'assets/images/subject_images/agri.png';
    case 8:
      return 'assets/images/subject_images/ict.png';
    case 9:
      return 'assets/images/subject_images/physical.png';
    case 10:
      return 'assets/images/subject_images/art.png';
    case 11:
      return 'assets/images/subject_images/home_science';
    case 12:
      return 'assets/images/subject_images/work_and_life_study.png';
    case 13:
      return 'assets/images/subject_images/religious study.png';
    case 14:
      return 'assets/images/subject_images/higher_math.png';
    case 15:
      return 'assets/images/subject_images/biology.png';
    case 16:
      return 'assets/images/subject_images/chemistry.png';
    case 17:
      return 'assets/images/subject_images/accounting.png';
    case 18:
      return 'assets/images/subject_images/additional_math.png';
    case 19:
      return 'assets/images/subject_images/economics.png';
    case 20:
      return 'assets/images/subject_images/business_studies.png';
    default:
      return 'assets/images/subject_images/red_cross.png';
  }
}

String _generateSvgImageLocationFromId({required int id}) {
  switch (id) {
    case 1:
      return english;
    case 2:
      return bangla;
    case 3:
      return math;
    case 4:
      return physics;
    case 5:
      return science;
    case 6:
      return bangladeshStudies;
    case 7:
      return agriculture;
    case 8:
      return ict;
    case 9:
      return physical;
    case 10:
      return art;
    case 11:
      return homeScience;
    case 12:
      return workAndLifeStudy;
    case 13:
      return religiousStudy;
    case 14:
      return higherMath;
    case 15:
      return biology;
    case 16:
      return chemistry;
    case 17:
      return accounting;
    case 18:
      return additionalMath;
    case 19:
      return economics;
    case 20:
      return businessStudies;
    case 21:
      return socialScience;
    case 22:
      return careerEducation;
    case 23:
      return geographyAndEnvironment;
    case 24:
      return history;
    case 25:
      return civics;
    case 26:
      return financeBanking;
    case 27:
      return businessEntrepreneurship;
    default:
      return notFound;
  }
}
