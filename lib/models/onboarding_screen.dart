import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/route_config/route_names.dart';
import 'package:recommender/constants.dart';

class GenreSelectionScreen extends StatefulWidget {
  final bool fromSettings;
  const GenreSelectionScreen({super.key, this.fromSettings = false});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<String> genres = GENRES;

  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:false,
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/images/Spidermanbg.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // Content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Skip button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (!widget.fromSettings){
                            Navigator.pushNamed(context, RouteName.homeScreen);
                          }else{
                            Navigator.pop(context);
                          }

                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Title
                    Center(
                      child: Text(
                        "Choose Your Genres",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Genre Chips
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 12.h,
                      children: genres.map((genre) {
                        final isSelected = selectedGenres.contains(genre);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected
                                  ? selectedGenres.remove(genre)
                                  : selectedGenres.add(genre);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromRGBO(255, 56, 60, 1)
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: Text(
                              genre,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const Spacer(),

                    // Instruction text
                    Center(
                      child: Text(
                        "Select the genres you\nlike to watch",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Next button
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if(!widget.fromSettings){
                              Navigator.pushNamed(context, RouteName.homeScreen);
                            }
                            else{
                              Navigator.pop(context);
                            }

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromRGBO(255, 56, 60, 1),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Text(
                            "Save Preferences",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
