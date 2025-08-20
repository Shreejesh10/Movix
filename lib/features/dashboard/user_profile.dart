import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:Movix/common_widgets/custom_app_bar.dart';
import 'package:Movix/screens/onboarding_screen.dart';
import 'package:Movix/theme/theme_provider.dart';
import '../../core/route_config/route_names.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int index = 3;
  bool isLoading = false;

  // Firebase user info
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? 'User';
        userEmail = user.email ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: index == 0 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0)),
      Icon(Icons.list, size: 30, color: index == 1 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0)),
      Icon(Icons.graphic_eq_outlined, size: 30, color: index == 2 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0)),
      Icon(Icons.person, size: 30, color: index == 3 ? Colors.red : Color.fromRGBO(121, 116, 126, 1.0)),
    ];

    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(title: "My Profile"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profile(),
            _editProfileButton('Edit Profile', Icons.mode_edit_outline_outlined, _showEditProfileDialog),
            _editProfileButton('Content Preference', Icons.menu_book_outlined, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GenreSelectionScreen(fromSettings: true),
                ),
              );
            }),
            _editProfileButton('Change Password', Icons.password_outlined, _showChangePasswordDialog),
            _editProfileButton("Light Mode", CupertinoIcons.moon, () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            }),
            _editProfileButton('Log out', Icons.exit_to_app, () {
              showDialog(context: context, builder: (context) => _logout());
            }),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 65.h,
        index: index,
        backgroundColor: Colors.transparent,
        color: Color.fromRGBO(35, 35, 35, 1.0),
        buttonBackgroundColor: Color.fromRGBO(35, 35, 35, 1.0),
        animationDuration: Duration(milliseconds: 400),
        items: items,
        onTap: (newIndex) {
          setState(() => index = newIndex);
          switch (newIndex) {
            case 0:
              Navigator.pushNamed(context, RouteName.homeScreen);
              break;
            case 1:
              Navigator.pushNamed(context, RouteName.listScreen);
              break;
            case 2:
              Navigator.pushNamed(context, RouteName.userDashboardScreen);
              break;
            case 3:
              break;
          }
        },
      ),
    );
  }

  Widget _profile() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/Spidermanpp.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(userName, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 4.h),
          Text(userEmail, style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _editProfileButton(String text, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: 350.sp,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.red, fontSize: 20.sp, fontWeight: FontWeight.w500)),
            Icon(icon, color: Colors.grey[600], size: 30.sp),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final user = FirebaseAuth.instance.currentUser;
    TextEditingController nameController = TextEditingController(text: userName);
    TextEditingController emailController = TextEditingController(text: userEmail);
    String? errorText;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: const Color(0xFF1E1E1E),
            title: Text('Edit Profile', style: TextStyle(color: Colors.white, fontSize: 20.sp)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (errorText != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(errorText!, style: TextStyle(color: Colors.red, fontSize: 14.sp)),
                  ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  String newName = nameController.text.trim();
                  String newEmail = emailController.text.trim();

                  if (newName.isEmpty || newEmail.isEmpty) {
                    setState(() => errorText = "All fields are required.");
                    return;
                  }

                  try {
                    // Update Firebase Auth
                    if (user != null) {
                      if (user.displayName != newName) await user.updateDisplayName(newName);
                      if (user.email != newEmail) await user.updateEmail(newEmail);
                      await user.reload();
                    }

                    setState(() {
                      userName = newName;
                      userEmail = newEmail;
                    });

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile updated successfully"), backgroundColor: Colors.green),
                    );
                  } on FirebaseAuthException catch (e) {
                    setState(() => errorText = e.message);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    TextEditingController currentPass = TextEditingController();
    TextEditingController newPass = TextEditingController();
    TextEditingController confirmPass = TextEditingController();
    String? errorText;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: const Color(0xFF1E1E1E),
            title: Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 20.sp)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (errorText != null) Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(errorText!, style: TextStyle(color: Colors.red, fontSize: 14.sp)),
                ),
                TextField(controller: currentPass, obscureText: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Current Password', hintStyle: const TextStyle(color: Colors.grey))),
                SizedBox(height: 12.h),
                TextField(controller: newPass, obscureText: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'New Password', hintStyle: const TextStyle(color: Colors.grey))),
                SizedBox(height: 12.h),
                TextField(controller: confirmPass, obscureText: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: 'Confirm New Password', hintStyle: const TextStyle(color: Colors.grey))),
              ],
            ),
            actions: [
              TextButton(child: Text('Cancel', style: TextStyle(color: Colors.grey[400])), onPressed: () => Navigator.of(context).pop()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                child: isLoading ? SizedBox(width: 20.w, height: 20.w, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Save', style: TextStyle(color: Colors.white)),
                onPressed: isLoading
                    ? null
                    : () async {
                  String curr = currentPass.text.trim();
                  String newP = newPass.text.trim();
                  String confirmP = confirmPass.text.trim();

                  if (curr.isEmpty || newP.isEmpty || confirmP.isEmpty) {
                    setState(() => errorText = "All fields are required.");
                    return;
                  }
                  if (newP.length < 6) {
                    setState(() => errorText = "Password must be at least 6 characters.");
                    return;
                  }
                  if (newP != confirmP) {
                    setState(() => errorText = "Passwords do not match.");
                    return;
                  }

                  try {
                    setState(() => isLoading = true);
                    User? user = FirebaseAuth.instance.currentUser;
                    AuthCredential cred = EmailAuthProvider.credential(email: user!.email!, password: curr);
                    await user.reauthenticateWithCredential(cred);
                    await user.updatePassword(newP);
                    await user.reload();
                    setState(() => isLoading = false);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password changed successfully"), backgroundColor: Colors.green));
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      isLoading = false;
                      if (e.code == 'wrong-password') errorText = "Current password is incorrect.";
                      else if (e.code == 'requires-recent-login') errorText = "Please log in again and try.";
                      else errorText = "Error: ${e.message}";
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _logout() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: const Color(0xFF1E1E1E),
      title: Text("Are you sure?", style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold)),
      content: Text("Do you really want to log out?", style: TextStyle(fontSize: 16.sp, color: Colors.grey[400])),
      actions: [
        TextButton(child: Text("Cancel", style: TextStyle(color: Colors.grey[400], fontSize: 16.sp)), onPressed: () => Navigator.of(context).pop()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
          child: Text("Log out", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, AuthRouteName.loginScreen, (route) => false);
          },
        ),
      ],
    );
  }
}
