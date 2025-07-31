import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recommender/core/route_config/route_names.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    'My Movie List',
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 44.sp,
                      color: const Color.fromRGBO(255, 56, 60, 1.0),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),

                _field(_emailController, 'Email Address', icon: Icons.person),
                _field(_passwordController, 'Password', isPassword: true),

                SizedBox(height: 20.h),
                SizedBox(
                  width: 314.w,
                  height: 39.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 56, 60, 1.0),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (_formKey.currentState!.validate()) {
                          final email = _emailController.text.trim();
                          Navigator.pushNamed(context, RouteName.homeScreen);
                        }

                      },
                      child: Text(
                        'Sign In',
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
                SizedBox(height: 15.h,),
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
                        border: Border.all(color: Colors.grey, width: 2)
                      ),
                      child: Text('Or',style: TextStyle(
                        fontSize: 14.sp,
                      ),),
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
                  onTap: () {
                    // For Future
                    print("Google Sign-In tapped");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Icon(Icons.g_translate, color: Colors.black, size: 25.sp,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            AuthRouteName.signupScreen);
                      },
                      child: Text(
                        'Sign Up?',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Color.fromRGBO(255, 56, 60, 1.0),
                          decoration: TextDecoration.underline ,
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
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Color.fromRGBO(217, 217, 217, 1.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 14.w,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[700],
                        size: 25.h,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : Icon(icon, color: Colors.grey[700], size: 30.h),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hintText';
              }
              if (hintText == 'Email Address' &&
                  !RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value.trim())) {
                return 'Enter a valid Email address';
              }
              return null;
            },
          ),
        );
      },
    );
  }
}
