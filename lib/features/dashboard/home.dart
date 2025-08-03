import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:recommender/common_widgets/custom_app_bar.dart';
import 'package:recommender/common_widgets/genre_selection.dart';
import 'package:recommender/core/route_config/route_names.dart';
import '../../common_widgets/custom_search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(
        Icons.home,
        size: 30,
        color: index == 0 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.list,
        size: 30,
        color: index == 1 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.graphic_eq_outlined,
        size: 30,
        color: index == 2 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0),
      ),
      Icon(
        Icons.person,
        size: 30,
        color: index == 3 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0),
      ),
    ];

    return PopScope(
      canPop:false,
      child: Scaffold(
        extendBody: true,
        appBar: const CustomAppBar(title: 'Explore'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  children: [
                    SearchFilterBar(),
                    SizedBox(height: 15.h),
                    GenreSelector(),
                    SizedBox(height: 15.h),
                    _content('Recommended For You'),
                  ],
                ),
              ),

              // Recommended movies scroll
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15.w),
                child: Row(
                  children: [
                    _movieList('assets/images/Movie Poster/F1.jpg', 'F1', 'Action/Sport', '8.5'),
                    _movieList('assets/images/Movie Poster/SpiderMan.png', 'Spider-Man: Into the Spider-Verse', 'Animation/Action', '8.4'),
                    _movieList('assets/images/Movie Poster/Pulp Fiction.png', 'Pulp Fiction', 'Crime/Drama', '8.9'),
                    _movieList('assets/images/Movie Poster/Forestgump.jpg', 'Forrest Gump', 'Drama/Romance', '8.8'),
                    _movieList('assets/images/Movie Poster/pandorum.jpg', 'Pandorum', 'Horror/Sci-fi', '6.7'),
                    _movieList('assets/images/Movie Poster/Shawshank.jpg', 'The Shawshank Redemption', 'Drama/Prison', '9.3'),
                    _movieList('assets/images/Movie Poster/ted.png', 'Ted', 'Comedy/Fantasy', '6.9'),
                    _movieList('assets/images/Movie Poster/romeo.png', 'Romeo + Juliet', 'Drama/Romance', '6.8'),

                  ],
                ),
              ),

              // Being Watched section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: _content('Being Watched Right Now'),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15.w),
                child: Row(
                  children: [
                    _movieList('assets/images/Movie Poster/romeo.png', 'Romeo + Juliet', 'Drama/Romance', '6.8'),
                    _movieList('assets/images/Movie Poster/Pulp Fiction.png', 'Pulp Fiction', 'Crime/Drama', '8.9'),
                    _movieList('assets/images/Movie Poster/pandorum.jpg', 'Pandorum', 'Horror/Sci-fi', '6.7'),
                    _movieList('assets/images/Movie Poster/Forestgump.jpg', 'Forrest Gump', 'Drama/Romance', '8.8'),
                    _movieList('assets/images/Movie Poster/SpiderMan.png', 'Spider-Man: Into the Spider-Verse', 'Animation/Action', '8.4'),
                    _movieList('assets/images/Movie Poster/F1.jpg', 'F1', 'Action/Sport', '8.5'),
                    _movieList('assets/images/Movie Poster/Shawshank.jpg', 'The Shawshank Redemption', 'Drama/Prison', '9.3'),

                  ],
                ),
              ),

              SizedBox(height: 70.h),
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
                break;
              case 1:
                Navigator.pushNamed(context, RouteName.listScreen);
                break;
              case 2:
                Navigator.pushNamed(context, RouteName.userDashboardScreen);
                break;
              case 3:
                Navigator.pushNamed(context, RouteName.profileScreen);
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _content(String text) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.viewallScreen);
          },
          child: Text(
            'View all',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFF383C),
            ),
          ),
        ),
      ],
    );
  }

  Widget _movieList(String imagePath, String title, String genre, String imdb) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      height: 260.h,
      width: 140.w,
      decoration: BoxDecoration(
        color: const Color(0x3B545454),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(context, RouteName.movieDetailScreen);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: 180.h,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 4.w),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 4.w),
              child: Text(
                genre,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 6.w, top: 2.w),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[700], size: 15.sp),
                  SizedBox(width: 4.w),
                  Text(
                    imdb,
                    style: TextStyle(
                      color: Colors.yellow[700],
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
