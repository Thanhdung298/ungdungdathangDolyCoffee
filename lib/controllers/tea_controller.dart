import 'package:get/get.dart';
import 'package:dolycoffee/models/drink_model.dart';
import '../consts/app_constants.dart';
import 'package:dolycoffee/dummy_data/dummy_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class TeaController extends GetxController {
  RxList<Drink> _teaList = <Drink>[].obs;

  RxList<Drink> get getteaList => _teaList;

  List<Map<String, dynamic>> teaList = [];

  @override
  void onInit() {
    super.onInit();
    // List<Drink> list = tealist;
    // _teaList.addAll(list);
    fetchDrinkTea();
  }

  Future<void> fetchDrinkTea() async {
    final response = await http.get(Uri.parse("http://localhost:3000/tea"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      teaList = jsonData.cast<Map<String, dynamic>>();
      addDataFromJson(jsonData);
    } else {
      throw Exception("Khong load duoc du lieu");
    }
  }

  void addDataFromJson(List<dynamic> jsonData) {
    _teaList.assignAll(jsonData.map((jsonItem) => Drink.fromMap(jsonItem)).toList());
  }

  navigateToOrderScreen(int index) {
    Get.toNamed(Appconstants.orderroute, arguments: _teaList[index]);
  }
}
