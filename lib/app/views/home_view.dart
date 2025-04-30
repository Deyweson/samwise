import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samwise/app/controllers/home_controller.dart';
import 'package:samwise/app/routes/app_routes.dart';
import 'package:samwise/app/views/add_client_button.dart';
import 'package:samwise/app/views/client_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final _c = controller;

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
            // Centralizando a barra de pesquisa e o botão de adicionar
            Center(
              child: Row(
                mainAxisSize:
                    MainAxisSize
                        .min, // Garante que a Row ocupe apenas o necessário
                children: [
                  SizedBox(
                    width: 400, // Largura fixa para o campo de pesquisa
                    child: TextField(
                      controller: _c.searchController,
                      decoration: const InputDecoration(
                        hintText: 'Pesquisar Cliente...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _c.searchClients,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Get.toNamed(AppRoutes.ADD_CLIENT);
                      if (result == true) {
                        _c.loadClients(); // recarrega a lista ao voltar
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Centralizando a lista de clientes
            Expanded(
              child: Obx(() {
                if (_c.filteredClients.isEmpty) {
                  return const Center(child: Text('Nenhum cliente encontrado'));
                }
                return Align(
                  alignment: Alignment.topCenter,
                  // Centralizando a lista de clientes
                  child: SizedBox(
                    width: 700, // Ajuste a largura conforme necessário
                    child: ListView.builder(
                      itemCount: _c.filteredClients.length,
                      itemBuilder: (context, index) {
                        final client = _c.filteredClients[index];
                        return ClientCard(client: client);
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
