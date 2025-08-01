import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/route_config/route_names.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'My Movie List',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 44.sp,
                    color: const Color.fromRGBO(255, 56, 60, 1.0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Sign Up!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.h),

                _field(_usernameController, 'Username'),
                _field(_emailController, 'Email Address', icon: Icons.person),
                _field(_passwordController, 'Password', isPassword: true),

                SizedBox(height: 20.h),
                SizedBox(
                  width: 314.w,
                  height: 50.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 56, 60, 1.0),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          // Proceed with signup
                          Navigator.pushNamed(context, RouteName.onboardingScreen);
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Reset now?',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color.fromRGBO(255, 56, 60, 1.0),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                        indent: 17.w,
                        endIndent: 10.w,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2),
                      ),
                      child: Text(
                        'Or',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                        indent: 10.w,
                        endIndent: 17.w,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () => print("Google Sign-In tapped"),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(Icons.g_translate, color: Colors.black, size: 25.sp),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already got an account?",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AuthRouteName.loginScreen);
                      },
                      child: Text(
                        'Sign In.',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color.fromRGBO(255, 56, 60, 1.0),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
      TextEditingController controller,
      String hintText, {
        bool isPassword = false,
        IconData? icon,
      }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: const Color.fromRGBO(30, 30, 30, 1),
              contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade800),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[500],
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
                  : Icon(icon, color: Colors.grey[500]),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $hintText';
              }

              if (hintText == 'Username' && value.trim().length < 3) {
                return 'Username must be at least 3 characters';
              }

              if (hintText == 'Email Address' &&
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                      .hasMatch(value.trim())) {
                return 'Enter a valid email address';
              }

              if (hintText == 'Password' && value.trim().length < 6) {
                return 'Password must be at least 6 characters';
              }

              return null;
            },
          ),
        );
      },
    );
  }
}
