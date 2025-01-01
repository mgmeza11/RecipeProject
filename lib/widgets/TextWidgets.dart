import 'package:flutter/cupertino.dart';

class LargeTitle extends StatelessWidget{

  final String text;

  const LargeTitle({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.start,
    );
  }
}

class MediumTitle extends StatelessWidget{

  final String text;

  const MediumTitle({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.start
    );
  }
}

class DetailText extends StatelessWidget{

  final String text;
  int? maxLines;

  DetailText({super.key, required this.text, this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal
        ),
      textAlign: TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines!= null ? TextOverflow.ellipsis : null,
    );
  }
}