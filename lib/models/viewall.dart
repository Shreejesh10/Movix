import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_widgets/edit_movie_status.dart';

class ViewallScreen extends StatefulWidget {
  const ViewallScreen({super.key});

  @override
  State<ViewallScreen> createState() => _ViewallScreenState();
}

class _ViewallScreenState extends State<ViewallScreen> {
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
              _movielist(
                'assets/images/Movie Poster/Pulp Fiction.png',
                'Pulp Fiction',
                'Crime/Drama',
                '1994',
                '8.9',
              ),
              _movielist(
                'assets/images/Movie Poster/ted.png',
                'Ted',
                'Comedy/Fantasy',
                '2012',
                '6.9',
              ),
              _movielist(
                'assets/images/Movie Poster/romeo.png',
                'Romeo + Juliet',
                'Drama/Romance',
                '1996',
                '6.8',
              ),
              _movielist(
                'assets/images/Movie Poster/Forestgump.jpg',
                'Forrest Gump',
                'Drama/Romance',
                '1994',
                '8.8',
              ),
              _movielist(
                'assets/images/Movie Poster/F1.jpg',
                'F1',
                'Action/Sport',
                '2025',
                '8.5',
              ),
              _movielist(
                'assets/images/Movie Poster/SpiderMan.png',
                'Spider-Man: Into the Spider-Verse',
                'Animation/Action',
                '2018',
                '8.4',
              ),
              _movielist(
                'assets/images/Movie Poster/great gatsby.png',
                'The Great Gatsby',
                'Drama/Romance',
                '2013',
                '7.2',
              ),
              _movielist(
                'assets/images/Movie Poster/pandorum.jpg',
                'Pandorum',
                'Horror/Sci-fi',
                '2009',
                '6.7',
              ),
              _movielist(
                'assets/images/Movie Poster/Shawshank.jpg',
                'The Shawshank Redemption',
                'Drama/Prison',
                '1994',
                '9.3',
              ),
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
