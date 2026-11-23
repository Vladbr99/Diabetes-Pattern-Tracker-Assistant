
import 'package:flutter_test/flutter_test.dart';
import 'package:diabetes_pattern_tracker/models/meal.dart';
import 'package:diabetes_pattern_tracker/services/knn_service.dart';

void main() {
  test('Find 3 similar meals using KNN', () {

    //create previous meals using synthetic data
    List<Meal> history = [
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

    //create a new meal to compare
    Meal newMeal = Meal(
      name: 'New Meal',
      carbs: 62,
      insulin: 5,
      preGlucose: 6.0,
      glucose1h: 8.0,
      glucose2h: 9.0,
      glucose3h: 7.5,
      dateTime: DateTime(2026, 11, 22),
    );

    //find the 3 closest meals
    KNNService knn = KNNService();
    List<Meal> similar = knn.findSimilarMeals(newMeal, history);

    //check that KNN returns the correct meals
    expect(similar.length, 3);
    expect(similar[0].name, 'Pasta');
    expect(similar[1].name, 'Rice');
    expect(similar[2].name, 'Pizza');

    //display the results
    for (Meal meal in similar) {
      print('${meal.name}: ${meal.carbs}g carbs');
    }
  });
}
