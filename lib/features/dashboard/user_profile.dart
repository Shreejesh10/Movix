import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recommender/common_widgets/custom_app_bar.dart';
import '../../core/route_config/route_names.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int index = 3;
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home,size: 30,color: index == 0 ? Colors.red: Color.fromRGBO(121, 116, 126, 1.0)),
      Icon(Icons.list,size: 30,color: index == 1 ? Colors.red: Color.fromRGBO(121, 116, 126, 1.0)),
      Icon(
        Icons.graphic_eq_outlined,
        size: 30,
        color: index == 2 ? Colors.red : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(Icons.person,size: 30,color: index == 3 ? Colors.red: Color.fromRGBO(121, 116, 126, 1.0)),


    ];
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(title: "My Profile"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                _profile(),
              ],
            ),
          ),

          _editProfileButton('Edit Profile',
              Icons.mode_edit_outline_outlined,
              (){
            //For On Tap
              }
          ),
          _editProfileButton('Content Preference',
              Icons.menu_book_outlined,
                  (){
            Navigator.pushNamed(context, RouteName.onboardingScreen);
              }
          ),
          _editProfileButton('Log out',
              Icons.exit_to_app,
                  (){
                Navigator.pushNamed(context, AuthRouteName.loginScreen);
              }
          ),

        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65.h,
        index: index,
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(35, 35, 35, 1.0),
        buttonBackgroundColor:Color.fromRGBO(35, 35, 35, 1.0),
        animationDuration: Duration(milliseconds: 400),

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
              Navigator.pushNamed(context, RouteName.userDashboardScreen);
              break;
            case 3:

              break;
            default:
            // Do nothing or stay on home
          }
        },
      ),

    );

  }
  Widget _profile() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:AssetImage('assets/images/Spidermanpp.jpg'),
                  fit: BoxFit.cover
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            "Shreejesh Pathak",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "shreejeshpathak@gmail.com",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  Widget _editProfileButton(String text, IconData icon, VoidCallback onTap, ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width:350.sp,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.red,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              icon,
              color: Colors.grey[600],
              size: 30.sp,
            ),
          ],
        ),
      ),
    );
  }
}
