import 'package:flutter/material.dart';

class GlobalManger {
  // Private constructor (singleton)
  GlobalManger._();
  static final GlobalManger instance = GlobalManger._();


 // -------- App States --------
 bool isUserLoggedIn = false;
 String? authToken;
 String? currentUserId;

// -------- Preferences --------
 String  currentLanguage = "en";

// -------- Feature Flags --------
 bool enableLogging = true;

// Reset all globals (useful on logout)
 void reset(){
   isUserLoggedIn = false;
   authToken = null;
   currentUserId = null;
   currentLanguage = "en";
   enableLogging = true;
 }

//  keys
  final GlobalKey<NavigatorState>  navigatorKey = GlobalKey<NavigatorState>();
}