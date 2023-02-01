import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/follow_complant.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_icon_button.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var paths = <String>[
    'images/item1.png',
    'images/item2.png',
    'images/item3.png',
    'images/item4.png',
  ];

  var navivators = <String>[
    '/item1',
    '/item2',
    '/item3',
    '/item4',
  ];

  @override
  void initState() {
    super.initState();
    AppService().processReadUserModels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          WidgetIconButton(
            iconData: Icons.exit_to_app,
            pressFunc: () async {
              await FirebaseAuth.instance
                  .signOut()
                  .then((value) => Get.offAllNamed('/authen'));
            },
            color: AppConstant.redColor,
          )
        ],
      ),
      body: ListView(
        children: [
          const WidgetImage(
            size: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                text: '   ศูนย์รับเรื่องร้องเรียน\nของที่ว่าการอำเภอบ่อทอง',
                textStyle: AppConstant()
                    .defaultStyle(size: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  label: 'ติดตามเรื่อง',
                  pressFunc: () {
                    Get.to(const FollowComplant());
                  },
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: paths.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(navivators[index]);
              },
              child: WidgetImage(
                path: paths[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
