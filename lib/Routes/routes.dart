// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:PLUS/views/SurveyForm/survey_form_screen.dart';
import 'package:PLUS/views/SurveyForm/submit_survey.dart';
import 'package:PLUS/views/SurveyForm/revamp_info.dart';

abstract class Routes {
  static const SURVEY_FORM = '/survey_form';
}

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.SURVEY_FORM, page: () => const Revamp_Info()),
  ];
}
