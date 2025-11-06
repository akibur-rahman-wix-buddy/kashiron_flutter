import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';

class LogoutDialog {
  static void showLogoutDialog({
    required bool isLoading,
    required BuildContext context,
    required VoidCallback onLogout,
    String title = "Logout",
    String message = "Are you sure you want to logout?",
    String confirmText = "Logout",
    String cancelText = "Cancel",
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(
            context,
            title,
            message,
            isLoading,
            confirmText,
            cancelText,
            onLogout,
          ),
        );
      },
    );
  }

  static Widget _buildDialogContent(
      BuildContext context,
      String title,
      String message,
      bool isLoading,
      String confirmText,
      String cancelText,
      VoidCallback onLogout,
      ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xff20242e), // Your primary color as background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white, // White text for contrast
            ),
          ),

          const SizedBox(height: 8),

          // Message
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70, // Lighter white for message
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Text(
                    cancelText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Logout Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    onLogout(); // Execute logout function
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonColor, // White button on dark background
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading?CircularProgressIndicator(color: Colors.white,): Text(
                    confirmText,
                    style: TextStyle(
                      color: Color(0xffffffff), // Primary color as text color
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}