import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'services/knn_service.dart';
import 'data/synthetic_data.dart';

void main() {
  runApp(const MyApp());
}

//main application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//main screen
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //controllers for meal information
  final nameController = TextEditingController();
  final carbsController = TextEditingController();
  final insulinController = TextEditingController();
  final glucoseController = TextEditingController();

  //load historical meals and KNN
  final history = SyntheticData.getMeals();
  final knn = KNNService();

  List<Meal> results = [];

  //release controllers
  @override
  void dispose() {
    nameController.dispose();
    carbsController.dispose();
    insulinController.dispose();
    glucoseController.dispose();
    super.dispose();
  }

  //find similar historical meals
  void findMeals() {
    double? carbs = double.tryParse(carbsController.text);
    double? insulin = double.tryParse(insulinController.text);
    double? glucose = double.tryParse(glucoseController.text);

    //validate meal information
    if (nameController.text.trim().isEmpty ||
        carbs == null || !carbs.isFinite || carbs < 0 ||
        insulin == null || !insulin.isFinite || insulin < 0 ||
        glucose == null || !glucose.isFinite || glucose <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid meal information'),
        ),
      );
      return;
    }

    //create a meal for comparison
    Meal meal = Meal(
      name: nameController.text,
      carbs: carbs,
      insulin: insulin,
      preGlucose: glucose,
      glucose1h: double.nan,
      glucose2h: double.nan,
      glucose3h: double.nan,
      dateTime: DateTime.now(),
    );

    //update similar meal results
    setState(() {
      results = knn.findSimilarMealsImproved(meal, history);
    });
  }

  //displays the interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Pattern Tracker'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Enter Meal Information'),

          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Meal name'),
          ),

          TextField(
            controller: carbsController,
            decoration: const InputDecoration(labelText: 'Carbohydrates (g)'),
          ),

          TextField(
            controller: insulinController,
            decoration: const InputDecoration(labelText: 'Insulin taken (units)'),
          ),

          TextField(
            controller: glucoseController,
            decoration: const InputDecoration(labelText: 'Starting glucose (mmol/L)'),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: findMeals,
            child: const Text('Find Similar Meals'),
          ),

          const SizedBox(height: 20),

          const Text('Similar Historical Meals'),

          //display similar meals
          for (Meal meal in results)
            Card(
              child: ListTile(
                title: Text(meal.name),
                subtitle: Text(
                  'Carbohydrates: ${meal.carbs}g\n'
                  'Insulin taken: ${meal.insulin} units\n'
                  'Starting glucose: ${meal.preGlucose} mmol/L',
                ),
              ),
            ),

          const Text('Synthetic data only. No medical advice.'),
        ],
      ),
    );
  }
}