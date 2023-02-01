import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ungcomplant/models/complant_model.dart';
import 'package:ungcomplant/models/user_model.dart';

class AppController extends GetxController {

  RxList gendles = <String>[].obs;
  RxList typeComplants = <String?>[null].obs;
  RxList displayWhoComplants = <bool>[false].obs;
  RxList positions = <Position>[].obs;
  RxList complantModels = <ComplantModel>[].obs;
  RxList docIdComplants = <String>[].obs;
  RxList userModels = <UserModel>[].obs;
  RxList chooseStatuss = <String?>[null].obs;
  
}