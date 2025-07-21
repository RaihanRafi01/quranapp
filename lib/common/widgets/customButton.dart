import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../appColors.dart';
import '../customFont.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color txtClr;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.color,
    required this.txtClr,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: txtClr,
        backgroundColor: color,
        minimumSize: Size(width ?? double.infinity, height ?? 50.h), // Responsive height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r), // Responsive border radius
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // Responsive padding
      ),
      child: Text(
        label,
        style: h4.copyWith(color: txtClr), // Use h4 directly, override color only
      ),
    );
  }
}