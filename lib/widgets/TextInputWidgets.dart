import 'package:flutter/material.dart';

Widget CustomTextInput(String? initialValue, String label, Function(String) onChanged){
  return TextFormField(
    initialValue: initialValue,
    decoration: InputDecoration(labelText: label),
    onChanged: onChanged,
    validator: (value) {
      return "formState.errors['name']";
    },
  );
}