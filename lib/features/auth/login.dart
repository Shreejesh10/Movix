import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recommender/core/route_config/route_names.dart';
import 'package:recommender/features/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();

      if (email == 'admin@gmail.com') {
        Navigator.pushNamed(context, RouteName.adminDashboard);
      } else {
        Navigator.pushNamed(context, RouteName.homeScreen);
      }
    } else {
      if (_emailController.text.isEmpty ||
          !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
              .hasMatch(_emailController.text.trim())) {
        _emailFocus.requestFocus();
      } else {
        _passwordFocus.requestFocus();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Disable back button
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 23.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    Text(
                      'Sign In!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    _field(
                      _emailController,
                      'Email Address',
                      focusNode: _emailFocus,
                      icon: Icons.person,
                    ),
                    _field(
                      _passwordController,
                      'Password',
                      isPassword: true,
                      focusNode: _passwordFocus,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF383C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

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
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
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
                      onTap: () async {
                        UserCredential? userCredential = await AuthService().signInWithGoogle();

                        if (userCredential != null) {
                          print("Signed in as ${userCredential.user?.displayName}");
                          Navigator.pushNamed(context, RouteName.homeScreen);
                        } else {
                          // Show SnackBar on error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Google Sign-In cancelled or failed. Please try again.'),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },


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
                            Icon(
                              Icons.g_translate,
                              color: Colors.black,
                              size: 25.sp,
                            ),
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
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            AuthRouteName.signupScreen,
                          ),
                          child: Text(
                            'Sign Up?',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Color(0xFFFF383C),
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
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String hintText, {
    bool isPassword = false,
    IconData? icon,
    FocusNode? focusNode,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            obscureText: isPassword && !_isPasswordVisible,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: const Color(0xFF1C1C1E),
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 16.w,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: Colors.grey.shade700),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
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
              if (hintText == 'Email Address' &&
                  !RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                  ).hasMatch(value.trim())) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
        );
      },
    );
  }
}
