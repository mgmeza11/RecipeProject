

import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget{

  final String message;

  const CustomErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/olla_cayendo.jpg", height: 200,),
          const Text("OOPS", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),),
          Text(message, style: const TextStyle(fontSize: 18, color: Colors.grey),)
        ],
      )
    );
  }

}