import 'package:e_commerce_app/routes/app_routes.dart';
import 'package:e_commerce_app/ui/splash_screen.dart';
import 'package:e_commerce_app/ui/user_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BuyBuzz',
        initialRoute: SplashScreen.path,
        routes: RoutesHelper.appRoutes,
      ),
    );
  }
}
