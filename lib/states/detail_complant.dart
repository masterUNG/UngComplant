// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:ungcomplant/models/complant_model.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/widgets/widget_button.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class DetailComplant extends StatefulWidget {
  const DetailComplant({
    Key? key,
    required this.complantModel,
    required this.docIdComplant,
  }) : super(key: key);

  final ComplantModel complantModel;
  final String docIdComplant;

  @override
  State<DetailComplant> createState() => _DetailComplantState();
}

class _DetailComplantState extends State<DetailComplant> {
  var newStatus = <String>[
    'กำลังดำเนินการ',
    'เสร็จสิ้นแล้ว',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(text: 'รายละเอียด (สำหรับ Admin)'),
      ),
      body: GetX(
          init: AppController(),
          builder: (AppController appController) {
            print('chooseStatus --> ${appController.chooseStatuss.length}');
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              children: [
                displayContent(
                    head: 'เรื่อง :', value: widget.complantModel.detail),
                displayContent(
                    head: 'ชนิด :', value: widget.complantModel.typeComplant),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 32),
                  width: 250,
                  height: 250,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.complantModel.geoPoint.latitude,
                            widget.complantModel.geoPoint.longitude),
                        zoom: 16),
                    onMapCreated: (controller) {},
                    markers: <Marker>{
                      Marker(
                          markerId: const MarkerId('value'),
                          position: LatLng(
                              widget.complantModel.geoPoint.latitude,
                              widget.complantModel.geoPoint.longitude))
                    },
                  ),
                ),
                displayContent(
                    head: 'Status :',
                    value: widget.complantModel.status!.isEmpty
                        ? 'รอรับเรื่อง'
                        : widget.complantModel.status!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 250,
                      child: DropdownButton(
                        hint: const WidgetText(text: 'โปรดเลือก Status ใหม่'),
                        items: newStatus
                            .map(
                              (e) => DropdownMenuItem(
                                child: WidgetText(text: e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) async {
                          appController.chooseStatuss.add(value);
                        },
                        value: appController.chooseStatuss.last,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetButton(
                      label: 'Save Status',
                      pressFunc: () async {
                        if (appController.chooseStatuss.length == 1) {
                          Get.snackbar('ย้งไม่มีการเลือก Status',
                              'โปรดเลือก Status ด้วย',
                              backgroundColor: Colors.orange.shade700,
                              colorText: Colors.white);
                        } else {
                          Map<String, dynamic> map =
                              widget.complantModel.toMap();
                          map['status'] = appController.chooseStatuss.last;

                          await FirebaseFirestore.instance
                              .collection('complant')
                              .doc(widget.docIdComplant)
                              .update(map)
                              .then((value) => Get.back());
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Row displayContent({required String head, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: WidgetText(
            text: head,
            textStyle: AppConstant().defaultStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: WidgetText(
            text: value,
            textStyle: AppConstant().defaultStyle(),
          ),
        ),
      ],
    );
  }
}
