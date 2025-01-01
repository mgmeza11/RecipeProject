import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_project/widgets/MainIconWidget.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainIconWidget(),
            const Text("MY RECIPES", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
          ],
        ),
      )
    );
  }
}