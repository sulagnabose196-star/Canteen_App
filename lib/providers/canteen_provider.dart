import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../models/booking_model.dart';
import '../models/notification_model.dart';

class CanteenProvider with ChangeNotifier {
  String userName = "Sohan";
  String rollNumber = "2024CSE0142";
  String hostel = "Hostel A - Room 214";
  String mealPlan = "Full Board (All Meals)";
  String email = "[EMAIL_ADDRESS]";

  // Current date/time
  DateTime now = DateTime.now();
  String nowTime = DateTime.now().toString().substring(11, 16);

  // Bottom navigation state — 0: Home, 1: Menu, 2: Bookings, 3: Profile
  int currentIndex = 0;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // ── Menu day selection ──────────────────────────────────────
  int selectedDayIndex = 2; // Default to tomorrow

  late List<DateTime> dateList;
  late List<String> dayLabels;
  late List<String> dayFullNames;

  CanteenProvider() {
    _initDates();
  }

// Initialize day list
  void _initDates() {
    final nowDateTime = DateTime.now();
    dateList = List.generate(7, (index) => nowDateTime.add(Duration(days: index - 1)));
    
    final shortDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final longDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    
    dayLabels = dateList.map((d) => shortDays[d.weekday - 1]).toList();
    dayFullNames = dateList.map((d) => longDays[d.weekday - 1]).toList();
  }

  void selectDay(int index) {
    selectedDayIndex = index;
    notifyListeners();
  }

