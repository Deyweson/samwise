import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samwise/app/data/client_model.dart';
import 'package:samwise/app/data/database_service.dart';
import 'package:samwise/app/views/add_client_view.dart';

class HomeController extends GetxController {
  final searchController = TextEditingController();
  var clients = <ClientModel>[].obs;
  var filteredClients = <ClientModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadClients();
  }

  Future<void> loadClients() async {
    final loadedClients = await DatabaseService.instance.getAllclients();
    clients.assignAll(loadedClients);
    filteredClients.assignAll(loadedClients);
  }

  void searchClients(String query) {
    if (query.isEmpty) {
      filteredClients.assignAll(clients);
    } else {
      filteredClients.assignAll(
        clients.where(
          (client) => client.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  void addClient() {
    Get.to(() => const AddClientView());
  }
}
