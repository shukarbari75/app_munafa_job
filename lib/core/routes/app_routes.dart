import 'package:app_munafa_job/ui/startUp/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/home/home_screen.dart';
import '../../ui/job/add_job_screen.dart';
import '../../ui/job/jobs_screen.dart';
import '../../ui/reports/reports_screen.dart';
import '../../ui/setting/backup_screen.dart';
import '../../ui/startUp/onboarding_screen.dart';
import '../widgets/custom_navbar.dart';

class AppRoutes {
  AppRoutes._();

  // ROUTE CONSTANTS
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String backupSetup = '/backupSetup';
  static const String bottomNav = '/bottomNav';
  static const String home = '/home';
  static const String job = '/job';
  static const String reports = '/reports';
  static const String addJob = '/addJob';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String forgetPasswordScreen = '/forgetPasswordScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String myLots = '/myLots';
  static const String profile = '/profile';
  static const String notificationScreen = '/notificationScreen';

//  GEtX PAGES
  static final List<GetPage> getPages = [
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name:onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),

    GetPage(
      name: backupSetup,
      page: () => const BackupScreen(firstRun: true),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),

    GetPage(
      name: bottomNav,
      page: () => CustomBottomNavbar(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 350),
    ),

    GetPage(
        name: home,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn,
    ),

    GetPage(
      name: job,
      page: () => const JobsScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: reports,
      page: () => const ReportsScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
        name: addJob ,
        page: () => const AddJobScreen(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 280),
    ),
  ];

  // ROUTER
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ───── Splash ─────
      case splash:
        return _fadeRoutes(const SplashScreen(), settings);

      // ───── Onboarding ─────
      case onboarding:
        return _fadeRoutes(const OnboardingScreen(), settings);

      case backupSetup:
        return _fadeRoutes(const BackupScreen(firstRun: true), settings);

      // ───── Bottom Navigation ─────
      case bottomNav:
        return _fadeRoutes(CustomBottomNavbar() , settings);

      // ───── Home ─────
      case home:
        return _fadeRoutes(const HomeScreen(), settings);

      // ───── Jobs ─────
      case job:
       case myLots:
        return _fadeRoutes(const JobsScreen(), settings);

      // ───── Add Job ─────
       case addJob:
        return MaterialPageRoute(builder: (_) => const AddJobScreen());

      // ───── Reports ─────
       case reports:
        return _fadeRoutes(const ReportsScreen(), settings);

    // ───── Default ─────
    default:
      return MaterialPageRoute(builder: (_) => Scaffold(body:  Text('No route defined for ${settings.name}'),
      ),
      );
    }
  }

  static PageRouteBuilder<dynamic> _fadeRoutes(
      Widget page,
      RouteSettings  settings,
      ) {
     return PageRouteBuilder(
       settings: settings,
       pageBuilder: (_, animation, secondaryAnimation) => page,
       transitionsBuilder: (context, animation, secondaryAnimation, child) {
         const begin = Offset(0.0, 0.4);
         const end = Offset.zero;

        final slideAnimation = Tween<Offset>(begin: begin, end: end).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        final fadeAnimation = Tween<double>(
          begin:  0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(position: slideAnimation, child: child),
        );
        },
       transitionDuration: const Duration(milliseconds: 400),
       );
  }
}
