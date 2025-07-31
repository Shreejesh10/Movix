import 'package:flutter/material.dart';
import 'package:recommender/core/route_config/route_names.dart';
import 'package:recommender/features/auth/login.dart';
import 'package:recommender/features/auth/signup.dart';
import 'package:recommender/features/dashboard/home.dart';
import 'package:recommender/features/dashboard/user_profile.dart';
import 'package:recommender/models/lists.dart';

class RouteConfig {
  RouteConfig._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? screenName = settings.name;
    final dynamic args = settings.arguments;

    switch (screenName) {
      case AuthRouteName.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AuthRouteName.signupScreen:
        return MaterialPageRoute(
            builder: (_) => const SignupScreen()
        );
      case RouteName.homeScreen:
        return MaterialPageRoute(
            builder:(_) => const HomeScreen()
        );
      case RouteName.profileScreen:
        return MaterialPageRoute(
            builder: (_) => const UserProfileScreen()
        );
      case RouteName.listScreen:
        return MaterialPageRoute(
            builder: (_) => const UserListScreen()
        );


      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('No route defined')),
      ),
    );
  }
}