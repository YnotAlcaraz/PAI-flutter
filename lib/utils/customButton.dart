import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  late double height;
  late double width;
  final String label;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  late Color fontColor;
  late double fontSize;
  late double radius;
  late TextAlign textAlign;

  CustomButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    this.fontColor = Colors.white,
    this.fontSize = 14,
    this.height = 30,
    this.width = 150,
    this.radius = 5,
    this.textAlign = TextAlign.center,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            )
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}