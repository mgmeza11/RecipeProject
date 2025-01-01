import 'package:flutter/material.dart';
import 'package:recipes_project/models/Tag.dart';

class TagWidget extends StatelessWidget{
  final Tag tag;

  const TagWidget({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(tag.description),
      backgroundColor: Colors.cyanAccent.withOpacity(0.1),
      side: BorderSide.none,
    );
  }
}