import '../models/meal.dart';

class SyntheticData {

  //returns example historical meals
  static List<Meal> getMeals() {
    return [
      Meal(
        name: 'Pasta',
        carbs: 60,
        insulin: 5,
        preGlucose: 6.0,
        glucose1h: 8.1,
        glucose2h: 9.2,
        glucose3h: 7.4,
        dateTime: DateTime(2026, 11, 20),
      ),
      Meal(
        name: 'Rice',
        carbs: 65,
        insulin: 5,
        preGlucose: 6.2,
        glucose1h: 8.5,
        glucose2h: 9.8,
        glucose3h: 7.8,
        dateTime: DateTime(2026, 11, 19),
      ),
      Meal(
        name: 'Sandwich',
        carbs: 30,
        insulin: 3,
        preGlucose: 5.5,
        glucose1h: 6.5,
        glucose2h: 7.0,
        glucose3h: 6.0,
        dateTime: DateTime(2026, 11, 18),
      ),
      Meal(
        name: 'Pizza',
        carbs: 70,
        insulin: 6,
        preGlucose: 6.1,
        glucose1h: 9.0,
        glucose2h: 10.0,
        glucose3h: 8.0,
        dateTime: DateTime(2026, 11, 17),
      ),
      Meal(
        name: 'Salad',
        carbs: 15,
        insulin: 2,
        preGlucose: 5.2,
        glucose1h: 5.8,
        glucose2h: 6.0,
        glucose3h: 5.5,
        dateTime: DateTime(2026, 11, 16),
      ),
    ];
  }
}