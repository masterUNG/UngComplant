import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/authen.dart';
import 'package:ungcomplant/states/list_shop_food.dart';
import 'package:ungcomplant/states/list_travel.dart';
import 'package:ungcomplant/states/main_complant.dart';
import 'package:ungcomplant/states/main_home.dart';
import 'package:ungcomplant/states/suggest_page.dart';
import 'package:ungcomplant/utility/app_constant.dart';

var getPages = <GetPage<dynamic>>[
  GetPage(
    name: '/authen',
    page: () => const Authen(),
  ),
  GetPage(
    name: '/mainHome',
    page: () => const MainHome(),
  ),
  GetPage(
    name: '/item1',
    page: () => const MainComplant(),
  ),
  GetPage(
    name: '/item2',
    page: () => const ListShopFood(),
  ),
  GetPage(
    name: '/item3',
    page: () => const ListTravel(),
  ),
  GetPage(
    name: '/item4',
    page: () => const SuggestPage(),
  ),
];

String initialRoute = '/authen';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        initialRoute = '/mainHome';
      }
    });

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstant.redColor,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      getPages: getPages,
      initialRoute: initialRoute,
    );
  }
}
