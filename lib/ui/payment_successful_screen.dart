import 'dart:math';

import 'package:e_commerce_app/const/dimension.dart';
import 'package:e_commerce_app/const/text_size.dart';
import 'package:e_commerce_app/ui/bottom_nav_screen.dart';
import 'package:e_commerce_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:confetti/confetti.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  static final String path = "PaymentSuccessfulScreen";

  const PaymentSuccessfulScreen({super.key});

  @override
  State<PaymentSuccessfulScreen> createState() =>
      _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();
    _centerController = ConfettiController(
      duration: const Duration(seconds: 15),
    );
    _centerController.play();
  }

  @override
  void dispose() {
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: AppDimansions.kDefaultPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.center,
                child: ConfettiWidget(
                  confettiController: _centerController,
                  blastDirection: pi / 2,
                  maxBlastForce: 5,
                  minBlastForce: 1,
                  emissionFrequency: 0.03,
                  numberOfParticles: 10,
                  gravity: 0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Image.asset("assets/success.gif"),
              ),
              Text(
                "Payment Successful!",
                style: Styles.mediumTitle.copyWith(
                  color: Colors.green,
                  fontSize: 32.sp,

                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 200.h),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, BottomNavScreen.path);
                },
                width: 200.w,
                text: "Back to home",
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}
