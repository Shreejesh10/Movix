import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Movix/models/movie.dart';
import 'package:intl/intl.dart';

import '../common_widgets/edit_movie_status.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  String _formatRuntime(int? minutes) {
    if (minutes == null || minutes <= 0) return '-';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '${hours}hr ${mins}m';
  }
  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'Unknown';
    final parsed = DateTime.tryParse(date);
    return parsed != null ? DateFormat('MMM d, yyyy').format(parsed) : 'Unknown';
  }


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
            child: Image.network(
              'http://image.tmdb.org/t/p/w400/${widget.movie.backdropPath}',
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
                            image: DecorationImage(
                              image: NetworkImage(
                                'http://image.tmdb.org/t/p/w200/${widget.movie.posterPath}',
                              ),
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
                                widget.movie.title??'',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                (widget.movie.genres ?? []).join('/'),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white54,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                widget.movie.releaseDate != null && widget.movie.releaseDate!.isNotEmpty
                                    ? '• ${DateTime.tryParse(widget.movie.releaseDate!)?.year ?? 'Unknown'}'
                                    : '• Unknown',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white54,
                                ),
                              ),
                              SizedBox(height: 5.h),
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
                                    widget.movie.voteAverage?.toStringAsFixed(2) ?? '-',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              //User Rating
                              SizedBox(height: 6.h,),
                              ElevatedButton(
                                onPressed: () {
                                  double _currentRating = 5.0; // Default value

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return AlertDialog(
                                            title: Text('Rate Now'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('Rate this movie from 1 to 10'),
                                                SizedBox(height: 20),
                                                Slider(
                                                  activeColor: Colors.yellowAccent,
                                                  value: _currentRating,
                                                  min: 1,
                                                  max: 10,
                                                  divisions: 9,
                                                  label: _currentRating.toStringAsFixed(1),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _currentRating = value;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Your rating: ${_currentRating.toStringAsFixed(1)}',
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Cancel
                                                },
                                                child: Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                                              ),
                                              ElevatedButton(

                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close dialog
                                                  //For rating logic
                                                  print('User rated: ${_currentRating.toStringAsFixed(1)}');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.redAccent,
                                                ),

                                                child: Text('Submit', style: TextStyle(color: Colors.white,fontSize: 14.sp),),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: Text(
                                  'Rate Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )


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
                          _formatRuntime(widget.movie.runtime),
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),


                    Text(
                      widget.movie.overview ??'',
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
                    SizedBox(height: 8.h),
                    Text(
                      "Release Date: ${_formatDate(widget.movie.releaseDate)}",
                      style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                    ),
                    SizedBox(height: 20.h),


                  ],
                ),

              ),



            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        onPressed: _editButtonAction,
        child: Icon(Icons.edit_outlined, size: 28.sp, color: Colors.white),
      ),

    );
  }
  void _editButtonAction() {
    String selectedStatus = 'Currently Watching';
    DateTime? _startDate;
    DateTime? _endDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text('Change Status', style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MovieListTile(
                      imagePath: 'http://image.tmdb.org/t/p/w200/${widget.movie.posterPath}',
                      title: widget.movie.title ?? '',
                      genre: (widget.movie.genres ?? []).join('/'),
                      releaseDate: '2025',
                      imdb: widget.movie.voteAverage?.toStringAsFixed(2) ?? '-',
                    ),

                    const SizedBox(height: 12),

                    // 🔹 START DATE Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Start Date', style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _startDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
                        );
                        if (picked != null) {
                          setState(() {
                            _startDate = picked;
                            // Optional: Reset end date if it is before new start date
                            if (_endDate != null && _endDate!.isBefore(picked)) {
                              _endDate = null;
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _startDate != null
                                  ? DateFormat('MMM d, yyyy').format(_startDate!)
                                  : 'Select Date',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(Icons.calendar_today, size: 18.sp, color: Colors.white70),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // 🔹 END DATE Field
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Date Finished', style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _endDate ?? (_startDate ?? DateTime.now()),
                          firstDate: _startDate ?? DateTime(1900),  // <-- Restrict here
                          lastDate: DateTime(2100),
                          builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
                        );
                        if (picked != null) {
                          setState(() {
                            _endDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _endDate != null
                                  ? DateFormat('MMM d, yyyy').format(_endDate!)
                                  : 'Select Date',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(Icons.calendar_today, size: 18.sp, color: Colors.white70),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 🔹 Dropdown Status
                    DropdownButton<String>(
                      value: selectedStatus,
                      isExpanded: true,
                      dropdownColor: Colors.grey[900],
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 17),
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
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancel
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 4,
                  ),
                  onPressed: () {
                    // Validation before saving
                    if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('End date cannot be before start date')),
                      );
                      return;
                    }

                    print("Selected status: $selectedStatus");
                    print("Start date: ${_startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : 'Not selected'}");
                    print("End date: ${_endDate != null ? DateFormat('yyyy-MM-dd').format(_endDate!) : 'Not selected'}");

                    Navigator.of(context).pop(); // Save and close
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            );
          },
        );
      },
    );
  }



}
