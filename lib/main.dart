import 'package:amazon_mobile/app/app.dart';
import 'package:amazon_mobile/data/network/dio_helper.dart';
import 'package:amazon_mobile/data/provider/app_provider.dart';
// import 'package:amazon_mobile/presentation/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:amazon_mobile/data/firebase_options.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
// import 'package:get_storage/get_storage.dart';

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
