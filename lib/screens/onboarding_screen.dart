import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/route_config/route_names.dart';
import 'package:Movix/constants.dart';
import 'package:Movix/models/genre.dart';
import 'package:Movix/api/api.dart';
import 'package:collection/collection.dart';
import 'package:Movix/features/services/cache_service.dart';

class GenreSelectionScreen extends StatefulWidget {
  final bool fromSettings;
  const GenreSelectionScreen({super.key, this.fromSettings = false});

  @override
  State<GenreSelectionScreen> createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<Genre> genres = GENRES;
  List<Genre> selectedGenres = [];
  List<Genre> initialPreferences = [];
  bool changedPreferences = false;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    final prefs = await getCurrentUserPreferences();
    setState(() {
      selectedGenres = prefs;
      initialPreferences = List<Genre>.from(prefs);
    });
  }

  bool _preferencesChanged() {
    final selectedIds = selectedGenres.map((g) => g.id).toSet();
    final initialIds = initialPreferences.map((g) => g.id).toSet();
    return !const SetEquality().equals(selectedIds, initialIds);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
                          if (!widget.fromSettings) {
                            Navigator.pushNamed(context, RouteName.homeScreen);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          ".",
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
                        final isSelected = selectedGenres.any(
                          (g) => g.id == genre.id,
                        );
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedGenres.removeWhere(
                                  (g) => g.id == genre.id,
                                );
                              } else {
                                selectedGenres.add(genre);
                              }

                              changedPreferences = _preferencesChanged();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color.fromRGBO(255, 56, 60, 1)
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: Text(
                              genre.name,
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
                        style: TextStyle(color: Colors.black, fontSize: 20.sp),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Next / Save Button
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (changedPreferences) {
                              bool proceed = true;
                            }
                            if (widget.fromSettings) {
                              bool? confirm = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) =>
                                    _areYouSure(),
                              );

                              if (confirm != true) return;

                              // Save preferences
                              await updateUserPreferences(selectedGenres);
                              setState(() {
                                changedPreferences = false;
                                initialPreferences = List.from(selectedGenres);
                              });
                            }

                            // Navigate
                            if (!widget.fromSettings) {
                              await updateUserPreferences(selectedGenres);
                              Navigator.pushNamed(
                                context,
                                RouteName.homeScreen,
                              );
                            } else {
                              Navigator.pop(context);
                            }

                            // Clear caches
                            CacheService.remove('recommendedMovies');
                            CacheService.remove('popularMovies');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              255,
                              56,
                              60,
                              1,
                            ),
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

  Widget _areYouSure() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: const Color(0xFF1E1E1E),
      title: Text(
        "Are you sure?",
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Your current recommendations will be updated based on your new preferences.",
        style: TextStyle(fontSize: 16.sp, color: Colors.grey[400]),
      ),
      actions: [
        TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
          ),
          onPressed: () {
            Navigator.of(context).pop(false); // Cancel
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          onPressed: () {
            Navigator.of(context).pop(true); // Confirm
          },
        ),
      ],
    );
  }
}
