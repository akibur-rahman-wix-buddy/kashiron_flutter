import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  Widget shimmerBox({
    required double height,
    double? width,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A2E3D),
      highlightColor: const Color(0xFF3A3F54),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121624),
      // Removed floatingActionButton from shimmer to avoid hero tag conflicts
      body: SafeArea(
        child: SingleChildScrollView(
          // Changed from ListView to SingleChildScrollView
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------- TOP STATS ----------------
              Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: shimmerBox(height: 90),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ---------------- TITLE ----------------
              shimmerBox(height: 18, width: 160),

              const SizedBox(height: 16),

              /// ---------------- REMINDER CARD ----------------
              ...List.generate(2, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2230),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          shimmerBox(height: 14, width: 200),
                          const Spacer(),
                          shimmerBox(height: 12, width: 70),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          shimmerBox(
                            height: 40,
                            width: 40,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shimmerBox(height: 12, width: 120),
                              const SizedBox(height: 6),
                              shimmerBox(height: 10, width: 90),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 14),
                      shimmerBox(height: 12),
                      const SizedBox(height: 6),
                      shimmerBox(height: 12, width: 180),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: shimmerBox(height: 40)),
                          const SizedBox(width: 12),
                          Expanded(child: shimmerBox(height: 40)),
                        ],
                      )
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
