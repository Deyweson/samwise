import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samwise/app/controllers/client_page_controller.dart';
import 'package:samwise/app/routes/app_routes.dart';

class ClientDetailView extends GetView<ClientDetailController> {
  const ClientDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = controller.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Cliente'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(result: true),
          tooltip: 'Voltar',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: controller.showEditPointsModal,
            tooltip: 'Editar Pontos',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: controller.showAddBuyModal,
            tooltip: 'Adicionar Compra',
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          client.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Obx(
                            () => Text(
                              '${controller.points.value} pts',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Telefone: ${client.phone}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${client.email}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Endereço: ${client.address}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Compras',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.buys.isEmpty) {
                return const Center(child: Text('Nenhuma compra encontrada.'));
              }
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width:
                      600, // Defina a largura do Container para controlar o espaço ocupado pela lista
                  child: ListView.builder(
                    shrinkWrap:
                        true, // Isso faz com que a ListView ocupe apenas o espaço necessário para os itens
                    itemCount: controller.buys.length,
                    itemBuilder: (context, index) {
                      final buy = controller.buys[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          title: Text(buy.description),
                          subtitle: Text('R\$ ${buy.value.toStringAsFixed(2)}'),
                          trailing: Text('${(buy.value ~/ 100 * 10)} pts'),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
