import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../assets_helperfdg/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? leftIcon;
  final String? rightIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? fieldColor;
  final double? textSize;
  final TextAlign? textAlign;
  final double? height;
  final GestureTapCallback? onTap;
  final bool read;
  final dynamic radius;
  final VoidCallback? onRightTap;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.leftIcon,
    this.rightIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.radius = 10.0,
    this.validator,
    this.borderColor,
    this.fieldColor,
    this.textSize,
    this.textAlign = TextAlign.start,
    this.height = 52.0,
    this.read = false,
    this.onTap,
    this.onRightTap,this.inputType,
    this.onChanged
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    final bool isLargeField = (widget.height ?? 52.h) > 100.h;

    return TextFormField(
      obscuringCharacter: "*",
      keyboardType:widget.inputType,
      controller: widget.controller,
      onChanged: widget.onChanged,
      readOnly: widget.read,
      obscureText: widget.isPassword && widget.obscureText,
      validator: widget.validator,
      style: TextStyle(
        color: Colors.white,
        fontSize: widget.textSize ?? 14.sp,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: AppColor.cFFFFFF,
      textAlign: widget.textAlign ?? TextAlign.start,
      onTap: widget.onTap,
      maxLines: isLargeField ? null : 1,
      minLines: isLargeField ? 5 : 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.fieldColor ?? Color(0xff373b4c),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Color(0xff787A83),
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.leftIcon != null
            ? Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(
            widget.leftIcon!,
            height: 20.h,
            width: 20.w,
          ),
        )
            : null,
        suffixIcon: widget.isPassword
            ? GestureDetector(
          onTap: widget.toggleVisibility,
          child: Icon(
            widget.obscureText
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColor.c979797,
          ),
        )
            : (widget.rightIcon != null
            ? GestureDetector(
          onTap: widget.onRightTap,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(
              widget.rightIcon!,
              height: 20.h,
              width: 20.w,
            ),
          ),
        )
            : null),
        contentPadding: isLargeField
            ? EdgeInsets.only(top: 12.h)
            : EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: widget.borderColor ??  Colors.transparent,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.blueGrey,
            width: 1.2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
      ),
    );
  }
}