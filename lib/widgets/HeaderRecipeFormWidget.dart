import 'dart:io';

import 'package:flutter/material.dart';


class HeaderRecipeFormWidget extends StatelessWidget{
  final String? imagePath;
  bool showOptions = false;
  VoidCallback pickImage;

  HeaderRecipeFormWidget({super.key, this.imagePath, this.showOptions = false, required this.pickImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(width: double.infinity, height: 220, child: (imagePath != null && imagePath!.isNotEmpty) ? Image.file(File(imagePath!), fit: BoxFit.fitWidth,width: double.infinity,) : const Icon(Icons.dinner_dining_outlined, color: Colors.grey, size: 120,)),
        if (showOptions) Positioned(
            right: 10,
            child: IconButton(onPressed: pickImage,
                icon: const Icon(Icons.camera_alt_outlined)
            )
        )
      ],
    );
  }

}