import 'package:flutter/material.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';

class TermsAndConditionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2F3C),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Terms of Use"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last updated: February 15, 2025",
              style: TextFontStyle.textStyle14InterW400
                  .copyWith(color: Colors.white60),
            ),
            SizedBox(height: 16),
            Text(
              "Welcome to Brobrain!",
              style: TextFontStyle.textStyle16InterW700,
            ),
            SizedBox(height: 8),
            Text(
              "By using our app, you agree to the following terms and conditions. Please read them carefully.",
              style: TextFontStyle.textStyle14InterW400
                  .copyWith(color: Colors.white60),
            ),
            SizedBox(height: 16),
            Text("1. Account Responsibilities",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
              "You must provide accurate information during registration and keep your account details secure. You are responsible for all activities under your account.",
              style: TextFontStyle.textStyle14InterW400
                  .copyWith(color: Colors.white60),
            ),
            SizedBox(height: 12),
            Text("2. Use of Services",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "Brobrain is designed for personal use only. You may not resell, misuse, or engage in unauthorized activities within the app.",
              style:   TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("3. Purchases & Payments",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "All purchases made through Brobrain must comply with our payment policies. We currently use secure third-party services (e.g., Stripe) to process transactions.",
              style:   TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("4. Limitations",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "Brobrain is not responsible for issues caused by third-party vendors, gift partners, or delivery services. We only facilitate the process between you and our partners.",
              style:   TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 12),
            Text("5. Termination",
              style: TextFontStyle.textStyle16InterW700,),
            SizedBox(height: 4),
            Text(
                "We reserve the right to suspend or terminate your account if you violate these terms of use.",
              style:   TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
            SizedBox(height: 20),
            Center(
                child: Text("App version 2.5.0",
                    style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}
