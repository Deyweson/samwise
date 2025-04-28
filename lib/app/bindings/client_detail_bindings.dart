import 'package:get/get.dart';
import 'package:samwise/app/controllers/client_page_controller.dart';

class ClientDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientDetailController>(
      () => ClientDetailController(Get.arguments),
    );
  }
}
