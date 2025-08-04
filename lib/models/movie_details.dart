import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../common_widgets/edit_movie_status.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.h),
          child: Center(
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: const BoxDecoration(
                color: Color(0x80000000),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [

          SizedBox(
            height: screenHeight * 0.3,
            width: double.infinity,
            child: Image.asset(
              'assets/images/Movie Poster/F1.jpg',
              fit: BoxFit.cover,
            ),
          ),


          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.25),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(35, 35, 35, 1.0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 Top Row: Poster + Basic Info
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(100),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/Movie Poster/F1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "F1",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                "Racing • 2025",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white54,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  ...List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "8.5",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),


                    Row(
                      children: [
                        Icon(Icons.schedule, color: Colors.white70, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          "2h 35m",
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),


                    Text(
                      "This is a movie about Formula 1 racing, adrenaline, and the journey of elite drivers pushing the limits of speed and endurance.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16.h),


                    Text(
                      "Director: John Speedman",
                      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    ),
                    SizedBox(height: 8.h),


                    Text(
                      "Cast: Max Velocity, Lisa Drive, Chris Track",
                      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 50.w,
                          height: 50.w,
                          child: ElevatedButton(
                            onPressed: () {
                              _editButtonAction();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.zero,
                            ),
                            child: Icon(Icons.edit_outlined, size: 28.sp, color: Colors.white),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
        ],
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
                    imagePath: 'assets/images/Movie Poster/F1.jpg',
                    title: 'F1',
                    genre: 'Action/Sport',
                    releaseDate: '2025',
                    imdb: '8.5',
                  ),

                  const SizedBox(height: 12),
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
