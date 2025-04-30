import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samwise/app/data/client_model.dart';
import 'package:samwise/app/data/database_service.dart';
import 'package:samwise/app/routes/app_routes.dart';

class AddClientPageController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pointsController = TextEditingController(
    text: '0',
  );

  @override
  void onInit() {
    super.onInit();
  }

  void addClient() async {
    if (formKey.currentState!.validate()) {
      final name = nameController.text;
      final email = emailController.text;
      final phone = phoneController.text;
      final points =
          pointsController.text.isNotEmpty
              ? int.parse(pointsController.text)
              : 0;

      final ClientModel client = ClientModel(
        name: name,
        email: email,
        phone: phone,
        address: addressController.text, // Adicionando o endereço
        points: points,
      );
      await DatabaseService.instance.insertClient(client);

      Get.back(result: true);

      Get.snackbar(
        'Sucesso',
        'Cliente adicionado com sucesso!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
        shouldIconPulse: false,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        borderColor: Colors.green,
        borderWidth: 2,
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
