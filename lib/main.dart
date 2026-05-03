import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/admin/admin_manage_users_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_reports_screen.dart';
import 'package:flutter_application_1/screens/operator/operator_dashboard_screen.dart';
import 'package:flutter_application_1/screens/operator/canteengo_shell.dart';
import 'package:flutter_application_1/screens/operator/canteengo_analytics.dart';
import 'package:flutter_application_1/screens/operator/canteengo_live_status.dart';
import 'package:flutter_application_1/screens/operator/canteengo_meal_timings.dart';
import 'package:flutter_application_1/screens/operator/canteengo_notifications.dart';
import 'package:flutter_application_1/screens/operator/canteengo_staff.dart';
import 'package:flutter_application_1/screens/student/student_dashboard_screen.dart';
import 'package:flutter_application_1/screens/student/student_notifications_screen.dart';
import 'theme/app_theme.dart';
import 'routes.dart';
// admin screen
import 'package:flutter_application_1/screens/admin/admin_shell_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_user_detail_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_settings_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_notifications_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_meal_schedule_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_system_notices_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_operating_hours_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_booking_window_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_collection_deadline_screen.dart';
import 'package:flutter_application_1/screens/admin/admin_max_capacity_screen.dart';

import 'package:provider/provider.dart';
import 'screens/student/student_login_screen.dart';
import 'screens/admin/admin_login_screen.dart';
import 'screens/operator/operator_login_screen.dart';
import 'screens/operator/operator_registration_screen.dart';
import 'screens/student/Student_SignUpScreen.dart';
import 'screens/account_success_screen.dart';
import 'providers/canteen_provider.dart';
// import 'screens/student/meal_token_screen.dart';
import 'screens/student/student_profile_screen.dart';
import 'screens/student/student_menu_screen.dart';
import 'screens/student/student_shell_screen.dart';
import 'screens/student/student_bookings_screen.dart';
import 'screens/student/student_qr_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CanteenProvider())],
      child: const CMSApp(),
    ),
  );
}

class CMSApp extends StatelessWidget {
  const CMSApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TNU CMS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // Initial route
      initialRoute: AppRoutes.studentLogin,

      // Named routes with page transitions
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          // ── Auth ────────────────────────────────────────────
          case AppRoutes.studentLogin:
            page = const StudentLoginScreen();
            break;

          case AppRoutes.adminLogin:
            page = const AdminLoginScreen();
            break;

          case AppRoutes.operatorLogin:
            page = const OperatorLoginScreen();
            break;

          // ── Registration ────────────────────────────────────
          case AppRoutes.studentRegistration:
            page = const StudentSignUpScreen();
            break;

          case AppRoutes.operatorRegistration:
            page = const OperatorRegistrationScreen();
            break;

          case AppRoutes.accountSuccess:
            page = const AccountSuccessScreen();
            break;

          // ── Dashboards ──────────────────────────────────────
          case AppRoutes.studentDashboard:
            page = const StudentDashboardScreen();
            break;

          case AppRoutes.operatorDashboard:
            page = const OperatorDashboardScreen();
            break;

          case AppRoutes.canteenGo:
            page = const CanteenGoShell();
            break;

          case AppRoutes.canteenGoAnalytics:
            page = const CanteenGoAnalytics();
            break;

          case AppRoutes.canteenGoLiveStatus:
            page = const CanteenGoLiveStatus();
            break;

          case AppRoutes.canteenGoMealTimings:
            page = const CanteenGoMealTimings();
            break;

          case AppRoutes.canteenGoNotifications:
            page = const CanteenGoNotifications();
            break;

          case AppRoutes.canteenGoStaff:
            page = const CanteenGoStaff();
            break;

          // ----------Menu------------
          case AppRoutes.studentMenu:
            page = const StudentMenuScreen();
            break;

          // ── QR Token ────────────────────────────────
          // case AppRoutes.studentQR:
          //   page = const MealTokenScreen();
          //   break;

          // ── Profile ─────────────────────────────────
          case AppRoutes.studentProfile:
            page = const StudentProfileScreen();
            break;

          // admin
          case AppRoutes.adminDashboard:
            page = const AdminShellScreen();
            break;

          case AppRoutes.adminUserDetail:
            page = const AdminUserDetailScreen();
            break;

          case AppRoutes.adminSettings:
            page = const AdminSettingsScreen();
            break;

          case AppRoutes.adminNotifications:
            page = const AdminNotificationsScreen();
            break;

          case AppRoutes.adminMealSchedule:
            page = const AdminMealScheduleScreen();
            break;

          case AppRoutes.adminManageUsers:
            page = const AdminManageUsersScreen();
            break;

          case AppRoutes.adminReports:
            page = const AdminReportsScreen();
            break;

          case AppRoutes.adminSystemNotices:
            page = const AdminSystemNoticesScreen();
            break;

          case AppRoutes.adminOperatingHours:
            page = const AdminOperatingHoursScreen();
            break;

          case AppRoutes.adminBookingWindow:
            page = const AdminBookingWindowScreen();
            break;

          case AppRoutes.adminCollectionDeadline:
            page = const AdminCollectionDeadlineScreen();
            break;

          case AppRoutes.adminMaxCapacity:
            page = const AdminMaxCapacityScreen();
            break;

          // student routes
          case AppRoutes.studentShell:
            page = const StudentShellScreen();
            break;
          case AppRoutes.studentBookings:
            page = const StudentBookingsScreen();
            break;
          case AppRoutes.studentQR:
            page = const StudentQRScreen();
            break;
          case AppRoutes.studentNotifications:
            page = const StudentNotificationsScreen();
            break;

          default:
            page = const StudentLoginScreen();
        }

        // Slide + fade transition for all routes
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (ctx, animation, secondaryAnimation) => page,
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            // Slide from right for push, slide from left for pop
            final isPopping =
                secondaryAnimation.status == AnimationStatus.forward;
            final begin = isPopping ? Offset.zero : const Offset(0.08, 0);
            const end = Offset.zero;
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeOutCubic));
            final fade = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).chain(CurveTween(curve: Curves.easeIn));

            return FadeTransition(
              opacity: animation.drive(fade),
              child: SlideTransition(
                position: animation.drive(tween),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
