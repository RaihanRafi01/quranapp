import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/hadith_lessons/bindings/hadith_lessons_binding.dart';
import '../modules/hadith_lessons/views/hadith_lessons_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/imported_lessons/bindings/imported_lessons_binding.dart';
import '../modules/imported_lessons/views/imported_lessons_view.dart';
import '../modules/leaderboards/bindings/leaderboards_binding.dart';
import '../modules/leaderboards/views/leaderboards_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quranic_lessons/bindings/quranic_lessons_binding.dart';
import '../modules/quranic_lessons/views/quranic_lessons_view.dart';
import '../modules/setup_profile/bindings/setup_profile_binding.dart';
import '../modules/setup_profile/views/setup_profile_view.dart';
import '../modules/video_lessons/bindings/video_lessons_binding.dart';
import '../modules/video_lessons/views/video_lessons_view.dart';
import '../modules/vocabulary/bindings/vocabulary_binding.dart';
import '../modules/vocabulary/views/vocabulary_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.SETUP_PROFILE,
      page: () => const SetupProfileView(),
      binding: SetupProfileBinding(),
    ),
    GetPage(
      name: _Paths.VOCABULARY,
      page: () => const VocabularyView(),
      binding: VocabularyBinding(),
    ),
    GetPage(
      name: _Paths.LEADERBOARDS,
      page: () => const LeaderboardsView(),
      binding: LeaderboardsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
  ];
}
