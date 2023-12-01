import 'package:amazon_mobile/app/app.dart';
import 'package:amazon_mobile/data/network/dio_helper.dart';
import 'package:amazon_mobile/data/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:amazon_mobile/data/firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DioHelper.initDio();
  await GetStorage.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MyApp(),
    ),
  );
}
