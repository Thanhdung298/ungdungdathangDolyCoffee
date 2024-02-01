
import 'package:get/get.dart';

import 'package:dolycoffee/controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MySearchController());
  }
}