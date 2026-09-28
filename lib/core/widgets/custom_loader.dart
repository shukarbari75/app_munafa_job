

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors/app_colors.dart';

class CustomLoader extends StatelessWidget {
   final String? loadingText;

   const CustomLoader({super.key, this.loadingText});

@override
Widget build(BuildContext context) {
      return Stack(
      children: [
  // Dim background overlay
      Positioned.fill(
          child: Container(color: Colors.black.withValues(alpha: 0.25)),
     ),
   // Center loader
         Center(
            child: Platform.isAndroid
                 ? _androidLoader(loadingText: loadingText)
                 : _iosLoader(context, loadingText: loadingText),
         ),
      ],
    );
 }

Widget _androidLoader({String? loadingText}) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
        BoxShadow(
          color: Colors.black26,
           blurRadius: 12,
           offset: Offset(0, 6),
        ),
      ],
   ),
     child: Column(
          mainAxisSize: MainAxisSize.min,
     children: [
     Stack(
        alignment: Alignment.center,
         children: [
            SizedBox(
                width: 40,
                 height: 40,
              child: CircularProgressIndicator(
                 strokeWidth: 3,
                 color: AppColors.primaryColors,
              ),
            ),
         ],
     ),
          if (loadingText != null) ...[
            const SizedBox(height: 12),
             Text(
                  loadingText,
                   style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColors,
                   ),
             ),
          ],
       ],
     ),
   );
 }


// Widget _iosLoader(BuildContext context, {String? loadingText}) {
//   final String? text = loadingText;

//   return Center(
//     // <-- Ensures perfect centering
//     child: TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.9, end: 1.0),
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeOutBack,
//       builder: (context, scale, child) =>
//           Transform.scale(scale: scale, child: child),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: Container(
//             width: 90,
//             height: text != null ? 110 : 90,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(
//                 0.15,
//               ), // <-- Correct iOS blur look
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 12,
//                   offset: Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CupertinoActivityIndicator(
//                   radius: 16,
//                   color: AppColors.primaryColor,
//                 ),
//                 if (text != null) ...[
//                   const SizedBox(height: 12),
//                   Text(
//                     text,
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }


  Widget _iosLoader(BuildContext context, {String? loadingText}) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 85,
          height: loadingText != null ? 110 : 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),

            // Glass gradient (important for "premium look")
            color: AppColors.cardSecondary.withValues(alpha: .9),

            border: Border.all(
              color: AppColors.customerGeryColor.withValues(alpha: .15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(
                radius: 14,
                color: AppColors.primaryColors,
              ),

              if (loadingText != null) ...[
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    loadingText,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


// defult loader---------
class DefultLoader extends StatelessWidget {
  final double size;
  final Color color;

  const DefultLoader({
    super.key,
    this.size = 24.0,
    this.color = AppColors.primaryColors,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          backgroundColor: color.withValues(alpha: 0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}


// dot loader---------
class DotLoader extends StatefulWidget {
  const DotLoader({
    super.key,
    this.dotColor = AppColors.primaryColors,
    this.dotSize = 10.0,
    this.spacing = 6.0,
  });

  final Color dotColor;
  final double dotSize;
  final double spacing;

  @override
  State<DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<DotLoader>
     with SingleTickerProviderStateMixin {
     late AnimationController _controller;
     late Animation<double> _animation1;
     late Animation<double> _animation2;
     late Animation<double> _animation3;

  @override
  void initState() {
      super.initState();

        _controller = AnimationController(
             vsync: this,
             duration: const Duration(milliseconds: 1200),
        )..repeat();

         _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
            ),
         );
         _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                    parent: _controller,
                    curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
              ),
         );
         _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
               CurvedAnimation(
                     parent: _controller,
                     curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
               ),
         );

  }

     @override
     void dispose() {
         _controller.dispose();
          super.dispose();
     }


    Widget _buildDot(Animation<double> animation) {
      return ScaleTransition(
         scale: animation,
          child: Container(
               width: widget.dotSize,
              height: widget.dotSize,
             decoration: BoxDecoration(
                color: widget.dotColor,
                shape: BoxShape.circle,
            ),
          ),
      );
    }

     @override
     Widget build(BuildContext context) {
       return Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           _buildDot(_animation1),
           SizedBox(width: widget.spacing),
           _buildDot(_animation2),
           SizedBox(width: widget.spacing),
           _buildDot(_animation3),
         ],
       );
     }
}