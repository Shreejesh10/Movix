import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onMenuTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.w600,
          color: const Color.fromRGBO(173, 173, 173, 1.0),
        ),
      ),
      actions: [
        IconButton(
          onPressed: onNotificationTap ?? () {},
          icon: Icon(
            Icons.notifications_none,
            size: 35.sp,
            color: const Color.fromRGBO(173, 173, 173, 1.0),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
