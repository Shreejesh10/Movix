import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recommender/common_widgets/custom_search_bar.dart';
import 'package:recommender/common_widgets/genre_selection.dart';

import '../common_widgets/custom_app_bar.dart';
import '../core/route_config/route_names.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int index = 1;

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
        Icons.person,
        size: 30,
        color: index == 2 ? Colors.red : const Color.fromRGBO(121, 116, 126, 1.0),
      ),
    ];

    return Scaffold(
      extendBody: true,
      appBar: const CustomAppBar(title: 'List'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              const SearchFilterBar(),
              SizedBox(height: 15.h),
              GenreSelector(
                genres: [
                  "Watching",
                  'Completed',
                  'Plan to Watch',
                  'On Hold',
                ],
                onGenreSelected: (genre) {},
              ),
              SizedBox(height: 18.h),
              _movielist(
                'assets/images/Movie Poster/Pulp Fiction.png',
                'Pulp Fiction',
                'Adventure',
                '1994',
                '8.8',
                0.1,
                0,
                1,
              ),
              _movielist(
                'assets/images/Movie Poster/F1.jpg',
                'F1',
                'Racing',
                '2005',
                '8.8',
                10,
                1,
                1,
              ),
              _movielist(
                'assets/images/Movie Poster/SpiderMan.png',
                'Spider Man into the vice-verse',
                'Animated',
                '2022',
                '8.8',
                0.1,
                0,
                1,
              ),
              _movielist(
                'assets/images/Movie Poster/pandorum.jpg',
                'Pandorum',
                'Horror',
                '1994',
                '8.8',
                10,
                1,
                1,
              ),
              _movielist(
                'assets/images/Movie Poster/Shawshank.jpg',
                'Shawshank Redemption',
                'Adventure/Prison Break',
                '1994',
                '9.8',
                10,
                1,
                1,
              ),
            ],
          ),
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
              break;
            case 2:
              Navigator.pushNamed(context, RouteName.profileScreen);
              break;
          }
        },
      ),
    );
  }

  Widget _movielist(
      String imagePath,
      String title,
      String genre,
      String releaseDate,
      String imdb,
      double progress,
      int currentEp,
      int totalEp,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      height: 135.h,
      width: 374.w,
      decoration: BoxDecoration(
        color: const Color(0x3B545454),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 120.h,
                  width: 90.w,
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 15.h, right: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      genre,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      releaseDate,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
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
                    SizedBox(height: 5.h),
                    // Progress Bar
                    Row(
                      children: [
                        SizedBox(
                          width: 120.w,
                          child: Stack(
                            children: [
                              Container(
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final width = constraints.maxWidth * progress.clamp(0.0, 1.0);
                                  return Container(
                                    width: width,
                                    height: 8.h,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '$currentEp/$totalEp',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.h, right: 12.w),
              child: Icon(
                Icons.edit_outlined,
                size: 20.sp,
                color: Colors.white38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
