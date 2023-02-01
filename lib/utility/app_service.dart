// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ungcomplant/models/complant_model.dart';
import 'package:ungcomplant/models/user_model.dart';
import 'package:ungcomplant/utility/app_controller.dart';
import 'package:ungcomplant/utility/app_dialog.dart';
import 'package:ungcomplant/widgets/widget_button.dart';

class AppService {
  AppController appController = Get.put(AppController());

  Future<void> processReadUserModels() async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get()
        .then((value) {
      UserModel model = UserModel.fromMap(value.data()!);
      appController.userModels.add(model);
    });
  }

  String changDateTime({required String format, required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(dateTime);
  }

  Future<void> readAllComplants() async {
    if (appController.complantModels.isNotEmpty) {
      appController.complantModels.clear();
      appController.docIdComplants.clear();
    }

    await FirebaseFirestore.instance
        .collection('complant')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        ComplantModel model = ComplantModel.fromMap(element.data());
        appController.complantModels.add(model);
        appController.docIdComplants.add(element.id);
      }
    });
  }

  Future<void> processGetLocation({required BuildContext context}) async {
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
