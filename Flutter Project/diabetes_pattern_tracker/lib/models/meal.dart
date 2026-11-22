
class Meal {
  
  //information about a recorded meal
  String name;
  double carbs;
  double insulin;
  double preGlucose;
  double glucose1h;
  double glucose2h;
  double glucose3h;
  DateTime dateTime;

  //creates a new meal record
  Meal({
    required this.name,
    required this.carbs,
    required this.insulin,
    required this.preGlucose,
    required this.glucose1h,
    required this.glucose2h,
    required this.glucose3h,
    required this.dateTime,
  });
}
