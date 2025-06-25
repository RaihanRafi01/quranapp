import 'package:flutter/material.dart';

import '../appColors.dart';
import '../customFont.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color txtClr;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.label, required this.onPressed, required this.color, required this.txtClr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: txtClr, backgroundColor: color, minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label,style: h4.copyWith(fontSize: 16)),
    );
  }
}