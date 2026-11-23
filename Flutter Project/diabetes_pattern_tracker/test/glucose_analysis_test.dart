
import 'package:flutter_test/flutter_test.dart';
import 'package:diabetes_pattern_tracker/models/meal.dart';
import 'package:diabetes_pattern_tracker/services/glucose_analysis.dart';

void main() {
  test('Calculate glucose changes', () {

    //create a meal with example data
    Meal meal = Meal(
      name: 'Pasta',
      carbs: 60,
      insulin: 5,
      preGlucose: 6.0,
      glucose1h: 8.1,
      glucose2h: 9.2,
      glucose3h: 7.4,
      dateTime: DateTime(2026, 11, 22, 13, 0),
    );

    //create the glucose analysis object
    GlucoseAnalysis analysis = GlucoseAnalysis();

    //check the calculations
    expect(analysis.changeAfter1Hour(meal), closeTo(2.1, 0.001));
    expect(analysis.changeAfter2Hours(meal), closeTo(3.2, 0.001));
    expect(analysis.changeAfter3Hours(meal), closeTo(1.4, 0.001));

    //display the results
    print('Meal: ${meal.name}');
    print('1 hour: ${analysis.changeAfter1Hour(meal).toStringAsFixed(1)}');
    print('2 hours: ${analysis.changeAfter2Hours(meal).toStringAsFixed(1)}');
    print('3 hours: ${analysis.changeAfter3Hours(meal).toStringAsFixed(1)}');
  });
}
