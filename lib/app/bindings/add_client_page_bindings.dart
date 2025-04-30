import 'package:get/get.dart';
import 'package:samwise/app/controllers/add_client_page_controller.dart';

class AddClientPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddClientPageController>(() => AddClientPageController());
  }
}
