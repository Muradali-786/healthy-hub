import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';
import 'calorie_result.dart';


void main() => runApp(CalorieCalculator());

class CalorieCalculator extends StatelessWidget {
  const CalorieCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalorieCalculatorScreen(),
    );
  }
}

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key});

  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String gender = "Male";
  String activityLevel = "Sedentary";
  String goal = "Maintain weight";

  void calculateCalories() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Close keyboard

      double bmr = _calculateBMR();
      double dailyCalories = _adjustCaloriesForGoal(bmr);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            bmr: bmr,
            dailyCalories: dailyCalories,
            goal: goal,
          ),
        ),
      );
    }
  }

  double _calculateBMR() {
    double weight = double.tryParse(weightController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    int age = int.tryParse(ageController.text) ?? 0;

    if (weight <= 0 || height <= 0 || age <= 0) return 0.0;

    return (gender == "Male")
        ? (10 * weight + 6.25 * height - 5 * age + 5)
        : (10 * weight + 6.25 * height - 5 * age - 161);
  }

  double _adjustCaloriesForGoal(double bmr) {
    double multiplier = {
      "Sedentary": 1.2,
      "Lightly active": 1.375,
      "Moderately active": 1.55,
      "Very active": 1.725,
      "Super active": 1.9,
    }[activityLevel] ?? 1.2;

    double dailyCalories = bmr * multiplier;

    if (goal == "Lose weight") dailyCalories -= 500;
    if (goal == "Gain weight") dailyCalories += 500;

    return dailyCalories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AI Assisted Smart Health Hub',
          style: TextStyle(
            color: AppColors.blueColor,
            fontSize: ScreenUtil().setSp(23.0),
            fontFamily: 'RubikBold',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTitle('Calorie Calculator',
              ),
              _buildInputField(weightController, 'Weight (kg)', 'Please enter your weight'),
              _buildInputField(heightController, 'Height (cm)', 'Please enter your height'),
              _buildInputField(ageController, 'Age (years)', 'Please enter your age'),
              _buildDropdown('Gender', gender, ['Male', 'Female'], (String? newValue) {
                setState(() => gender = newValue!);
              }),
              _buildDropdown('Activity Level', activityLevel, [
                'Sedentary', 'Lightly active', 'Moderately active', 'Very active', 'Super active'
              ], (String? newValue) {
                setState(() => activityLevel = newValue!);
              }),
              _buildDropdown('Goal', goal, ['Maintain weight', 'Lose weight', 'Gain weight'], (String? newValue) {
                setState(() => goal = newValue!);
              }),
              const SizedBox(height: 40),
              _buildCalculateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.blueColor,
          fontSize: ScreenUtil().setSp(25.0),
          fontFamily: 'RubikBold',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, String validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? validator : null,
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.blueColor),
        minimumSize: const WidgetStatePropertyAll(Size(300, 55)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: calculateCalories,
      child: Text(
        'Calculate Calories',
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(26.0),
          fontFamily: 'RubikBold',
        ),
      ),
    );
  }
}
