import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VipListShimmer extends StatelessWidget {
  const VipListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2F3444),
      highlightColor: const Color(0xFF3E445B),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchBar(),
          const SizedBox(height: 16),
          _filterChips(),
          const SizedBox(height: 16),
          ...List.generate(3, (_) => _vipCard()),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  Widget _filterChips() {
    return Row(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 90,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _vipCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: 120, height: 14),
                    const SizedBox(height: 8),
                    _line(width: 60, height: 12),
                  ],
                ),
              ),
              _line(width: 40, height: 12),
            ],
          ),
          const SizedBox(height: 16),
          _line(width: double.infinity, height: 40),
        ],
      ),
    );
  }

  Widget _line({double? width, double height = 12}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
