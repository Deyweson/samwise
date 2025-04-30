import 'package:get/get.dart';
import 'package:samwise/app/controllers/home_controller.dart';

class HomeViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
