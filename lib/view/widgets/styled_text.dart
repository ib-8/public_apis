import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(
    this.text, {
    Key? key,
    this.color = Colors.black,
    this.weight = FontWeight.normal,
    this.align = TextAlign.start,
  }) : super(key: key);
  final String text;
  final Color color;
  final FontWeight weight;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontWeight: weight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
