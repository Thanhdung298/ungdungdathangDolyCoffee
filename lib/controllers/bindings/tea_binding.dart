import 'package:get/instance_manager.dart';

import 'package:dolycoffee/controllers/tea_controller.dart';

class TeaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeaController());
  }
}
