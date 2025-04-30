import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:samwise/app/controllers/home_controller.dart';
import 'package:samwise/app/data/buy_model.dart';
import 'package:samwise/app/data/client_model.dart';
import 'package:samwise/app/data/database_service.dart';
import 'package:samwise/app/routes/app_routes.dart';

class ClientDetailController extends GetxController {
  final ClientModel client;
  late final RxInt points;

  final buys = <BuyModel>[].obs;

  ClientDetailController(this.client) {
    points = client.points.obs;
  }

  @override
  void onInit() {
    super.onInit();
    loadBuy();
  }

  Future<void> loadBuy() async {
    final loadedBuys = await DatabaseService.instance.getBuysByClientId(
      client.id!,
    );
    buys.assignAll(loadedBuys);
  }

  Future<void> updateClientPoints(int clientId, int points) async {
    await DatabaseService.instance.updateClientPoints(clientId, points);
    // client.points = points;
  }

  void showAddBuyModal() {
    final _formKey = GlobalKey<FormState>();
    final descriptionController = TextEditingController();
    final valueController = TextEditingController();
    final pointsController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Adicionar Compra'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Insira a descrição da compra'
                            : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: 'Valor da compra (R\$)',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final parsedValue = double.tryParse(value);
                    if (parsedValue != null) {
                      final bonusPoints = (parsedValue ~/ 100) * 10;
                      pointsController.text = bonusPoints.toString();
                    } else {
                      pointsController.clear();
                    }
                  } else {
                    pointsController.clear();
                  }
                },
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Insira o valor da compra'
                            : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: pointsController,
                decoration: const InputDecoration(
                  labelText: 'Pontos da compra',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator:
                    (value) =>
                        value == null || value.trim().isEmpty
                            ? 'Insira os pontos da compra'
                            : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final description = descriptionController.text.trim();
                final double value =
                    double.tryParse(valueController.text) ?? 0.0;

                final bonusPoints = (value ~/ 100) * 10;
                points.value = client.points + bonusPoints;

                final buy = BuyModel(
                  clientId: client.id!,
                  description: description,
                  value: value,
                );

                await DatabaseService.instance.addBuy(buy);
                await updateClientPoints(client.id!, points.value);
                await loadBuy();

                Get.back();
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void showEditPointsModal() {
    final pointsController = TextEditingController(
      text: points.value.toString(),
    );

    Get.dialog(
      AlertDialog(
        title: const Text('Alterar Pontos'),
        content: TextField(
          controller: pointsController,
          decoration: const InputDecoration(labelText: 'Novo valor de pontos'),
          keyboardType: TextInputType.numberWithOptions(signed: true),
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              final newPoints =
                  int.tryParse(pointsController.text) ?? points.value;
              points.value = newPoints;

              // Atualiza também o client
              client.points = newPoints;
              await DatabaseService.instance.updateClient(client);

              await updateClientPoints(client.id!, newPoints);

              Get.back();
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
