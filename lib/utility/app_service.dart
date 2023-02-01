// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_dialog.dart';
import 'package:ungcomplant/widgets/widget_button.dart';

class AppService {
  Future<void> processGetLocation({required BuildContext context}) async {
    AppController appController = Get.put(AppController());
    bool locationServiceEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;

    if (locationServiceEnable) {
      //open Service
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        //ไม่อนุญาติเลย
        processOpenPermission(context: context);
      } else {
        if (locationPermission == LocationPermission.denied) {
          locationPermission = await Geolocator.requestPermission();
          if ((locationPermission != LocationPermission.whileInUse) &&
              (locationPermission != LocationPermission.always)) {
            processOpenPermission(context: context);
          } else {
            //Ok
            await Geolocator.getCurrentPosition().then((value) {
              appController.positions.add(value);
            });
          }
        } else {
          //OK Can find Location
           await Geolocator.getCurrentPosition().then((value) {
              appController.positions.add(value);
            });
        }
      }
    } else {
      AppDialog(context: context).normalDialog(
          title: 'ยังไม่เปิด Location',
          detail: 'กรุณาเปิด Location ด้วยคะ',
          actionFunc: WidgetButton(
            label: 'เปิด Location',
            pressFunc: () {
              Geolocator.openLocationSettings();
              exit(0);
            },
          ));
    }
  }

  void processOpenPermission({required BuildContext context}) {
    AppDialog(context: context).normalDialog(
        title: 'ไม่อนุญาติแชร์พิกัด',
        detail: 'กรุณาเปิดการแชร์พิกัดด้วย คะ',
        actionFunc: WidgetButton(
          label: 'เปิดแชร์พิกัด',
          pressFunc: () {
            Geolocator.openAppSettings();
            exit(0);
          },
        ));
  }
}
