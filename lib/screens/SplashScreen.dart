import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_project/providers/SplashProvider.dart';
import 'package:recipes_project/screens/RecipeListScreen.dart';
import 'package:recipes_project/widgets/MainIconWidget.dart';

class SplashScreen extends ConsumerWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashState = ref.watch(splashProvider);
    return Scaffold(
      body: splashState.when(
          data: (_) {
            Future.delayed(const Duration(milliseconds: 500), () {
              navigateToList(context);
            });
            return splashBody();
            },
          error: (e, stack){return splashBody();},
          loading: (){return splashBody();}
    )
    );
  }

  Widget splashBody () {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainIconWidget(),
          const Text("MY RECIPES", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

  void navigateToList(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RecipeListScreen()));
  }
}

