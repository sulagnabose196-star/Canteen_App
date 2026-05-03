class Meal {
  final String id;
  final String title;
  final String time;
  final int calories;
  final bool isBooked;
  final List<String> items;
  final MealStatus status;
  final MealCategory category;

  Meal({
    required this.id,
    required this.title,
    required this.time,
    required this.calories,
    this.isBooked = false,
    this.items = const [],
    this.status = MealStatus.available,
    this.category = MealCategory.essential,
  });

  Meal copyWith({
    String? id,
    String? title,
    String? time,
    int? calories,
    bool? isBooked,
    List<String>? items,
    MealStatus? status,
    MealCategory? category,
  }) {
    return Meal(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      calories: calories ?? this.calories,
      isBooked: isBooked ?? this.isBooked,
      items: items ?? this.items,
      status: status ?? this.status,
      category: category ?? this.category,
    );
  }
}

enum MealStatus { available, booked, closed }

enum MealCategory { morning, essential, light, premium }
