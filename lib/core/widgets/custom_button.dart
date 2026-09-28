
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/constant/style/app_fonts.dart';
import 'package:app_munafa_job/core/localization/app_localization.dart';
import 'package:app_munafa_job/core/utils/extensions/mediaquery_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class   CustomButton extends StatelessWidget{
   final String title;
   final VoidCallback? onTap;
   final double? height;
   final double borderRadius;
   final Color backgroundColor;
   final Gradient? gradient;

   const CustomButton({
     super.key,
     required this.title,
     required this.onTap,
     this.height,
     this.borderRadius = 15,
     required this.backgroundColor,
     this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color:gradient == null
               ? (backgroundColor ??  AppColors.primaryColors)
               : null,
          border: Border.all(color: AppColors.primaryColors),
          gradient: gradient,
        ),
        child: InkWell(
          borderRadius:BorderRadius.circular(
            borderRadius,
          ),  // ripple respects corners
          onTap: onTap,
          child: Container(
            width: context.screenWidth,
            height: height ?? context.heightPct(0.06),
            alignment: Alignment.center,
            child: Text(
              AppLocalization.of(context)?.translate(title) ?? title,
              style: TextStyle(
                fontFamily: AppFonts.primaryFont,
                fontSize: context.scaledFont(18),
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ),
        ),

      ),
    );
  }

}