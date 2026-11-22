
import '../models/meal.dart';

class GlucoseAnalysis {

  //calculates the change from before eating
  double calculateChange(double before, double after) {
    return after - before;
  }

  //calculates the glucose change after 1 hour
  double changeAfter1Hour(Meal meal) {
    return calculateChange(meal.preGlucose, meal.glucose1h);
  }

  //calculates the glucose change after 2 hours
  double changeAfter2Hours(Meal meal) {
    return calculateChange(meal.preGlucose, meal.glucose2h);
  }

  //calculates the glucose change after 3 hours
  double changeAfter3Hours(Meal meal) {
    return calculateChange(meal.preGlucose, meal.glucose3h);
  }
}
