import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/create_new_account.dart';
import 'package:ungcomplant/states/main_home.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_form.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const WidgetImage(
            size: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                text:
                    'แอพพลิเคชันการจัดการเรื่องร้องเรียน\nของที่ว่าการอำเภอบ่อทอง จังหวัดชลบุรี',
                textStyle: AppConstant()
                    .defaultStyle(size: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                hint: 'Email',
                changeFunc: (p0) {
                  email = p0.trim();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                hint: 'Password',
                obsceu: true,
                changeFunc: (p0) {
                  password = p0.trim();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetButton(
                label: 'เข้าสู่ระบบ',
                pressFunc: () async {
                  print('email --> $email, password --> $password');
                  if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                    Get.snackbar('มีช่องว่าง', 'กรุณากรอก ให้ครบทุกช่องสิคะ',
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email!, password: password!)
                        .then((value) => Get.offAll(const MainHome()))
                        .catchError((onError) {
                      Get.snackbar(onError.code, onError.message,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.lime);
                    });
                  }
                },
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetButton(
                label: 'ลงทะเบียน',
                pressFunc: () {
                  Get.to(const CreateNewAccount());
                },
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
