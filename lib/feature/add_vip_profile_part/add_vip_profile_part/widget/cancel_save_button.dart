
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelSaveButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  const CancelSaveButton({
    super.key, required this.title, this.onTap, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: double.infinity,
        padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: ShapeDecoration(
          color: color,
         // color:  Color(0xFF373B4C),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFEDEDED),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}