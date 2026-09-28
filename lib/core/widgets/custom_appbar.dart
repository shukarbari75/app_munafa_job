

import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/constant/style/app_fonts.dart';
import 'package:app_munafa_job/core/widgets/custom_statusbar.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String? text;
  final Widget? title;
  final Widget? leading;
  final IconData? icon;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TabController? tabController;
  final List<Tab>? tab;

  const CustomAppbar({
    super.key,
    this.text,
    this.title,
    this.leading,
    this.icon,
    this.actions,
    this.backgroundColor,
    this.tabController,
    this.tab,
});

  @override
  Size get preferredSize {
    // Add extra height if tabs are provided
    final double tabHeight = (tab != null && tab!.isNotEmpty)
        ? kTextTabBarHeight
        : 0;
    return Size.fromHeight(kToolbarHeight + tabHeight);
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
           (isDark ? AppColors.screenBackground : AppColors.primaryColors);
    final testColor = isDark ? AppColors.white : AppColors.white;
    final iconColor = isDark ? AppColors.white : AppColors.white;

    AppStatusBar.setStatusBar();

    return AppBar(
      iconTheme: IconThemeData(color:iconColor),
      elevation: 0,
      shadowColor: AppColors.shadowColor,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 1,
      backgroundColor: bgColor,
      leading: leading,
      title:
            title ??
            Text(
              text ?? '',
              style: TextStyle(
                fontFamily: AppFonts.primaryFont,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color:testColor,
              ),
            ),
      centerTitle: true,
      actions: actions,
      bottom: (tab != null &&  tab!.isNotEmpty && tabController != null)
        ?TabBar(
          controller: tabController,
          tabs: tab!,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3.5,
          indicatorColor: AppColors.primaryColors,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 3.5,
              color: AppColors.primaryColors,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withValues(alpha: 0.5),
          labelStyle: const TextStyle(
              fontSize: 14,
             fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
          dividerColor: Colors.transparent,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
      )
       : null,
    );


  }

}