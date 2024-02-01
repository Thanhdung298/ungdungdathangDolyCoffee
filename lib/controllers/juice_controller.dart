import 'package:get/get.dart';
import 'package:dolycoffee/dummy_data/dummy_data.dart';

import '../consts/app_constants.dart';
import 'package:dolycoffee/models/drink_model.dart';
import '../view/screens/order_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class JuiceController extends GetxController {
  RxList<Drink> _juiceList = <Drink>[].obs;

  RxList<Drink> get getjuiceList => _juiceList;

  List<Map<String, dynamic>> juiceList = [];

  @override
  void onInit() {
    super.onInit();
    // List<Drink> list = juicelist;
    // _juiceList.addAll(list);
    fetchDrinkJuice();
  }

  Future<void> fetchDrinkJuice() async {
    final response = await http.get(Uri.parse("http://localhost:3000/juice"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      juiceList = jsonData.cast<Map<String, dynamic>>();
      addDataFromJson(jsonData);
    } else {
      throw Exception("Khong load duoc du lieu");
    }
  }

  void addDataFromJson(List<dynamic> jsonData) {
    _juiceList.assignAll(jsonData.map((jsonItem) => Drink.fromMap(jsonItem)).toList());
  }

  navigateToOrderScreen(int index) {
    Get.toNamed(Appconstants.orderroute, arguments: _juiceList[index]);
  }
}
