import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/authen.dart';
import 'package:ungcomplant/utility/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
   runApp(const MyApp());
  });

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstant.redColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: Authen(),
    );
  }
}
