import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_colors.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_fonts.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_icons.dart';
import 'package:kashirons_flutter/assets_helperfdg/app_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_app_bar.dart';
import 'package:kashirons_flutter/common_widgets/custom_shimmer_image.dart';
import 'package:kashirons_flutter/common_widgets/custom_text_field.dart';
import 'package:kashirons_flutter/common_widgets/expandabl_text.dart';
import 'package:kashirons_flutter/feature/brobrain_gift_list/widget/product_card.dart';
import 'package:kashirons_flutter/feature/settings/widget/order_history_card.dart';
import 'package:kashirons_flutter/helpers/ui_helpers.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBg,
      body: SafeArea(
        child: Column(
          children: [
            /// App Bar
            CustomAppBar(
              title: "Order Details",
            ),
            UIHelper.verticalSpace(16.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [


                      ///>>>>>>>>>>>>>>>>>>> here is order info card >>>>>>>>>>>>>>>>>>>>>>>

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text("Order Info",style: TextFontStyle.textStyle16InterW700,textAlign: TextAlign.start,),
                            Divider(height: 20,color: Colors.white,),
                            OrderDetailsCardRow(leftText: "Order ID",rightText: "Classic Cuts Barber Shop", ),
                            OrderDetailsCardRow(leftText: "Order Date",rightText: "Jernome Bell", ),
                            OrderDetailsCardRow(leftText: "Delivery Address",rightText: "123 main rode, Mirpor, Dhaka", ),
                            OrderDetailsCardRow(leftText: "Phone number",rightText: "+8801324567890", ),
                            UIHelper.verticalSpace(8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width:120.w,child: Text("Delivery Status",style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),)),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                  decoration: ShapeDecoration(
                                    color: const Color(0x14EA7B0C),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),child: Text("Pending",style: TextFontStyle.textStyle12InterW400.copyWith(color: Color(0xFFEA7B0C)),),
                                )
                              ],
                            ),

                          ],
                        ),
                      ),
                      UIHelper.verticalSpace(16.h),
                      ///>>>>>>>>>>>>>>>>>>>>>>>>> here is gift item >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Gift Items",style: TextFontStyle.textStyle16InterW700,textAlign: TextAlign.start,),
                          Divider(height: 20,color: Colors.white,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ShimmerImage(imageUrl: personImageUrl, placeholder: AppImages.placeholderImageItem, height: 56.h, width: 72.w),
                              UIHelper.verticalSpace(16.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Smart Watch",style: TextFontStyle.textStyle16InterW400,),
                                  SizedBox(
                                      width:220,child: Column(
                                        children: [
                                          ExpandableText(text: "Stay connected and active with this stylish Smart Watch. Track fitness, monitor heart rate and sle Stay connected and active with this stylish Smart Watch. Track fitness, monitor heart rate ",trimLength: 100,),
                                          UIHelper.verticalSpace(8.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Qty:1",style: TextFontStyle.textStyle14InterW400.copyWith(color: Color(0xFFEF233C)),),
                                              Text("\$24.00",style: TextFontStyle.textStyle14InterW400.copyWith(color: Color(0xFFEF233C)),)
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                  

                                ],
                              ),


                            ],
                          )

                        ],
                      ),
                      ),

                      UIHelper.verticalSpace(16.h),
                      ///>>>>>>>>>>>>>>>>>>> here is Payment Summary card >>>>>>>>>>>>>>>>>>>>>>>

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2D3142),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text("Payment Summary",style: TextFontStyle.textStyle16InterW700,textAlign: TextAlign.start,),
                            Divider(height: 20,color: Colors.white,),
                            OrderDetailsCardRow(leftText: "Subtotal",rightText: "\$24.00", ),
                            OrderDetailsCardRow(leftText: "VAT", rightText: "\$09.60", ),
                            OrderDetailsCardRow(leftText: "Shipping",rightText: "\$00.00", ),
                            OrderDetailsCardRow(leftText: "Total payment amount",rightText: "\$33.60",rightTextWeight: 120.00, ),
                            UIHelper.verticalSpace(8.h),

                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}

class OrderDetailsCardRow extends StatelessWidget {
  const OrderDetailsCardRow({
    super.key, required this.leftText, required this.rightText, this.rightTextWeight,
  });
  final String leftText;
  final String rightText;
  final dynamic rightTextWeight ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftText,style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white60),),
          SizedBox( width:rightTextWeight??190, child: Text(textAlign: TextAlign.right,rightText,style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white),)),
        ],
      ),
    );
  }
}
