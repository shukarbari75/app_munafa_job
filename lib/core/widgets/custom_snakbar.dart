import 'dart:io';
import 'package:app_munafa_job/core/config/global_manger.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class  CustomSnakbar{
   static void show({
    required String message,
     Color backgroundColor = Colors.black87,
     IconData? icon,
     Color? iconColor,
     Duration duration = const Duration(seconds: 2),
  }) {
    var context = GlobalManger.instance.navigatorKey.currentContext;
     if(context == null)return;

     if (Platform .isIOS) {
       _showIOSSnackbar(
         context : context,
         message : message,
         backgroundColor: backgroundColor,
         icon : icon,
         iconColor : iconColor,
         duration: duration
       );
     }else {
       _showAndroidSnackbar(
         context : context,
         message : message,
         backgroundColor: backgroundColor,
         icon: icon,
         iconColor: iconColor,
         duration: duration,
       );
     }
  }


   // ─── Android: Material SnackBar ───────────────────────────────────────────

  static void _showAndroidSnackbar({
      required BuildContext  context,
      required String message,
      required Color backgroundColor,
      IconData? icon,
      Color? iconColor,
      required Duration duration,
  }) {
     final scaffoldMessenger = ScaffoldMessenger.of(context);

     final snackBar = SnackBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         duration: duration,
         behavior: SnackBarBehavior.floating,
         margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
         content: Container(
           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
           decoration: BoxDecoration(
             color: backgroundColor,
             borderRadius: BorderRadius.circular(10),
             boxShadow: const[
               BoxShadow(
                 color: Colors.black26,
                 blurRadius: 6,
                 offset: Offset(0, 2)
               )
             ]
           ),
           child: Row(
             children: [
               if (icon  != null)...[
                 Icon(icon, color: iconColor  ??  Colors.white),
                 const SizedBox(width: 12),
               ],
               Expanded(
                 child: Text('message',style: TextStyle(color: Colors.white,fontSize: 15),
                 ),
               ),
               GestureDetector(
                 onTap: () => scaffoldMessenger.hideCurrentSnackBar(),
                 child: Icon(Icons.close, color: Colors.white),
               ),
             ],
           ),
         ),
     );

      scaffoldMessenger
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

  }


 // ─── iOS: Cupertino-style Overlay ─────────────────────────────────────────

   static OverlayEntry? _iosOverlayEntry;

   static void _showIOSSnackbar({
       required BuildContext context,
       required String message,
       required Color backgroundColor,
       IconData? icon,
       Color? iconColor,
       required Duration duration,

   }) {
     // Remove existing overlay if showing
     _iosOverlayEntry?.remove();
     _iosOverlayEntry = null;

     _iosOverlayEntry = OverlayEntry(
         builder: (context) => _IOSSnackbarOverlay(
           message: message,
           backgroundColors: backgroundColor,
           icon : icon,
           iconColors : iconColor,
           onDismiss: (){
             _iosOverlayEntry?.remove();
             _iosOverlayEntry = null;
           },
         ),
     );

     final overlay = GlobalManger.instance.navigatorKey.currentState?.overlay;
     if (overlay != null) {
       overlay.insert(_iosOverlayEntry!);
     }
     // Auto-dismiss after duration
     Future.delayed(duration, (){
       _iosOverlayEntry?.remove();
       _iosOverlayEntry = null;
     });
   }
 }

  // ─── iOS Overlay Widget ──────

  class _IOSSnackbarOverlay extends StatefulWidget {
    final String message;
    final Color backgroundColors;
    final IconData? icon;
    final Color? iconColors;
    final VoidCallback onDismiss;

    const _IOSSnackbarOverlay({
      required this.message,
      required this.backgroundColors,
      required this.icon,
      required this.iconColors,
      required this.onDismiss,
    });

    @override
    State<_IOSSnackbarOverlay>createState() =>
        _IOSSnackbarOverlayaState();
  }

  class _IOSSnackbarOverlayaState  extends State<_IOSSnackbarOverlay>
         with SingleTickerProviderStateMixin {
     late AnimationController _controller;
     late Animation<Offset> _slideAnimation;
     late Animation<double> _fadeAnimation;

     @override
     void initState(){
       super.initState();

        _controller = AnimationController(
          duration: const Duration(milliseconds: 350),
          vsync: this,
        );

       // Slides down from top (iOS style)
         _slideAnimation = Tween<Offset>(
         begin: const Offset(0, -1),
         end: Offset.zero,
       ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

         _fadeAnimation = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

         _controller.forward();
     }
     @override
      void dispose() {
        _controller.dispose();
        super.dispose();
      }

     @override
       Widget build(BuildContext context){
       final topPadding  = MediaQuery.of(context).padding.top;

       return Positioned(
         top:  topPadding + 12,
          left: 16,
          right:  16,
        child: SlideTransition(
          position: _slideAnimation,
            child: FadeTransition(
              opacity:_fadeAnimation,
               child: Material(
                 color: Colors.transparent,
                 child: CupertinoPopupSurface(
                   isSurfacePainted: false,
                  child: Container(
                   padding: EdgeInsets.symmetric(
                       horizontal: 16,
                       vertical: 12,
                   ),
                    decoration: BoxDecoration(
                     color:widget.backgroundColors.withValues( alpha: 0.95),
                      borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                       ),
                    ],
                   ),
                   child: Row(
                      children: [
                      if(widget.icon != null)...[
                        Icon(
                          widget.icon,
                          color: widget.iconColors ??  CupertinoColors.white,
                          size:  22,
                        ),
                        const SizedBox(width: 10),
                          Expanded(child: Text(
                            widget.message,
                              style: TextStyle(color: CupertinoColors.white,
                              fontSize: 15,
                              fontFamily: '.SF Pro Text',    // iOS system font
                              decoration: TextDecoration.none,
                           ),
                        )),
                        GestureDetector(
                          onTap: widget.onDismiss,
                          child: const Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: CupertinoColors.systemGrey,
                            size: 20,
                          ),
                        ),
                      ],
                     ],
                   ),


                   ),
                 ),

             ),
           ),
          ),
         );



       }





    }

       
  

