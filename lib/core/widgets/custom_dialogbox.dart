

// =====================================================
// COMMON CUSTOM CONFIRM DIALOG
// Same UI on iOS + Android
// =====================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/colors/app_colors.dart';

Future<void> showProfessionalDialog({
   required BuildContext context,
   required String title,
   required String message,
   required VoidCallback onConfirm,
   String confirmText = "Yes",
   String cancelText = "Cancel",
  VoidCallback? onCancel,
  IconData icon = Icons.logout,
}) async {
   await  showGeneralDialog(
       context: context,
       barrierDismissible: true,
       barrierLabel: "Dismiss",
       barrierColor: Colors.black54,
       transitionDuration:
          const Duration(milliseconds: 250),
       pageBuilder: (_, _, _) {
         return const SizedBox.shrink();
       },
       transitionBuilder:
           (context, animation, secondaryAnimation, child) {
             final curved = Curves.easeOutBack.transform(
               animation.value,
             );

             return Transform.scale(
               scale: curved,
               child: Opacity(
                 opacity: animation.value,
                 child: _CommonCustomDialog(
                   title: title,
                   message: message,
                   icon: icon,
                   confirmText: confirmText,
                   cancelText: cancelText,
                   onConfirm: onConfirm,
                   onCancel: onCancel,
                 ),
               ),
             );
           }
   );
}

// =====================================================
// COMMON DIALOG UI
// =====================================================


class _CommonCustomDialog extends StatelessWidget {
    final String title;
    final String message;
    final VoidCallback onConfirm;
    final VoidCallback? onCancel;
   final String confirmText;
   final String cancelText;
   final IconData icon;

   const _CommonCustomDialog({
   required this.title,
   required this.message,
    required this.onConfirm,
    this.onCancel,
    required this.confirmText,
    required this.cancelText,
    required this.icon,
   });
    @override
    Widget build(BuildContext context) {
      final isMobile =
          MediaQuery.of(context).size.width < 600;

      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: isMobile
                ? MediaQuery.of(context).size.width * 0.85
                : 400,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardSecondary,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.25,
                  ),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Icon
                Container(
                  padding:
                  const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColors
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryColors,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [

                    // Cancel
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onCancel?.call();
                        },
                        style:
                        OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                          ),
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Confirm
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.primaryColors,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                          ),
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          confirmText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
}

// =====================================================
// COMMON CUSTOM CONTENT DIALOG
// Same UI on iOS + Android
// =====================================================

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required String title,
  required Widget content,
  required VoidCallback onConfirm,
  String confirmText = "Save",
  String cancelText = "Cancel",
  VoidCallback? onCancel,
  IconData icon = Icons.person_add,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    barrierColor: Colors.black54,
    transitionDuration:
    const Duration(milliseconds: 250),
    pageBuilder: (_, _, _) {
      return const SizedBox.shrink();
    },
    transitionBuilder:
        (context, animation, secondaryAnimation, child) {
      final curved = Curves.easeOutBack.transform(
        animation.value,
      );

      return Transform.scale(
        scale: curved,
        child: Opacity(
          opacity: animation.value,
          child: _CommonCustomContentDialog(
            title: title,
            content: content,
            icon: icon,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
          ),
        ),
      );
    },
  );
}



// =====================================================
// COMMON CONTENT DIALOG UI
// =====================================================

class _CommonCustomContentDialog
    extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  final IconData icon;

  const _CommonCustomContentDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    this.onCancel,
    required this.confirmText,
    required this.cancelText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < 600;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile
              ? MediaQuery.of(context).size.width * 0.90
              : 420,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardSecondary,
            borderRadius:
            BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(
                icon,
                size: 36,
                color: AppColors.primaryColors,
              ),

              const SizedBox(height: 12),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Custom content
              content,

              const SizedBox(height: 24),

              Row(
                children: [

                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onCancel?.call();
                      },
                      child: Text(cancelText),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.primaryColors,
                      ),
                      child: Text(
                        confirmText,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}