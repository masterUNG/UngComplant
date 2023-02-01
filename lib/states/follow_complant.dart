import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/states/detail_complant.dart';
import 'package:ungcomplant/utility/app_constant.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_service.dart';
import 'package:ungcomplant/widgets/widget_text.dart';

class FollowComplant extends StatefulWidget {
  const FollowComplant({super.key});

  @override
  State<FollowComplant> createState() => _FollowComplantState();
}

class _FollowComplantState extends State<FollowComplant> {
  @override
  void initState() {
    super.initState();
    AppService().readAllComplants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WidgetText(text: 'ติดตาม และ สถานะเรื่อง'),
      ),
      body: GetX(
        init: AppController(),
        builder: (AppController appController) {
          print('complantModels --> ${appController.complantModels.length}');
          if (appController.userModels.isNotEmpty) {
            print('usermodel ---> ${appController.userModels.last.toMap()}');
          }
          return ListView.builder(
            itemCount: appController.complantModels.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                // bool result1 = appController.userModels.last.admin.value;
                print(
                    'appController.userModels.last.admin.value ===> ${appController.userModels.last.admin}');
                // print('result == $result1');
                if (appController.userModels.last.admin) {
                  Get.to(DetailComplant(
                    complantModel: appController.complantModels[index],
                    docIdComplant: appController.docIdComplants[index],
                  ))!
                      .then((value) => AppService().readAllComplants());
                } else {
                  Get.snackbar(
                      'สำหรับ Admin', 'Feture นี่สำหรับ Admin เท่านั้น',
                      backgroundColor: Colors.orange);
                }
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: WidgetText(
                            text: 'ชื่อเรื่อง :',
                            textStyle: AppConstant()
                                .defaultStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: WidgetText(
                              text: appController.complantModels[index].detail),
                        ),
                        Expanded(
                          flex: 1,
                          child:
                              appController.complantModels[index].status.isEmpty
                                  ? Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppConstant.redColor),
                                      child: WidgetText(
                                        text: 'รอรับเรื่อง',
                                        textStyle: AppConstant()
                                            .defaultStyle(color: Colors.white),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade700),
                                      child: WidgetText(
                                        text: appController
                                            .complantModels[index].status,
                                        textStyle: AppConstant()
                                            .defaultStyle(color: Colors.white),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: WidgetText(
                            text: 'ชนิดเรื่อง :',
                            textStyle: AppConstant()
                                .defaultStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: WidgetText(
                            text: appController
                                .complantModels[index].typeComplant,
                            textStyle:
                                AppConstant().defaultStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: WidgetText(
                            text: 'วันที่ :',
                            textStyle: AppConstant()
                                .defaultStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: WidgetText(
                              text: AppService().changDateTime(
                                  format: 'dd/MM/yyyy',
                                  dateTime: appController
                                      .complantModels[index].timestamp
                                      .toDate())),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: WidgetText(
                            text: 'เวลา :',
                            textStyle: AppConstant()
                                .defaultStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: WidgetText(
                              text: AppService().changDateTime(
                                  format: 'HH:mm',
                                  dateTime: appController
                                      .complantModels[index].timestamp
                                      .toDate())),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
