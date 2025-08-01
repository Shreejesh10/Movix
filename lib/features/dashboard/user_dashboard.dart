import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recommender/common_widgets/custom_app_bar.dart';

import '../../core/route_config/route_names.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
        color: index == 0 ? Colors.red : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.list,
        size: 30,
        color: index == 1 ? Colors.red : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.graphic_eq_outlined,
        size: 30,
        color: index == 2 ? Colors.red : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.person,
        size: 30,
        color: index == 3 ? Colors.red : const Color.fromRGBO(121, 116, 126, 1.0),
      ),

    ];
    return Scaffold(
      appBar: const CustomAppBar(title: "Analytics"),
      body: const Column(

      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65.h,
        index: index,
        backgroundColor: Colors.transparent,
        color: const Color.fromRGBO(35, 35, 35, 1.0),
        buttonBackgroundColor:const Color.fromRGBO(35, 35, 35, 1.0),
        animationDuration: const Duration(milliseconds: 400),

        items: items,
        onTap: (newIndex) {
          setState(() => index = newIndex);

          switch (newIndex) {
            case 0:
              Navigator.pushNamed(context, RouteName.homeScreen);
              break;
            case 1:
              Navigator.pushNamed(context, RouteName.listScreen);
              break;
            case 2:

              break;
            case 3:
              Navigator.pushNamed(context, RouteName.profileScreen);
              break;
            default:
            // Do nothing or stay on home
          }
        },
      ),
    );

  }
}
