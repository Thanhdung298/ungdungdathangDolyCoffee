import 'package:get/instance_manager.dart';
import 'package:dolycoffee/controllers/juice_controller.dart';


class JuiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JuiceController());
  }
}
