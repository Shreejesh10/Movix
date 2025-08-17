import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recommender/models/movie.dart';
import 'package:recommender/features/services/cache_service.dart';
import 'package:recommender/api/api.dart';
import 'dart:developer';

import '../common_widgets/edit_movie_status.dart';

class ViewallScreen extends StatefulWidget {
  const ViewallScreen({super.key});

  @override
  State<ViewallScreen> createState() => _ViewallScreenState();
}

class _ViewallScreenState extends State<ViewallScreen> {
  List<Movie> recommendedMovies = [];
  List<Movie> popularMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMovies();
  }

  void _loadMovies() async {
    print("Entered load movies");

    String? userId = getUserId();

    dynamic cachedUidValue = await CacheService.getValue("currentUserUid");
    String? cachedUid = cachedUidValue?.toString();

    dynamic cachedRecommendedValue = await CacheService.getValue("recommendedMovies");
    dynamic cachedPopularValue = await CacheService.getValue("popularMovies");

    dynamic cachedLastFetchedTimeValue = await CacheService.getValue("lastMoviesFetchedTime");
    Duration diff = Duration(minutes: 10);

    if (cachedLastFetchedTimeValue != null) {
      try {
        diff = DateTime.now().difference(DateTime.parse(cachedLastFetchedTimeValue.toString()));
      } catch (e) {
        log("Failed to parse last fetched time: $e");
        diff = Duration(minutes: 10);
      }
    }

    // Only call API if cache is invalid
    if (userId != cachedUid || cachedRecommendedValue == null || cachedPopularValue == null || diff.inMinutes > 5) {
      print("Loading from api");
      final recommended = await getRecommendedMovies();
      final popular = await getPopularMovies();

      setState(() {
        recommendedMovies = recommended;
        popularMovies = popular;
      });

      await CacheService.setValue("lastMoviesFetchedTime", DateTime.now().toIso8601String());

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recommended For You',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(173, 173, 173, 1.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 55.h),
          child: Column(
            children: [
              SizedBox(height: 18.h),
              ...recommendedMovies.map((movie) {
                return _movielist(
                    'http://image.tmdb.org/t/p/w200/${movie.posterPath}',
                    movie.title??'',
                    (movie.genres??[]).join('/'),
                    movie.releaseDate??''.split('-')[0],
                    movie.voteAverage?.toStringAsFixed(2) ?? '-'
                );
              }),
            ],
          ),

        ),
      ),
    );
  }

  Widget _movielist(
    String imagePath,
    String title,
    String genre,
    String releaseDate,
    String imdb,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.w),
      height: 120.h,
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
                  child: Image.network(imagePath, fit: BoxFit.cover),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      releaseDate,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 15.sp,
                        ),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 7.h, right: 12.w),
              child: IconButton(
                onPressed: () {
                  _addStatusList();
                },
                icon: Icon(
                  Icons.add,
                  size: 25.h,
                  color: Colors.white38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _addStatusList() {
    String selectedStatus = 'Currently Watching';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text('Change Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MovieListTile(
                    imagePath: 'assets/images/Movie Poster/Pulp Fiction.png',
                    title: 'Pulp Fiction',
                    genre: 'Adventure',
                    releaseDate: '1994',
                    imdb: '8.8',
                  ),

                  const SizedBox(height: 8),
                  DropdownButton<String>(
                    value: selectedStatus,
                    isExpanded: true,
                    dropdownColor: Colors.grey[900],
                    items: ['Currently Watching', 'Completed', 'On hold', 'Plan to watch']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancel
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.white),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 4,
                  ),
                  onPressed: () {
                    print("Selected status: $selectedStatus");
                    Navigator.of(context).pop(); // Save

                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white, fontSize:18),),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
