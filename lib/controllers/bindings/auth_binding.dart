import 'package:get/get.dart';
import 'package:dolycoffee/controllers/auth_controller.dart';
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
