// routes.dart — All named routes for CMS app

class AppRoutes {
  // Auth
  static const String studentLogin = '/student-login';
  static const String adminLogin = '/admin-login';
  static const String operatorLogin = '/operator-login';

  // Registration
  static const String operatorRegistration = '/operator-registration';
  static const String accountSuccess = '/account-success';
  static const String studentRegistration = '/student/registration';
  // Dashboards
  static const String studentDashboard = '/student/dashboard';
  static const String operatorDashboard = '/operator/dashboard';
  static const String canteenGo = '/operator/canteengo';
  static const String canteenGoAnalytics = '/operator/canteengo/analytics';
  static const String canteenGoLiveStatus = '/operator/canteengo/live-status';
  static const String canteenGoMealTimings = '/operator/canteengo/meal-timings';
  static const String canteenGoNotifications = '/operator/canteengo/notifications';
  static const String canteenGoStaff = '/operator/canteengo/staff';
  static const String canteenGoScan = '/operator/canteengo/scan';
// admin
  static const String adminDashboard = '/admin/dashboard';
  static const String adminManageUsers = '/admin/manage-users';
  static const String adminReports = '/admin/reports';
  static const String adminUserDetail = '/admin/user-details';
  static const String adminSettings = '/admin/settings';
  static const String adminNotifications = '/admin/notifications';
  static const String adminMealSchedule = '/admin/meal-schedule';
  static const String adminSystemNotices = '/admin/system-notices';
  static const String adminOperatingHours = '/admin/operating-hours';
  static const String adminBookingWindow = '/admin/booking-window';
  static const String adminCollectionDeadline = '/admin/collection-deadline';
  static const String adminMaxCapacity = '/admin/max-capacity';
  // student
  static const String studentShell = '/student/shell';
  static const String studentMenu = '/student/menu';
  static const String studentBookings = '/student/bookings';
  static const String studentQR = '/student/qr';
  static const String studentFeedback = '/student/feedback';
  static const String studentProfile = '/student/profile';
  static const String studentNotifications = '/student/notifications';
  static const String mealFeedback = '/student/meal-feedback';
}
