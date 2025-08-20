import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Movix/common_widgets/custom_search_bar.dart';
import 'package:Movix/common_widgets/edit_movie_status.dart';
import 'package:Movix/common_widgets/genre_selection.dart';
import '../common_widgets/custom_app_bar.dart';
import '../core/route_config/route_names.dart';
import 'package:Movix/models/allModels.dart';
import 'package:Movix/api/api.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int index = 1;
  final ScrollController _scrollController = ScrollController();
  List<WatchListItem> watchList = [];
  List<WatchListItem> filteredWatchList = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState(){
    super.initState();
    _loadWatchList();
  }

  void _filterWatchList(String type) {
    final filteredMovies = watchList.where((item) => item.type == type).toList();

    setState(() {
      filteredWatchList = filteredMovies;
    });
  }

  void _loadWatchList() async {
    final watchListData = await getWatchList();

    setState(() {
      watchList = watchListData;
    });

    _filterWatchList('Watching');
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
      extendBody: true,
      appBar: const CustomAppBar(title: 'List'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 55.h),
          child: Column(
            children: [
              const SearchFilterBar(),
              SizedBox(height: 15.h),
              GenreSelector(
                genres: ['Watching', 'Completed', 'Plan To Watch'],
                onGenreSelected: (genre) {
                  _filterWatchList(genre);
                },
              ),
              SizedBox(height: 18.h),
              ...filteredWatchList.map((item) {
                return _movielist(
                  'http://image.tmdb.org/t/p/w200/${item.movie?.posterPath}',
                  item.movie?.title??'',
                  item.movie?.genres?.join('/')??'',
                  item.movie?.releaseDate?.split('-')[0]??'',
                  item.movie?.voteAverage?.toString() ?? '',
                  item.type != 'Completed' ? 0 : 1,
                  item.type != 'Completed' ? 0 : 1,
                  1
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.red,

        shape: CircleBorder(),
        child: Icon(
          Icons.arrow_upward_outlined,
          color: Colors.white,
          size: 30.sp,
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
              Navigator.pushNamed(context, RouteName.userDashboardScreen);
              break;
            case 3:
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
        onTap: () {
          Navigator.pushNamed(context, RouteName.movieDetailScreen);
        },
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
                                  final width =
                                      constraints.maxWidth *
                                      progress.clamp(0.0, 1.0);
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
              padding: EdgeInsets.only(top: 6.h, right: 12.w),
              child: IconButton(
                onPressed: () {
                  _editButtonAction();
                },
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20.h,
                  color: Colors.white38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editButtonAction() {
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

                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: selectedStatus,
                    isExpanded: true,
                    dropdownColor: Colors.grey[900],
                    items:
                        [
                          'Currently Watching',
                          'Completed',
                          'Plan to watch',
                        ].map((String value) {
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
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
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
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
