// import 'package:UNGolds/screens/Splashscreen/Splash_Screen.dart';
import 'package:UNGolds/screens/Splashscreen/Splash_Screen.dart';
import 'package:UNGolds/screens/bottom_navigation_bar.dart';
import 'package:UNGolds/screens/payment/phone_pay_page.dart';
import 'package:UNGolds/screens/profile_page/profile_onward.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'constant/printmessage.dart';
import 'constant/shared_pre.dart';
import 'screens/login_page/login_page.dart';
// import 'theme/app_theme.dart';
import 'theme/app_theme.dart';
import 'theme/theme_service.dart';

void main() async {
  await GetStorage.init();
  // await init();
  runApp(MyApp());
  // runApp(MaterialApp.router(
  //   routerConfig: router,
  // ));
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text('Splash Screen')),
      ),
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) => Scaffold(
            appBar: AppBar(title: Text(state.pathParameters['id'].toString())),
          ),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SplashScreen(),
    );
  }
}
