import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 582.h,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF2C3344),
        highlightColor: const Color(0xFF3A4154),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// =======================
            /// TOP 3 STAT CARDS
            /// =======================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => _statCard(),
              ),
            ),

            24.verticalSpace,

            /// =======================
            /// UPCOMING SPARKS TITLE
            /// =======================
            _titleShimmer(width: 150.w),

            16.verticalSpace,

            /// =======================
            /// 1 UPCOMING SPARK CARD
            /// =======================
            _bigCardShimmer(),

            24.verticalSpace,

            /// =======================
            /// UPCOMING BIRTHDAY TITLE
            /// =======================
            _titleShimmer(width: 170.w),

            16.verticalSpace,

            /// =======================
            /// 2 UPCOMING BIRTHDAY CARDS
            /// =======================
            _birthdayCard(),
            12.verticalSpace,
            _birthdayCard(),
          ],
        ),
      ),
    );
  }

  /// ===========================
  /// Small Top Stat Card
  /// ===========================
  Widget _statCard() {
    return Container(
      height: 90.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
    );
  }

  /// ===========================
  /// Section Title
  /// ===========================
  Widget _titleShimmer({required double width}) {
    return Container(
      height: 16.h,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }

  /// ===========================
  /// Big Upcoming Spark Card
  /// ===========================
  Widget _bigCardShimmer() {
    return Container(
      height: 160.h,
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }

  /// ===========================
  /// Birthday Card
  /// ===========================
  Widget _birthdayCard() {
    return Container(
      height: 70.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
    );
  }
}
