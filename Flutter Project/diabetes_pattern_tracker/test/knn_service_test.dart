
import 'package:flutter_test/flutter_test.dart';
import 'package:diabetes_pattern_tracker/models/meal.dart';
import 'package:diabetes_pattern_tracker/services/knn_service.dart';

void main() {
  KNNService knn = KNNService();

  //creates synthetic meal records
  Meal createMeal(String name, double carbs, double insulin, double glucose) {
    return Meal(
      name: name,
      carbs: carbs,
      insulin: insulin,
      preGlucose: glucose,
      glucose1h: 8.0,
      glucose2h: 9.0,
      glucose3h: 7.0,
      dateTime: DateTime(2026, 11, 22),
    );
  }

  //synthetic meal history
  List<Meal> history = [
    createMeal('Pasta', 60, 5, 6.0),
    createMeal('Rice', 65, 5, 6.2),
    createMeal('Sandwich', 30, 3, 5.5),
    createMeal('Pizza', 70, 6, 6.1),
    createMeal('Salad', 15, 2, 5.2),
  ];

  Meal newMeal = createMeal('New Meal', 62, 5, 6.0);

  //test original KNN
  test('Original KNN', () {
    var results = knn.findSimilarMeals(newMeal, history);
    expect(results.length, 3);
    expect(results.first.name, 'Pasta');
  });

  //test improved KNN
  test('Improved KNN', () {
    var results = knn.findSimilarMealsImproved(newMeal, history);
    expect(results.length, 3);
    expect(results.first.name, 'Pasta');

    for (Meal meal in results) {
      print(meal.name);
    }
  });

  //test empty history
  test('Empty history', () {
    expect(knn.findSimilarMealsImproved(newMeal, []), isEmpty);
  });

  //test insufficient history
  test('Insufficient history', () {
    var results = knn.findSimilarMealsImproved(newMeal, [history.first]);
    expect(results.length, 1);
  });

  //test self exclusion
  test('Exclude selected meal', () {
    var results = knn.findSimilarMealsImproved(history.first, history);
    expect(results.contains(history.first), false);
  });

  //test min-max scaling
  test('Min-max scaling', () {
    expect(knn.normalise(60, [20, 100]), 0.5);
    expect(knn.normalise(60, [60, 60]), 0);
  });
}
