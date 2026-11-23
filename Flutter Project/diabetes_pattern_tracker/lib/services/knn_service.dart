
import '../models/meal.dart';

class KNNService {

  //finds the 3 meals with the closest carbohydrate amounts
  List<Meal> findSimilarMeals(Meal newMeal, List<Meal> history) {

    //copy the list so the original history is not changed
    List<Meal> meals = List.from(history);

    //sort meals by carbohydrate difference
    meals.sort((a, b) {
      double distanceA = (a.carbs - newMeal.carbs).abs();
      double distanceB = (b.carbs - newMeal.carbs).abs();

      return distanceA.compareTo(distanceB);
    });

    //return up to 3 closest meals
    return meals.take(3).toList();
  }
}
