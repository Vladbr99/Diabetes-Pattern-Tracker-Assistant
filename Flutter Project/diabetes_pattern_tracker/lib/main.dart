import 'package:flutter/material.dart';

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

  //release controllers
  @override
  void dispose() {
    nameController.dispose();
    carbsController.dispose();
    insulinController.dispose();
    glucoseController.dispose();
    super.dispose();
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
        ],
      ),
    );
  }
}