class Booking {
  final String id;
  final String mealId;
  final String mealTitle;
  final String date;
  final String time;
  final List<String> items;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.mealId,
    required this.mealTitle,
    required this.date,
    required this.time,
    this.items = const [],
    this.status = BookingStatus.confirmed,
  });
}

enum BookingStatus { confirmed, collected, cancelled }
