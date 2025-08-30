import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Movix/core/route_config/route_names.dart';
import 'package:provider/provider.dart';
import 'package:Movix/theme/theme_provider.dart';
import 'core/route_config/route_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RecommenderApp());
}

class RecommenderApp extends StatelessWidget {
  const RecommenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => ThemeProvider())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer<ThemeProvider>(
            builder:
                (
                  BuildContext context,
                  ThemeProvider themeProvider,
                  Widget? child,
                ) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'My Movie List',
                    themeMode: themeProvider.isDarkMode
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    theme: ThemeData(
                      fontFamily: 'Poppins',
                      scaffoldBackgroundColor: Color.fromRGBO(35, 35, 35, 1.0),
                      colorScheme: const ColorScheme.dark(
                        secondary: Color(0xFF262626),
                      ),
                      iconButtonTheme: IconButtonThemeData(
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(Colors.white),
                        ),
                      ),
                      iconTheme: const IconThemeData(color: Colors.white),
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Color.fromRGBO(35, 35, 35, 1.0),
                        titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Colors.transparent,
                        elevation: 3,
                      ),
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      timePickerTheme: const TimePickerThemeData(
                        backgroundColor: Color(0xFF1E1E1E),
                        hourMinuteTextColor: Color(0xFF1E1E1E),
                        hourMinuteColor: Colors.grey,
                        dayPeriodTextColor: Colors.white70,
                        dialBackgroundColor: Colors.red,
                        dialHandColor: Colors.white,
                        dialTextColor: Colors.white,
                        entryModeIconColor: Colors.white,
                        helpTextStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                      ),
                      textTheme: const TextTheme(
                        bodyMedium: TextStyle(color: Colors.white),
                      ),
                      hoverColor: Colors.transparent,
                    ),

                    darkTheme: ThemeData(
                      fontFamily: 'Poppins',
                      scaffoldBackgroundColor: Colors.white,
                      colorScheme: const ColorScheme.dark(
                        secondary: Color(0xFF262626),
                      ),
                      iconButtonTheme: IconButtonThemeData(
                        style: ButtonStyle(
                          iconColor: WidgetStateProperty.all(Colors.red),
                        ),
                      ),
                      iconTheme: const IconThemeData(color: Colors.white),
                      appBarTheme: const AppBarTheme(
                        backgroundColor: Color.fromRGBO(35, 35, 35, 1.0),
                        titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      bottomSheetTheme: const BottomSheetThemeData(
                        backgroundColor: Colors.transparent,
                        elevation: 3,
                      ),
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      timePickerTheme: const TimePickerThemeData(
                        backgroundColor: Color(0xFF1E1E1E),
                        hourMinuteTextColor: Color(0xFF1E1E1E),
                        hourMinuteColor: Colors.grey,
                        dayPeriodTextColor: Colors.white70,
                        dialBackgroundColor: Colors.black,
                        dialHandColor: Colors.white,
                        dialTextColor: Colors.white,
                        entryModeIconColor: Colors.white,
                        helpTextStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                      ),
                      textTheme: const TextTheme(
                        bodyMedium: TextStyle(color: Colors.white),
                      ),
                      hoverColor: Colors.transparent,
                    ),
                    initialRoute: RouteName.splashScreen,
                    onGenerateRoute: RouteConfig.generateRoute,
                  );
                },
          );
        },
      ),
    );
  }
}
