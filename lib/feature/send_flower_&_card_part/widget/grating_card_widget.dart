import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';

import 'base_card_widget.dart';


class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key,required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      icon: AppIcons.message01,
      title:"Your Message",
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: const Color(0xFF373B4C),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF2D3142)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: SizedBox(
          width: 271,
          child: Text(
            message,
            style: TextFontStyle.textStyle12InterW600,
          ),
        ),
      ),
    );
  }
}