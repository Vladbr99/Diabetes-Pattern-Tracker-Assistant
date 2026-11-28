
import 'dart:math';
import '../models/meal.dart';

class KNNService {

  //original KNN using carbohydrates only
  List<Meal> findSimilarMeals(Meal newMeal, List<Meal> history) {
    List<Meal> meals = history.where((m) => m != newMeal).toList();

    meals.sort((a, b) => (a.carbs - newMeal.carbs).abs()
        .compareTo((b.carbs - newMeal.carbs).abs()));

    return meals.take(3).toList();
  }

  //min-max scaling
  double normalise(double value, List<double> values) {
    double minimum = values.reduce(min);
    double maximum = values.reduce(max);

    if (minimum == maximum) return 0;

    return (value - minimum) / (maximum - minimum);
  }

  //improved KNN using three characteristics
  List<Meal> findSimilarMealsImproved(Meal newMeal, List<Meal> history) {

    //exclude the selected meal
    List<Meal> meals = history.where((m) => m != newMeal).toList();

    if (meals.isEmpty) return [];

    //get historical values
    List<double> carbs = meals.map((m) => m.carbs).toList();
    List<double> insulin = meals.map((m) => m.insulin).toList();
    List<double> glucose = meals.map((m) => m.preGlucose).toList();

    //calculate Euclidean distance
    double distance(Meal meal) {
      double c = normalise(newMeal.carbs, carbs) -
          normalise(meal.carbs, carbs);

      double i = normalise(newMeal.insulin, insulin) -
          normalise(meal.insulin, insulin);

      double g = normalise(newMeal.preGlucose, glucose) -
          normalise(meal.preGlucose, glucose);

      return sqrt(c * c + i * i + g * g);
    }

    //sort by distance and date
    meals.sort((a, b) {
      int result = distance(a).compareTo(distance(b));
      return result == 0 ? b.dateTime.compareTo(a.dateTime) : result;
    });

    //return up to 3 similar meals
    return meals.take(3).toList();
  }
}
