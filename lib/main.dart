import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/src/config/custom_router.dart';
import 'package:weather_app/src/config/di.dart';
import 'package:weather_app/src/config/app_theme.dart';
import 'package:weather_app/src/core/utils/app_colors.dart';
import 'package:weather_app/src/core/utils/app_utils.dart';
import 'package:weather_app/src/presentation/views/home/home_page.dart';
import 'package:weather_app/src/presentation/views/splash_screen.dart';
import 'package:weather_app/src/presentation/widgets/clock.dart';
import 'package:weather_icons/weather_icons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomeScreen(),
      onGenerateRoute: CustomRouter.onGenerateRoute,
      initialRoute: SplashScreen.routeName,
    );
  }
}
