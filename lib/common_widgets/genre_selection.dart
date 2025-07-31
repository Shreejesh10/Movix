import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenreSelector extends StatefulWidget {
  final List<String> genres;
  final void Function(String)? onGenreSelected;

  const GenreSelector({
    super.key,
    this.genres = const [
      "All", "Adventure", "Comedy", "Thriller", "Horror", "Action", "Romance"
    ],
    this.onGenreSelected,
  });

  @override
  State<GenreSelector> createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        itemCount: widget.genres.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                // Call the callback if provided
                widget.onGenreSelected?.call(widget.genres[index]);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: isSelected
                      ? Border.all(color: const Color(0xFFFF383C), width: 1.5)
                      : null,
                ),
                child: Center(
                  child: Text(
                    widget.genres[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
