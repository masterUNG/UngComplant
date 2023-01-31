import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/create_new_account.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_form.dart';
import 'package:ungcomplant/widgets/widget_image.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class Authen extends StatelessWidget {
  const Authen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          WidgetImage(
            size: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetText(
                  text:
                      'แอพพลิเคชันการจัดการเรื่องร้องเรียน\nของที่ว่าการอำเภอบ่อทอง จังหวัดชลบุรี'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                hint: 'User',
                changeFunc: (p0) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WidgetForm(
                hint: 'Password',
                obsceu: true,
                changeFunc: (p0) {},
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
                pressFunc: () {},
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
                pressFunc: () {
                  Get.to(const CreateNewAccount());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
