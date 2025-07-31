interface class AuthRouteName {
  static const String loginScreen = '/login-screen';
  static const String signupScreen = '/signup-screen';
}

class RouteName {
  RouteName._();

  static const String defaultScreen = '/';
  static const String homeScreen = '/home-screen';
  static const String profileScreen = '/profile-screen';
  static const String listScreen = '/list-screen';
  static AuthRouteName get auth => AuthRouteName(); //getter for login

}