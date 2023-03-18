import 'package:flutter/material.dart';

class HandleButton extends StatelessWidget {
  const HandleButton({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    required this.function,
    required this.fontSize,
    super.key,
  });
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Function function;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (backgroundColor == Colors.black)
          ? null
          : BoxDecoration(border: Border.all(width: 1.5)),
      child: TextButton(
        onPressed: function as Function(),
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
