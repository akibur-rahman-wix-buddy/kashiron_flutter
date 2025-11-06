import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';

class ReminderBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E2C), // dark background
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Options",
                style: TextFontStyle.textStyle16InterW700
              ),
              const SizedBox(height: 12),

              // Delete Spark
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFDB2121),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.delete_outlined, color: Colors.white),
                  ),
                  title:  Text(
                    "Delete Spark",
                    style: TextFontStyle.textStyle14InterW500,
                  ),
                  subtitle: const Text(
                    "Remove this reminder",
                    style: TextStyle(color: Colors.white54),
                  ),
                  onTap: () {
                    // Handle delete action
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Remind Me
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFEB690E),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.notification_important, color: Colors.white),
                  ),
                  title: const Text(
                    "Remind Me",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    "Click to edit reminder",
                    style: TextStyle(color: Colors.white54),
                  ),
                  trailing: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFEB690E),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Handle edit reminder
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Reminder Info
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title:  Text(
                    "Reminder set for 26 September 2025 at 16:30",
                    style: TextFontStyle.textStyle14InterW500.copyWith(color: Color(0xFF24C776)),
                  ),
                  subtitle:  Text(
                    "You’ll be notified about this spark",
                    style: TextFontStyle.textStyle12InterW400.copyWith(color: Colors.white60),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      // Handle remove reminder
                    },
                    child:  Text(
                      "Remove",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
