import 'package:flutter/material.dart';
import 'package:recommender/core/route_config/route_names.dart';
import 'package:recommender/features/auth/login.dart';
import 'package:recommender/features/auth/signup.dart';

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