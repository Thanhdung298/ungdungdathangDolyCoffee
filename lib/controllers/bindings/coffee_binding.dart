import 'package:get/instance_manager.dart';
import 'package:dolycoffee/controllers/coffee_controller.dart';


class CoffeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CoffeeController());
  }
}
