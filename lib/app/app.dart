import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:amazon_mobile/presentation/layout/screen_layout.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/screens/auth_view/login_view.dart';
import 'package:amazon_mobile/presentation/screens/auth_view/reg_view.dart';
import 'package:amazon_mobile/presentation/screens/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  // defult constractor (unNamed Constractor / special constractor) :
  // const MyApp({super.key});
  // singleton constractor (Named Constractor) :
  //1:
  const MyApp._internal();
 //2:
  static const MyApp _instance = MyApp._internal();
  //3:
  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home:  const Scaffold(
          backgroundColor: ColorManager.text,
          body: ScreenLayout()
        ),
        // theme: getThemData(),
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        //   useMaterial3: true,
        // ),
        theme: ThemeData.light().copyWith( scaffoldBackgroundColor: Colors.transparent),
      ),
    );
  }
}