  // ── Meals per day ───────────────────────────────────────────
  // Map<dayIndex, List<Meal>>
  Map<int, List<Meal>> weeklyMeals = {
    0: [
      // Monday
      Meal(
        id: 'm0b',
        title: 'Breakfast',
        time: '7:30 AM - 9:00 AM',
        calories: 320,
        items: ['Bread', 'Butter & Jam', 'Banana', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.morning,
      ),
      Meal(
        id: 'm0l',
        title: 'Lunch',
        time: '12:30 PM - 2:00 PM',
        calories: 780,
        isBooked: true,
        items: ['Rice', 'Egg Aloo Curry', 'Dal', 'Salad'],
        status: MealStatus.booked,
        category: MealCategory.essential,
      ),
      Meal(
        id: 'm0s',
        title: 'Snacks',
        time: '4:30 PM - 5:30 PM',
        calories: 250,
        items: ['Sausage', 'Makhana', 'Banana', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.light,
      ),
      Meal(
        id: 'm0d',
        title: 'Dinner',
        time: '7:30 PM - 9:00 PM',
        calories: 650,
        items: ['Egg Aloo Curry', 'Veg Masala', 'Dal', 'Salad'],
        status: MealStatus.closed,
        category: MealCategory.premium,
      ),
    ],
    1: [
      // Tuesday
      Meal(
        id: 'm1b',
        title: 'Breakfast',
        time: '7:30 AM - 9:00 AM',
        calories: 310,
        items: ['Pav', 'Bhaji', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.morning,
      ),
      Meal(
        id: 'm1l',
        title: 'Lunch',
        time: '12:30 PM - 2:00 PM',
        calories: 800,
        items: ['Fish Curry / Paneer Kofta', 'Rice', 'Dal', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.essential,
      ),
      Meal(
        id: 'm1s',
        title: 'Snacks',
        time: '4:30 PM - 5:30 PM',
        calories: 220,
        items: ['Red Chana Aloo Masala', 'Muri', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.light,
      ),
      Meal(
        id: 'm1d',
        title: 'Dinner',
        time: '7:30 PM - 9:00 PM',
        calories: 680,
        items: ['Chicken Curry / Paneer Butter Masala', 'Rice', 'Dal', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.premium,
      ),
    ],
    2: [
      // Wednesday
      Meal(
        id: 'm2b',
        title: 'Breakfast',
        time: '7:30 AM - 9:00 AM',
        calories: 290,
        items: ['Veg Cutlet', 'Chutney', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.morning,
      ),
      Meal(
        id: 'm2l',
        title: 'Lunch',
        time: '12:30 PM - 2:00 PM',
        calories: 760,
        items: ['Egg Aloo Curry / Mixed Veg', 'Rice', 'Dal', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.essential,
      ),
      Meal(
        id: 'm2s',
        title: 'Snacks',
        time: '4:30 PM - 5:30 PM',
        calories: 200,
        items: ['Bread Butter', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.light,
      ),
      Meal(
        id: 'm2d',
        title: 'Dinner',
        time: '7:30 PM - 9:00 PM',
        calories: 720,
        items: ['Chicken Curry / Paneer Butter Masala', 'Rice', 'Dal', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.premium,
      ),
    ],
    3: [
      // Thursday
      Meal(
        id: 'm3b',
        title: 'Breakfast',
        time: '7:30 AM - 9:00 AM',
        calories: 330,
        items: ['Poori', 'Aloo Sabzi', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.morning,
      ),
      Meal(
        id: 'm3l',
        title: 'Lunch',
        time: '12:30 PM - 2:00 PM',
        calories: 790,
        items: ['Rajma Chawal', 'Rice', 'Raita', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.essential,
      ),
      Meal(
        id: 'm3s',
        title: 'Snacks',
        time: '4:30 PM - 5:30 PM',
        calories: 180,
        items: ['Samosa', 'Chutney', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.light,
      ),
      Meal(
        id: 'm3d',
        title: 'Dinner',
        time: '7:30 PM - 9:00 PM',
        calories: 700,
        items: ['Mutton Curry / Mushroom Masala', 'Rice', 'Dal', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.premium,
      ),
    ],
    4: [
      // Friday
      Meal(
        id: 'm4b',
        title: 'Breakfast',
        time: '7:30 AM - 9:00 AM',
        calories: 300,
        items: ['Idli', 'Sambhar', 'Coconut Chutney', 'Tea'],
        status: MealStatus.available,
        category: MealCategory.morning,
      ),
      Meal(
        id: 'm4l',
        title: 'Lunch',
        time: '12:30 PM - 2:00 PM',
        calories: 820,
        items: ['Biryani / Veg Pulao', 'Raita', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.essential,
      ),
      Meal(
        id: 'm4s',
        title: 'Snacks',
        time: '4:30 PM - 5:30 PM',
        calories: 240,
        items: ['Pakora', 'Tea', 'Biscuit'],
        status: MealStatus.available,
        category: MealCategory.light,
      ),
      Meal(
        id: 'm4d',
        title: 'Dinner',
        time: '7:30 PM - 9:00 PM',
        calories: 690,
        items: ['Fish Fry / Paneer Tikka', 'Roti', 'Dal', 'Salad'],
        status: MealStatus.available,
        category: MealCategory.premium,
      ),
    ],
  };

  List<Meal> get todayMeals => weeklyMeals[selectedDayIndex % 5] ?? [];

  void bookMeal(String mealId) {
    weeklyMeals.forEach((day, meals) {
      for (int i = 0; i < meals.length; i++) {
        if (meals[i].id == mealId) {
          meals[i] = meals[i].copyWith(
            isBooked: true,
            status: MealStatus.booked,
          );

          // Add to bookings
          bookings.insert(
            0,
            Booking(
              id: 'b${bookings.length + 1}',
              mealId: meals[i].id,
              mealTitle: meals[i].title,
              date: _formatDate(day),
              time: meals[i].time,
              items: meals[i].items,
              status: BookingStatus.confirmed,
            ),
          );
        }
      }
    });
    notifyListeners();
  }

  String _formatDate(int dayIndex) {
    final today = DateTime.now();
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final targetDate = monday.add(Duration(days: dayIndex));
    return '${targetDate.day}/${targetDate.month}/${targetDate.year}';
  }

  // ── Bookings ────────────────────────────────────────────────
  List<Booking> bookings = [
    Booking(
      id: 'b1',
      mealId: 'm1l',
      mealTitle: 'Lunch',
      date: '01/05/2026',
      time: '12:30 PM - 2:00 PM',
      items: ['Rice', 'Egg Aloo Curry', 'Dal', 'Salad'],
      status: BookingStatus.confirmed,
    ),
    Booking(
      id: 'b2',
      mealId: 'm2b',
      mealTitle: 'Breakfast',
      date: '30/04/2026',
      time: '7:30 AM - 9:00 AM',
      items: ['Bread', 'Butter & Jam', 'Tea'],
      status: BookingStatus.collected,
    ),
    Booking(
      id: 'b3',
      mealId: 'm3d',
      mealTitle: 'Dinner',
      date: '29/04/2026',
      time: '7:30 PM - 9:00 PM',
      items: ['Chicken Curry', 'Rice', 'Dal'],
      status: BookingStatus.collected,
    ),
    Booking(
      id: 'b4',
      mealId: 'm4s',
      mealTitle: 'Snacks',
      date: '29/04/2026',
      time: '4:30 PM - 5:30 PM',
      items: ['Samosa', 'Tea'],
      status: BookingStatus.cancelled,
    ),
  ];

  List<Booking> get upcomingBookings =>
      bookings.where((b) => b.status == BookingStatus.confirmed).toList();

  List<Booking> get pastBookings =>
      bookings
          .where(
            (b) =>
                b.status == BookingStatus.collected ||
                b.status == BookingStatus.cancelled,
          )
          .toList();

  void cancelBooking(String bookingId) {
    final idx = bookings.indexWhere((b) => b.id == bookingId);
    if (idx != -1) {
      final old = bookings[idx];
      bookings[idx] = Booking(
        id: old.id,
        mealId: old.mealId,
        mealTitle: old.mealTitle,
        date: old.date,
        time: old.time,
        items: old.items,
        status: BookingStatus.cancelled,
      );
      notifyListeners();
    }
  }

  // ── Feedback ────────────────────────────────────────────────
  int selectedFeedbackMeal = 0; // 0=Breakfast, 1=Lunch, 2=Snack, 3=Dinner

  void setFeedbackMeal(int index) {
    selectedFeedbackMeal = index;
    notifyListeners();
  }

  final Map<int, List<Map<String, dynamic>>> feedbackDishes = {
    0: [
      {'name': 'Bread & Butter', 'rating': 0},
      {'name': 'Banana', 'rating': 0},
      {'name': 'Tea', 'rating': 0},
    ],
    1: [
      {'name': 'Rice', 'rating': 0},
      {'name': 'Egg Aloo Curry', 'rating': 0},
      {'name': 'Dal', 'rating': 0},
      {'name': 'Salad', 'rating': 0},
    ],
    2: [
      {'name': 'Sausage', 'rating': 0},
      {'name': 'Makhana', 'rating': 0},
      {'name': 'Tea', 'rating': 0},
    ],
    3: [
      {'name': 'Chicken Curry', 'rating': 0},
      {'name': 'Rice', 'rating': 0},
      {'name': 'Dal', 'rating': 0},
      {'name': 'Salad', 'rating': 0},
    ],
  };

  List<Map<String, dynamic>> get currentFeedbackDishes =>
      feedbackDishes[selectedFeedbackMeal] ?? [];

  void setDishRating(int dishIndex, int rating) {
    if (feedbackDishes[selectedFeedbackMeal] != null &&
        dishIndex < feedbackDishes[selectedFeedbackMeal]!.length) {
      feedbackDishes[selectedFeedbackMeal]![dishIndex]['rating'] = rating;
      notifyListeners();
    }
  }

  bool? overallThumbsUp; // null=no selection, true=thumbs up, false=thumbs down

  void setOverallFeedback(bool isPositive) {
    overallThumbsUp = isPositive;
    notifyListeners();
  }

  void submitFeedback(String additionalThoughts) {
    // Reset after submission
    for (var dishes in feedbackDishes.values) {
      for (var dish in dishes) {
        dish['rating'] = 0;
      }
    }
    overallThumbsUp = null;
    notifyListeners();
  }

  // ── Notifications ───────────────────────────────────────────
  List<AppNotification> notifications = [
    AppNotification(
      id: 'n1',
      title: 'Booking Confirmed',
      message: 'Your lunch booking for today has been confirmed. Show QR at counter.',
      time: '10 min ago',
      type: NotificationType.booking,
    ),
    AppNotification(
      id: 'n2',
      title: 'Menu Updated',
      message: 'Wednesday dinner menu has been updated. Check new items!',
      time: '1 hour ago',
      type: NotificationType.menu,
    ),
    AppNotification(
      id: 'n3',
      title: 'Feedback Reminder',
      message: 'Don\'t forget to rate your breakfast. Your feedback helps us improve.',
      time: '3 hours ago',
      type: NotificationType.feedback,
      isRead: true,
    ),
    AppNotification(
      id: 'n4',
      title: 'Canteen Holiday',
      message: 'Canteen will remain closed on Sunday, 4th May for maintenance.',
      time: 'Yesterday',
      type: NotificationType.system,
      isRead: true,
    ),
    AppNotification(
      id: 'n5',
      title: 'New Meal Plan',
      message: 'Summer meal plan is now available. Update your preferences in profile.',
      time: '2 days ago',
      type: NotificationType.system,
      isRead: true,
    ),
  ];

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  void markNotificationRead(String id) {
    final idx = notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      notifications[idx] = notifications[idx].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void markAllRead() {
    for (int i = 0; i < notifications.length; i++) {
      notifications[i] = notifications[i].copyWith(isRead: true);
    }
    notifyListeners();
  }

  // ── Profile Stats ───────────────────────────────────────────
  int get totalMealsBooked => bookings.length;
  int get feedbackGiven => 12; // mock
  int get streakDays => 5; // mock
  
}
