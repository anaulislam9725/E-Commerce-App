import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialContainer extends StatelessWidget {
  final Image image;
  final void Function()? onTap;
  const SocialContainer({super.key, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30.r),
        onTap: onTap,
        child: Ink(
          height: 60.h,
          width: 60.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: BoxBorder.all(color: Colors.grey, width: 1.5),
          ),
          child: Padding(padding: EdgeInsets.all(10.h), child: image),
        ),
      ),
    );
  }
}
