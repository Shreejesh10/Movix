import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Movix/common_widgets/custom_app_bar.dart';
import 'package:Movix/common_widgets/genre_selection.dart';
import 'package:Movix/core/route_config/route_names.dart';
import '../../common_widgets/custom_search_bar.dart';
import 'package:Movix/models/allModels.dart';
import 'package:Movix/features/services/cache_service.dart';
import 'package:Movix/api/api.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  List<Movie> recommendedMovies = [];
  List<Movie> popularMovies = [];

  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize blinking animation for loading placeholders
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(_blinkController);

    _loadMovies();
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  void _loadMovies() async {
    print("Entered load movies");

    String? userId = getUserId();

    dynamic cachedUidValue = await CacheService.getValue("currentUserUid");
    String? cachedUid = cachedUidValue?.toString();

    dynamic cachedRecommendedValue = await CacheService.getValue(
      "recommendedMovies",
    );
    dynamic cachedPopularValue = await CacheService.getValue("popularMovies");

    dynamic cachedLastFetchedTimeValue = await CacheService.getValue(
      "lastMoviesFetchedTime",
    );
    Duration diff = Duration(minutes: 10);
    print(cachedUid);
    print(cachedLastFetchedTimeValue);
    if (cachedLastFetchedTimeValue != null) {
      try {
        diff = DateTime.now().difference(
          DateTime.parse(cachedLastFetchedTimeValue.toString()),
        );
      } catch (e) {
        log("Failed to parse last fetched time: $e");
        diff = Duration(minutes: 10);
      }
    }

    // Only call API if cache is invalid
    if (userId != cachedUid ||
        cachedRecommendedValue == null ||
        cachedPopularValue == null ||
        diff.inMinutes > 5) {
      print("Loading from api");
      final recommended = await getRecommendedMovies();
      final popular = await getPopularMovies();

      setState(() {
        recommendedMovies = recommended;
        popularMovies = popular;
      });

      await CacheService.setValue("currentUserUid", userId);
      await CacheService.setValue(
        "lastMoviesFetchedTime",
        DateTime.now().toIso8601String(),
      );
    } else {
      print("Loading from cache");
      print(cachedLastFetchedTimeValue);

      List<Movie> cachedRecommendedMovies = [];
      List<Movie> cachedPopularMovies = [];

      if (cachedRecommendedValue is List) {
        cachedRecommendedMovies = cachedRecommendedValue
            .map((item) => Movie.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }

      if (cachedPopularValue is List) {
        cachedPopularMovies = cachedPopularValue
            .map((item) => Movie.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }

      setState(() {
        recommendedMovies = cachedRecommendedMovies;
        popularMovies = cachedPopularMovies;
      });
    }
  }

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
      canPop: false,
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
                  children: recommendedMovies.isEmpty
                      ? List.generate(5, (index) => _loadingMovieList())
                      : recommendedMovies.map((movie) {
                          return _movieList(
                            'http://image.tmdb.org/t/p/w200/${movie.posterPath}',
                            movie.title ?? '',
                            (movie.genres ?? []).join('/'),
                            movie.voteAverage?.toStringAsFixed(2) ?? '-',
                          );
                        }).toList(),
                ),
              ),

              // Popular section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: _content('Popular Right Now'),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15.w),
                child: Row(
                  children: popularMovies.isEmpty
                      ? List.generate(5, (index) => _loadingMovieList())
                      : popularMovies.map((movie) {
                          return _movieList(
                            'http://image.tmdb.org/t/p/w200/${movie.posterPath}',
                            movie.title ?? '',
                            (movie.genres ?? []).join('/'),
                            movie.voteAverage?.toStringAsFixed(2) ?? '-',
                          );
                        }).toList(),
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
                child: Image.network(imagePath, fit: BoxFit.cover),
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

  /// Blinking loading placeholder
  Widget _loadingMovieList() {
    return AnimatedBuilder(
      animation: _blinkAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _blinkAnimation.value,
          child: Container(
            margin: EdgeInsets.only(right: 12.w),
            height: 260.h,
            width: 140.w,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
