import 'package:amazon_mobile/presentation/layout/screen_layout.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flutter/services.dart';

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
    return GetMaterialApp(
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
    );
  }
}
