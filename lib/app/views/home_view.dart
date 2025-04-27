import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samwise/app/controllers/home_controller.dart';
import 'package:samwise/app/views/add_client_button.dart';
import 'package:samwise/app/views/client_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Samwise',
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar Cliente...',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: controller.searchClients,
                  ),
                ),
                const SizedBox(width: 10),
                AddClientButton(onPressed: controller.addClient),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.filteredClients.isEmpty) {
                  return const Center(child: Text('Nenhum cliente encontrado'));
                }
                return ListView.builder(
                  itemCount: controller.filteredClients.length,
                  itemBuilder: (context, index) {
                    final client = controller.filteredClients[index];
                    return ClientCard(client: client);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
