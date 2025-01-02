import 'package:flutter/material.dart';

Widget CustomAddButton(VoidCallback onPressed){

  return ElevatedButton(
      onPressed: onPressed,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add),
          Text('Agregar')
        ],)
  );
}