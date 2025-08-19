import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:Movix/common_widgets/custom_app_bar.dart';
import 'package:Movix/core/route_config/route_names.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final Map<String, double> topWatchedGenresMap = {
    "Action": 12,
    "Comedy": 8,
    "Thriller": 5,
  };

  final List<Color> topGenreColors = const [
    Colors.red,
    Colors.green,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Admin Dashboard",
            style: TextStyle(color: Colors.grey, fontSize: 25.sp),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.grey, size: 30),
              onPressed: () {
                Navigator.pushNamed(context, AuthRouteName.loginScreen);
              },
            ),
          ],
        ),

        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👤 Profile Row
                Row(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/Rajeshdai.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Hi,\nAdmin Shreejesh',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // 🧾 Info Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoCard("Total Users", '1'),
                    SizedBox(width: 16.w),
                    _infoCard("Total Watched Movies", '1'),
                  ],
                ),
                SizedBox(height: 16.h),
                _infoCard("Most Watched Movie", 'Superman', fullWidth: true),
                SizedBox(height: 24.h),

                // 📊 Pie Chart Section
                Text(
                  'Top 3 Watched Genres',
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey[300]),
                ),
                SizedBox(height: 16.h),
                PieChart(
                  dataMap: topWatchedGenresMap,
                  colorList: topGenreColors,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 10,
                  chartRadius: 150.w,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    chartValueStyle: TextStyle(color: Colors.black),
                  ),
                  legendOptions: const LegendOptions(showLegends: false),
                ),
                SizedBox(height: 20.h),

                // 🎯 Custom Legend
                Wrap(
                  spacing: 20.w,
                  runSpacing: 10.h,
                  children: [
                    _buildLegendDot('Action', Colors.red),
                    _buildLegendDot('Comedy', Colors.green),
                    _buildLegendDot('Thriller', Colors.cyan),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ➕ Floating Action Button
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.addMovieScreen);
          },
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add, size: 30, color: Colors.white),
          label: const Text(
            'Add Movies',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, {bool fullWidth = false}) {
    return Container(
      margin: fullWidth ? EdgeInsets.only(top: 8.h) : EdgeInsets.zero,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
      mainAxisSize: MainAxisSize.min,
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
