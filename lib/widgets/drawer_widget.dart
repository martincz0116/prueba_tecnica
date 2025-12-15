import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      surfaceTintColor: accentSecondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: accentSecondary),
            child: Text(
              'Menu',
              style: TextStyle(
                color: textColor,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Api List',
              style: TextStyle(color: textColor, fontSize: 20.sp),
            ),
            trailing: Icon(Icons.home, color: textColor),
            onTap: () => context.go('/api-list'),
          ),
          ListTile(
            title: Text(
              'Prefs',
              style: TextStyle(color: textColor, fontSize: 20.sp),
            ),
            trailing: Icon(Icons.bookmark, color: textColor),
            onTap: () => context.go('/prefs'),
          ),
        ],
      ),
    );
  }
}