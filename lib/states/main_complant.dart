import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_form.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class MainComplant extends StatefulWidget {
  const MainComplant({super.key});

  @override
  State<MainComplant> createState() => _MainComplantState();
}

class _MainComplantState extends State<MainComplant> {
  var types = <String>[
    'ไฟฟ้าดับ',
    'น้ำไม่ไหล',
    'ไฟไหม้',
    'ถนนชำรุด',
    'ช้างป่า',
    'แจ้งเบาะแสการกระทำผิด (ยาเสพติด)',
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        AppService().processGetLocation(context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(text: 'เรื่องร้องทุกข์'),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('positions ==> ${appController.positions.length}');
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade500),
                  child: Row(
                    children: [
                      WidgetText(
                        text: 'ประเภทเรื่อง',
                        textStyle: AppConstant().defaultStyle(
                            size: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                RadioListTile(
                  value: types[0],
                  title: WidgetText(text: types[0]),
                  groupValue: appController.typeComplants.last,
                  onChanged: (value) {
                    appController.typeComplants.add(value);
                  },
                ),
                RadioListTile(
                  value: types[1],
                  title: WidgetText(text: types[1]),
                  groupValue: appController.typeComplants.last,
                  onChanged: (value) {
                    appController.typeComplants.add(value);
                  },
                ),
                RadioListTile(
                  value: types[2],
                  title: WidgetText(text: types[2]),
                  groupValue: appController.typeComplants.last,
                  onChanged: (value) {
                    appController.typeComplants.add(value);
                  },
                ),
                RadioListTile(
                  value: types[3],
                  title: WidgetText(text: types[3]),
                  groupValue: appController.typeComplants.last,
                  onChanged: (value) {
                    appController.typeComplants.add(value);
                  },
                ),
                RadioListTile(
                  value: types[4],
                  title: WidgetText(text: types[4]),
                  groupValue: appController.typeComplants.last,
                  onChanged: (value) {
                    appController.typeComplants.add(value);
                  },
                ),
                RadioListTile(
                  value: types[5],
                  title: WidgetText(text: types[5]),
                  groupValue: appController.typeComplants.last,
                  onChanged: (value) {
                    appController.typeComplants.add(value);
                  },
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade500),
                  child: Row(
                    children: [
                      WidgetText(
                        text: 'ข้อมูลผู้ร้องทุกข์',
                        textStyle: AppConstant().defaultStyle(
                            size: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                RadioListTile(
                  value: true,
                  title: WidgetText(text: 'ปกปิดข้อมูล'),
                  groupValue: appController.displayWhoComplants[0],
                  onChanged: (value) {
                    appController.displayWhoComplants[0] = value;
                  },
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade500),
                  child: Row(
                    children: [
                      WidgetText(
                        text: 'รายละเอียดคำร้อง',
                        textStyle: AppConstant().defaultStyle(
                            size: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                appController.positions.isEmpty
                    ? const SizedBox()
                    : Container(
                        width: 250,
                        height: 200,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  appController.positions.last.latitude,
                                  appController.positions.last.longitude),
                              zoom: 16),
                          onMapCreated: (controller) {},
                          markers: <Marker>{
                            Marker(
                                markerId: const MarkerId('value'),
                                position: LatLng(
                                    appController.positions.last.latitude,
                                    appController.positions.last.longitude))
                          },
                        ),
                      ),
                WidgetForm(
                  hint: 'รายละเอียด',
                  changeFunc: (p0) {},
                ),
                Container(margin: const EdgeInsets.only(top: 16,bottom: 32),
                  child: WidgetButton(
                    label: 'ส่งเรื่อง',
                    pressFunc: () {},
                  ),
                )
              ],
            );
          }),
    );
  }
}
