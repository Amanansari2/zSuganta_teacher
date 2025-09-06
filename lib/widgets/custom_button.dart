import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final double? padding;
  final double? fontSize;
  final double? height;
  final double? width;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.radius,
    this.padding,
    this.fontSize,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
          ),
          padding: EdgeInsets.symmetric(
            vertical: padding ?? 16,
            horizontal: padding ?? 32,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
