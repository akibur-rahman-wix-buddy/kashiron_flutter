
import 'package:flutter/material.dart';

class SelectedInterestsScreen extends StatefulWidget {
  const SelectedInterestsScreen({Key? key, required this.interests}) : super(key: key);
  final List<String> interests;
  @override
  State<SelectedInterestsScreen> createState() => _SelectedInterestsScreenState();
}

class _SelectedInterestsScreenState extends State<SelectedInterestsScreen> {


  final Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
    decoration: ShapeDecoration(
    color: const Color(0xFF2D3142),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    ),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Selected Interests",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.interests.map((interest) {
              final bool isSelected = selectedInterests.contains(interest);
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedInterests.remove(interest);
                    } else {
                      selectedInterests.add(interest);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: isSelected
                      ? const Color(0xFF00ADB5)
                      : const Color(0xFF2D3142),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 10),
                ),
                child: Text(
                  interest,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
