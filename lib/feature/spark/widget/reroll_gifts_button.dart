import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';

class RerollButton extends StatefulWidget {
  final VoidCallback onTap;

  const RerollButton({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RerollButton> createState() => _RerollButtonState();
}

class _RerollButtonState extends State<RerollButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // 1s per rotation
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startRotation() {
    // start rotating
    _controller.repeat();

    // call user’s function
    widget.onTap();

    // stop after 30 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startRotation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: ShapeDecoration(
          color: AppColor.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          spacing: 6,
          children: [
            RotationTransition(
              turns: _controller,
              child: const Icon(Icons.update, color: Colors.white),
            ),
            Text(
              'Reroll Gifts',
              style: TextFontStyle.textStyle12InterW400,
            ),
          ],
        ),
      ),
    );
  }
}
