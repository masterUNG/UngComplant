import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AppController extends GetxController {

  RxList gendles = <String>[].obs;
  RxList typeComplants = <String?>[null].obs;
  RxList displayWhoComplants = <bool>[false].obs;
  RxList positions = <Position>[].obs;
  
}