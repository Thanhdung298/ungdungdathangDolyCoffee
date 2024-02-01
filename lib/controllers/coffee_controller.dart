import 'package:get/get.dart';
import 'package:dolycoffee/dummy_data/dummy_data.dart';

import '../consts/app_constants.dart';
import 'package:dolycoffee/models/drink_model.dart';
import '../view/screens/order_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class CoffeeController extends GetxController {
  RxList<Drink> _coffeeList = <Drink>[].obs;

  RxList<Drink> get getCoffeeList => _coffeeList;

  List<Map<String, dynamic>> coffeeList = [];

  @override
  void onInit() {
    super.onInit();
    // List<Drink> list = coffeelist;
    // _coffeeList.addAll(list);
    fetchDrinkCoffee();
  }

  Future<void> fetchDrinkCoffee() async {
    final response = await http.get(Uri.parse("http://localhost:3000/coffee"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      coffeeList = jsonData.cast<Map<String, dynamic>>();
      addDataFromJson(jsonData);
    } else {
      throw Exception("Khong load duoc du lieu");
    }
  }

  void addDataFromJson(List<dynamic> jsonData) {
    _coffeeList.assignAll(jsonData.map((jsonItem) => Drink.fromMap(jsonItem)).toList());
  }

  navigateToOrderScreen(int index) {
    Get.toNamed(Appconstants.orderroute, arguments: _coffeeList[index]);
  }
}
