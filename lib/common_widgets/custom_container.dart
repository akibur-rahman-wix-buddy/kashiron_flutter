import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final Border? border;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;

  const CustomContainer({
    Key? key,
    required this.child,
    this.padding,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? AppColor.authBg,
        border: border,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: const Color(0x3D299DF5),
                offset: const Offset(0, 0),
                blurRadius: 0,
              ),
            ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: child,
      ),
    );
  }
}
