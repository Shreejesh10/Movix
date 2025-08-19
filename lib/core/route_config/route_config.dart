import 'package:Movix/features/auth/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:Movix/core/route_config/route_names.dart';
import 'package:Movix/features/auth/login.dart';
import 'package:Movix/features/auth/signup.dart';
import 'package:Movix/features/dashboard/admin_dashboard.dart';
import 'package:Movix/features/dashboard/home.dart';
import 'package:Movix/features/dashboard/user_dashboard.dart';
import 'package:Movix/features/dashboard/user_profile.dart';
import 'package:Movix/screens/addMovie.dart';
import 'package:Movix/screens/lists.dart';
import 'package:Movix/screens/movie_details.dart';
import 'package:Movix/screens/onboarding_screen.dart';
import 'package:Movix/screens/splash_screen.dart';
import 'package:Movix/screens/viewall.dart';
import 'package:Movix/models/movie.dart';

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
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie));
      case RouteName.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case RouteName.addMovieScreen:
        return MaterialPageRoute(builder: (_) => const AddMovieScreen());
      case RouteName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

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
