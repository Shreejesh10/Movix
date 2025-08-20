import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Movix/common_widgets/custom_app_bar.dart';
import '../../core/route_config/route_names.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  int index = 2;
  String userName = '';

  final Map<String, double> dataMap = {
    "Watched": 5,
    "Watching": 2,
    "Planned": 3,
  };

  final List<Color> colorList = [Colors.red, Colors.green, Colors.cyan];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.displayName != null) {
      userName = user.displayName!;
    } else {
      userName = 'User'; // fallback if name is not set
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
        color: index == 0
            ? Colors.red
            : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.list,
        size: 30,
        color: index == 1
            ? Colors.red
            : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.graphic_eq_outlined,
        size: 30,
        color: index == 2
            ? Colors.red
            : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.person,
        size: 30,
        color: index == 3
            ? Colors.red
            : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: "Analytics"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Row
            Row(
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Spidermanpp.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  'Hi,\n$userName',
                  style: TextStyle(fontSize: 22.sp, color: Colors.grey[300]),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Info cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard("Time Watched", '0m'),
                _infoCard('Total Movie Watched', '0'),
              ],
            ),
            SizedBox(height: 16.h),

            _infoCard("Total Planned to Watch Movies", "0", fullWidth: true),

            SizedBox(height: 24.h),

            // Pie chart with legend
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: const Duration(milliseconds: 800),
                    chartRadius: 130.w,
                    colorList: colorList,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 14,
                    legendOptions: const LegendOptions(showLegends: false),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendDot("Watched", Colors.red),
                      _buildLegendDot("Watching", Colors.green),
                      _buildLegendDot("Planned", Colors.cyan),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65.h,
        index: index,
        backgroundColor: Colors.transparent,
        color: const Color.fromRGBO(35, 35, 35, 1.0),
        buttonBackgroundColor: const Color.fromRGBO(35, 35, 35, 1.0),
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
            case 3:
              Navigator.pushNamed(context, RouteName.profileScreen);
              break;
          }
        },
      ),
    );
  }

  Widget _infoCard(String title, String value, {bool fullWidth = false}) {
    return Container(
      margin: fullWidth ? EdgeInsets.only(top: 8.h) : EdgeInsets.zero,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.red,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 6.w),
        Text(
          title,
          style: TextStyle(color: Colors.grey[300], fontSize: 12.sp),
        ),
      ],
    );
  }
}
