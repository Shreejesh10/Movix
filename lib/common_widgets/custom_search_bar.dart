import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Box
        Expanded(
          child: Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Color(0xFFFF383C), size: 30.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.h,
                    ),
                    decoration: InputDecoration(

                      hintText: 'Search by Name and Genre',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
        ),
        // Filter Icon
        SizedBox(width: 12.h,),
        SizedBox(
          width: 37.h,
          child: IconButton(
              onPressed: (){
                
              }, icon: Icon(Icons.filter_alt_outlined, color:Color(0xFFFF383C) , size: 40.sp,),
        ),
        ),
      ],
    );
  }
}
