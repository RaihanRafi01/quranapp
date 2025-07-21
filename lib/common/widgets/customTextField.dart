import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../appColors.dart';
import '../customFont.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.btnClr1,
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      enabled: widget.enabled,
      style: h4.copyWith(color: AppColors.textColor), // Use h4 with fontSize: 16.sp
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: h4.copyWith(color: Colors.grey[600]), // Use h4 with fontSize: 16.sp
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey[600],
            size: 20.sp, // Responsive icon size
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : widget.suffixIcon,
        filled: true,
        fillColor: AppColors.txtInput,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Responsive border radius
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Responsive border radius
          borderSide: BorderSide(color: AppColors.txtInput, width: 1.w), // Responsive border width
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Responsive border radius
          borderSide: BorderSide(color: AppColors.btnClr1, width: 2.w), // Responsive border width
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Responsive border radius
          borderSide: BorderSide(color: Colors.red, width: 1.w), // Responsive border width
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h), // Responsive padding
      ),
    );
  }
}