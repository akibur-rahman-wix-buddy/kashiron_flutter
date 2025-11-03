
import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.primaryBg,
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2F3C),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last updated: February 15, 2025",
              style: TextStyle(color: Colors.grey[400], fontSize: 12),
            ),
            SizedBox(height: 16),
            Text(
              "Your privacy matters to us.",
              style: TextFontStyle.textStyle16InterW700,
            ),
            SizedBox(height: 8),
            Text(
                "This Privacy Policy explains how Brobrain collects, uses, and protects your information.",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 16),
            Text("1. Information We Collect",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text("• Personal details: Name, Email, Date of Birth (optional)",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("• VIP information you add (e.g., birthdays, anniversaries, preferences)",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("• Payment information (processed securely by third-party providers like Stripe)",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("• App usage data (for improving features and experience)",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("2. How We Use Your Data",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text("• To send reminders and notifications",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("• To provide personalized gift suggestions",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("• To process and confirm gift purchases",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("• To improve and secure the app",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("3. Data Protection",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "We use industry-standard encryption and secure servers to protect your personal data. Payment information is never stored directly in Brobrain.",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("4. Sharing of Data",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "We do not sell your data. Information may be shared only with:",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("  • Trusted third-party service providers (e.g., payment processors, delivery partners)",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            Text("  • When required by law or legal process",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("5. Your Rights",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "You can update, correct, or delete your data anytime from the Settings tab. You may also request full account deletion, which will remove all associated information permanently.",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 20),
            Center(child: Text("App version 2.5.0", style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}