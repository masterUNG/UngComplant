import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/models/user_model.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_form.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  String? email, password, name, surName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(text: 'ลงทะเบียน'),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('gendles ---> ${appController.gendles.length}');
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                WidgetText(
                  text: 'อีเมล์ในการเข้าสู่ระบบ',
                  textStyle: AppConstant()
                      .defaultStyle(size: 18, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Email :',
                      changeFunc: (p0) {
                        email = p0.trim();
                      },
                    ),
                  ],
                ),
                WidgetText(
                  text: 'รหัสผ่าน*ใช้อีเมล์ในการเข้าสู่ระบบ',
                  textStyle: AppConstant()
                      .defaultStyle(size: 18, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Password :',
                      // obsceu: true,
                      changeFunc: (p0) {
                        password = p0.trim();
                      },
                    ),
                  ],
                ),
                WidgetText(
                  text: 'เพศ',
                  textStyle: AppConstant()
                      .defaultStyle(size: 18, fontWeight: FontWeight.w500),
                ),
                RadioListTile(
                  value: 'male',
                  groupValue: appController.gendles.isEmpty
                      ? null
                      : appController.gendles.last,
                  onChanged: (value) {
                    appController.gendles.add(value);
                  },
                  title: const WidgetText(text: 'ชาย'),
                ),
                RadioListTile(
                  value: 'female',
                  groupValue: appController.gendles.isEmpty
                      ? null
                      : appController.gendles.last,
                  onChanged: (value) {
                    appController.gendles.add(value);
                  },
                  title: const WidgetText(text: 'หญิง'),
                ),
                WidgetText(
                  text: 'ชื่อ',
                  textStyle: AppConstant()
                      .defaultStyle(size: 18, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'Name :',
                      changeFunc: (p0) {
                        name = p0.trim();
                      },
                    ),
                  ],
                ),
                WidgetText(
                  text: 'นามสกุล',
                  textStyle: AppConstant()
                      .defaultStyle(size: 18, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetForm(
                      hint: 'SurName :',
                      changeFunc: (p0) {
                        surName = p0.trim();
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
                      label: 'ลงทะเบียน',
                      pressFunc: () async {
                        if ((email?.isEmpty ?? true) ||
                            (password?.isEmpty ?? true) ||
                            (name?.isEmpty ?? true) ||
                            (surName?.isEmpty ?? true)) {
                          Get.snackbar(
                              'มีช่องว่าง', 'กรุณากรอก ให้ครบทุกช่องสิคะ',
                              snackPosition: SnackPosition.BOTTOM);
                        } else if (appController.gendles.isEmpty) {
                          Get.snackbar('ยังไม่มีการเลือกเพศ',
                              'กรุณา เลือกเพศ ชาย หรือ หญิงด้วยคะ',
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: email!, password: password!)
                              .then((value) async {
                            String uid = value.user!.uid;
                            UserModel model = UserModel(
                                email: email!,
                                password: password!,
                                gendle: appController.gendles.last,
                                name: name!,
                                surname: surName!);

                            await FirebaseFirestore.instance
                                .collection('user')
                                .doc(uid)
                                .set(model.toMap())
                                .then((value) {
                              Get.back();
                            });
                          }).catchError((onError) {
                            Get.snackbar(onError.code, onError.message,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.lime);
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
