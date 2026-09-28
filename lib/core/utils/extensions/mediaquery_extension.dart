import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
//   Screen Dimenstions
 Size get screenSize => MediaQuery.of(this).size;
 double get screenWidth => screenSize.width;
 double get screenheight => screenSize.height;

//  Safe Area Padding
 EdgeInsets get safePadding => MediaQuery.of(this).padding;
 double get topPadding => safePadding.top;
 double get  bottomPadding => safePadding.bottom;
 double get leftPadding => safePadding.left;
 double get rightPadding => safePadding.right;

//  keyboard
 double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

//  Orientation
 Orientation get orientation => MediaQuery.of(this).orientation;
 bool get isPortrait => orientation == Orientation.portrait;
 bool get isLandscape => orientation == Orientation.landscape;

// Device Type By BreakPoint
 bool get isMobile  => screenWidth < 600;
 bool get isTablet => screenWidth >= 600  && screenWidth <1024;
 bool get isDesktop => screenWidth >= 1024;

//  Text scaling factor
 double get textScaleFactor => MediaQuery.of(this).textScaler.scale(1.0);

// Responsive Width/Height helpers (0.0 to 1.0)
 double widthPct(double percent) => screenWidth * percent;
 double heightPct(double percent) => screenheight * percent;

/// Scale text size based on screen size (optional base width: 375)
 double scaledFont (double size , {double baseWidth = 375}){
   return size * screenWidth / baseWidth;
 }

// Padding and margin helpers
 EdgeInsets responsivePadding({
  double horizontal = 0.0,
  double vertical = 0.0,
}) => EdgeInsets.symmetric(
  horizontal: screenWidth * horizontal,
  vertical: screenheight * vertical,
 );

 EdgeInsets responsiveAll(double value) => EdgeInsets.all(screenWidth * value);

// Minimum size constraint helper
  double minWidth(double min) => screenWidth <min ? min : screenWidth;
  double minHeight(double min) => screenheight <min  ? min : screenheight;
}