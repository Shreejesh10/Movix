import 'package:flutter/material.dart';
import 'package:recommender/core/route_config/route_names.dart';
import 'package:recommender/features/auth/login.dart';
import 'package:recommender/features/auth/signup.dart';
import 'package:recommender/features/dashboard/home.dart';
import 'package:recommender/features/dashboard/user_dashboard.dart';
import 'package:recommender/features/dashboard/user_profile.dart';
import 'package:recommender/models/lists.dart';
import 'package:recommender/models/movie_details.dart';
import 'package:recommender/models/onboarding_screen.dart';
import 'package:recommender/models/splash_screen.dart';
import 'package:recommender/models/viewall.dart';

class RouteConfig {
  RouteConfig._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? screenName = settings.name;
    final dynamic args = settings.arguments;

    switch (screenName) {
      case AuthRouteName.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AuthRouteName.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteName.profileScreen:
        return MaterialPageRoute(builder: (_) => const UserProfileScreen());
      case RouteName.listScreen:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      case RouteName.userDashboardScreen:
        return MaterialPageRoute(builder: (_) => const UserDashboardScreen());
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const GenreSelectionScreen());
      case RouteName.viewallScreen:
        return MaterialPageRoute(builder: (_) => const ViewallScreen());
      case RouteName.movieDetailScreen:
        return MaterialPageRoute(builder: (_) => const MovieDetailsScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('No route defined'))),
    );
  }
}
