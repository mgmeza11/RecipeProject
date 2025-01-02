import 'package:flutter/material.dart';


class HeaderRecipeFormWidget extends StatelessWidget{
  final String? imagePath;
  bool showOptions = false;

  HeaderRecipeFormWidget({super.key, this.imagePath, this.showOptions = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/imagen_pasta.jpeg"),
        if (showOptions) Positioned(
            right: 10,
            child: IconButton(onPressed: () {

            },
                icon: const Icon(Icons.camera_alt_outlined)
            )
        )
      ],
    );
  }

}