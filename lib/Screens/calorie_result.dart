import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

class ResultScreen extends StatelessWidget {
  final double bmr;
  final double dailyCalories;
  final String goal;

  const ResultScreen({
    super.key,
    required this.bmr,
    required this.dailyCalories,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Your Results',
            style: TextStyle(
              color: AppColors.blueColor,
              fontSize: ScreenUtil().setSp(30.0),
              fontFamily: 'RubikBold',
            ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text('BMR: ${bmr.toStringAsFixed(2)} kcal/day',
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent,
                )),
            const SizedBox(height: 10),
            Text(
              'To ${goal.toLowerCase()}, you need ${dailyCalories.toStringAsFixed(2)} kcal/day.',
              style: const TextStyle(fontSize: 18, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  const WidgetStatePropertyAll(AppColors.blueColor),
                  minimumSize: const WidgetStatePropertyAll(
                    Size(300, 55),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              onPressed: () => Navigator.pop(context),
              child:  Text('Recalculate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30.0),
                  fontFamily: 'RubikBold',
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    const WidgetStatePropertyAll(AppColors.blueColor),
                    minimumSize: const WidgetStatePropertyAll(
                      Size(300, 55),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )),
              onPressed: () => Navigator.pop(context),
              child:  Text('AI Analyzer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(30.0),
                  fontFamily: 'RubikBold',
                ),
                  )
              ),


          ],
        ),
      ),
    );
  }
}
