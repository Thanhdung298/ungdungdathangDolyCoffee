
import 'package:get/instance_manager.dart';

import 'package:dolycoffee/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
