// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
//
// class HomeShimmer extends StatelessWidget {
//   const HomeShimmer({super.key});
//
//   Widget shimmerBox({
//     required double height,
//     double? width,
//     BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
//   }) {
//     return Shimmer.fromColors(
//       baseColor: const Color(0xFF2A2E3D),
//       highlightColor: const Color(0xFF3A3F54),
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: borderRadius,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF121624),
//       // Removed floatingActionButton from shimmer to avoid hero tag conflicts
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // Changed from ListView to SingleChildScrollView
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// ---------------- TOP STATS ----------------
//               Row(
//                 children: List.generate(
//                   3,
//                   (index) => Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 6),
//                       child: shimmerBox(height: 90),
//                     ),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               /// ---------------- TITLE ----------------
//               shimmerBox(height: 18, width: 160),
//
//               const SizedBox(height: 16),
//
//               /// ---------------- REMINDER CARD ----------------
//               ...List.generate(2, (index) {
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 14),
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1E2230),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           shimmerBox(height: 14, width: 200),
//                           const Spacer(),
//                           shimmerBox(height: 12, width: 70),
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       Row(
//                         children: [
//                           shimmerBox(
//                             height: 40,
//                             width: 40,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(20)),
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               shimmerBox(height: 12, width: 120),
//                               const SizedBox(height: 6),
//                               shimmerBox(height: 10, width: 90),
//                             ],
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 14),
//                       shimmerBox(height: 12),
//                       const SizedBox(height: 6),
//                       shimmerBox(height: 12, width: 180),
//                       const SizedBox(height: 16),
//                       Row(
//                         children: [
//                           Expanded(child: shimmerBox(height: 40)),
//                           const SizedBox(width: 12),
//                           Expanded(child: shimmerBox(height: 40)),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP STATS
          Row(
            children: List.generate(
              3,
              (_) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: _shimmerBox(height: 80.h, radius: 12.r),
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          /// UPCOMING SPARKS TITLE
          _shimmerLine(width: 160.w),

          SizedBox(height: 16.h),

          /// UPCOMING SPARK CARD 1
          _sparkCardShimmer(),

          SizedBox(height: 12.h),

          /// UPCOMING SPARK CARD 2
          _sparkCardShimmer(),

          SizedBox(height: 24.h),

          /// UPCOMING BIRTHDAY TITLE
          _shimmerLine(width: 180.w),

          SizedBox(height: 16.h),

          /// BIRTHDAY ITEM
          _birthdayItemShimmer(),
        ],
      ),
    );
  }

  /// Spark Card Shimmer
  Widget _sparkCardShimmer() {
    return _shimmerBox(
      height: 110.h,
      radius: 16.r,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TOP ROW
                  Row(
                    children: [
                      _shimmerCircle(size: 36.r),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _shimmerLine(width: 120.w),
                          SizedBox(height: 6.h),
                          _shimmerLine(width: 70.w, height: 10.h),
                        ],
                      ),
                      const Spacer(),
                      _shimmerLine(width: 45.w, height: 10.h),
                    ],
                  ),

                  const Spacer(), // 👈 THIS IS IMPORTANT

                  /// DESCRIPTION
                  _shimmerLine(width: double.infinity),

                  SizedBox(height: 8.h),

                  /// BUTTONS
                  Row(
                    children: [
                      _shimmerBox(
                        width: 80.w,
                        height: 26.h,
                        radius: 6.r,
                      ),
                      SizedBox(width: 8.w),
                      _shimmerBox(
                        width: 90.w,
                        height: 26.h,
                        radius: 6.r,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Birthday Item Shimmer
  Widget _birthdayItemShimmer() {
    return Row(
      children: [
        _shimmerCircle(size: 40.r),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _shimmerLine(width: 120.w),
            SizedBox(height: 6.h),
            _shimmerLine(width: 80.w, height: 10.h),
          ],
        ),
        const Spacer(),
        _shimmerLine(width: 50.w, height: 10.h),
      ],
    );
  }

  /// Base shimmer box
  Widget _shimmerBox({
    double? width,
    double? height,
    double radius = 8,
    Widget? child,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade700,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: child,
      ),
    );
  }

  /// Shimmer text line
  Widget _shimmerLine({
    double? width,
    double height = 14,
  }) {
    return _shimmerBox(
      width: width,
      height: height,
      radius: 6.r,
    );
  }

  /// Shimmer circle (avatar / icon)
  Widget _shimmerCircle({double size = 40}) {
    return _shimmerBox(
      width: size,
      height: size,
      radius: size / 2,
    );
  }
}
