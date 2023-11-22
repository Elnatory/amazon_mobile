import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/theme_manager.dart';
import 'package:amazon_mobile/presentation/screens/auth_view/login_view.dart';
import 'package:amazon_mobile/presentation/screens/auth_view/reg_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // defult constractor (unNamed Constractor / special constractor) :
  // const MyApp({super.key});
  // singleton constractor (Named Constractor) :
  //1:
  MyApp._internal();
 //2:
  static final MyApp _instance = MyApp._internal();
  //3:
  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Registeration(),
      theme: getThemData(),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      //   useMaterial3: true,
      // ),
      // theme: ThemeData.light().copyWith( scaffoldBackgroundColor: ColorManager.text),
    );
  }
}
