import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dolycoffee/models/drink_model.dart';
import 'package:dolycoffee/dummy_data/dummy_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySearchController extends GetxController {
  RxList<Drink> _alldrinkslist = <Drink>[].obs;
  RxList<Drink> coffeelist = <Drink>[].obs;
  RxList<Drink> juicelist = <Drink>[].obs;
  RxList<Drink> tealist = <Drink>[].obs;
  // RxList<Drink> _alldrinkslist = [...coffeelist, ...juicelist, ...tealist].obs;
  List<Drink> searchedfordrinks = [];

  List<Drink> getsearchedlist(userInputValue) {
    searchedfordrinks = _alldrinkslist
        .where(
            (e) => e.name.toLowerCase().contains(userInputValue.toLowerCase()))
        .toList();
    return searchedfordrinks;
  }

  @override
  void onInit() async {
    super.onInit();
    await Future.wait([
      fetchDrinkCoffee(),
      fetchDrinkJuice(),
      fetchDrinkTea(),
    ]);
    print(_alldrinkslist.length);
  }

  Future<void> fetchDrinkCoffee() async {
    final response = await http.get(Uri.parse("http://localhost:3000/coffee"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      addDataFromJson(jsonData, coffeelist);
      _alldrinkslist.addAll(coffeelist);
    } else {
      throw Exception("Khong load duoc du lieu");
    }
  }

  Future<void> fetchDrinkJuice() async {
    final response = await http.get(Uri.parse("http://localhost:3000/juice"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      addDataFromJson(jsonData, juicelist);
      _alldrinkslist.addAll(juicelist);
    } else {
      throw Exception("Khong load duoc du lieu");
    }
  }

  Future<void> fetchDrinkTea() async {
    final response = await http.get(Uri.parse("http://localhost:3000/tea"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      addDataFromJson(jsonData, tealist);
      _alldrinkslist.addAll(tealist);
    } else {
      throw Exception("Khong load duoc du lieu");
    }
  }

  void addDataFromJson(List<dynamic> jsonData, RxList<Drink> drinkList) {
    drinkList.assignAll(jsonData.map((jsonItem) => Drink.fromMap(jsonItem)).toList());
  }
}
