interface class AuthRouteName {
  static const String loginScreen = '/login-screen';
  static const String signupScreen = '/signup-screen';
}

class RouteName {
  RouteName._();

  static const String defaultScreen = '/';
  static AuthRouteName get auth => AuthRouteName(); //getter for login

}