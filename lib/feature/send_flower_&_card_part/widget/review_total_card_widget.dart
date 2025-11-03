import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';

class ReviewTotalCardWidget extends StatelessWidget {
  const ReviewTotalCardWidget({
    super.key, required this.totalAmount, required this.flowerCardAmount,
  });
  final String totalAmount;
  final String flowerCardAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [
            const Color(0xFF363A4D),
            const Color(0xFF4D536D)
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 14,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                Text('Total Amount',
                    style: TextFontStyle.textStyle14InterW500),
                Text('\$70',
                    style: TextFontStyle.textStyle14InterW500),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Colors.white,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                Text('Flowers & Card',
                    style: TextFontStyle.textStyle14InterW500),
                Text('\$70',
                    style: TextFontStyle.textStyle14InterW500),
              ],
            ),
          ),
        ],
      ),
    );
  }
}