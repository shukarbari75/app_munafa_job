
import 'package:flutter/material.dart';

class AppColors {
//   Brand & UI theme
static const Color appBarColor = Color(0xFF16324F);
static const Color statusBarColor = Color(0xFF16324F);
static const Color primaryColors = Color(0xFFA6521A);
static const Color gradientStar = Color(0xFFC97B3D);
static const Color gradientEnd = Color(0xFF7A3B12);
static const Color white = Color(0xFFFFFFFF);
static const Color black = Color(0xFF16324F);
static const Color bottomNavBackGround = Color(0xFFFFFFFF);
static const Color selectedNavItem = Color(0xFFA6521A);
static const Color unSelectedNavItem = Color(0xFF9AA7B0);
static const Color profitBadgeBg = Color(0xFF00C853);
static const Color greyHeading = Color(0xFF4A6178);

// Backgrounds
static const Color screenBackground = Color(0xFFEDEEEA);
static const Color cardBackground = Color(0xFFFFFFFF);
static const Color cardSecondary = Color(0xFFF3EFE7);
static const Color dialogBackground = Color(0xFFF0F1ED);

// Text
static const Color textHeading = Color(0xFF16324F);
static const Color textBody = Color(0xFF3A4A57);
static const Color textHint = Color(0xFF9AA7B0);
static const Color iconGrey = Color(0xFF9AA7B0);
static const Color secondaryText = Color(0xFF6B7B87);
static const Color textOnPrimary = Color(0xFFFFFFFF);
static const Color textSlogan =  Color(0xFF8C8577);

// Status Colors
static const Color success = Color(0xFF3C6E4F);
static const Color green = Color(0xFF3C6E4F);
static const Color yellow = Color(0xFFC98A2B);
static const Color warning = Color(0xFFC98A2B);
static const Color error = Color(0xFFA83232);
static const Color red = Color(0xFFA83232);
static const Color info = Color(0xFF2C5680);
static const Color orange = Color(0xFFA6521A);

//  Borders & Dividers
static const Color borderColor = Color(0xFFC5C9C2);
static const Color dividerColor = Color(0xFFDEE0DA);
static const Color customerGeryColor = Color(0xFFD3D6CE);

//  Buttons
static const Color buttonPrimary = Color(0xFFA6521A);
static const Color buttonText = Color(0xFFFFFFFF);
static const Color buttonDisabled = Color(0xFFC5C9C2);

// Icons
static const Color iconActive = Color(0xFFFFFFFF);
static const Color iconInactive = Color(0xFF9AA7B0);

// Shadows
static const Color shadowColor = Color(0x1A16324F);

// Reusable Gradient Objects
 static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStar , gradientEnd]
);

 static const LinearGradient topGradient = LinearGradient(
  begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientEnd , gradientStar]
);

  static const LinearGradient bottomGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end  :  Alignment.topCenter,
    colors: [gradientEnd , gradientStar]
);

  static const LinearGradient lrGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientEnd, gradientStar],
  );


}