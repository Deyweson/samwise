import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samwise/app/bindings/client_detail_bindings.dart';
import 'package:samwise/app/data/client_model.dart';
import 'package:samwise/app/routes/app_routes.dart';
import 'package:samwise/app/views/client_detail_view.dart';

class ClientCard extends StatelessWidget {
  final ClientModel client;

  const ClientCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('${client.name} - ${client.points} pontos'),
        subtitle: Row(
          children: [
            Text('Email: ${client.email}'),
            const SizedBox(width: 8),
            Text('Telefone: ${client.phone}'),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          print('Client tapped: ${client.name}');
          Get.toNamed(AppRoutes.CLIENT, arguments: client);
        },
      ),
    );
  }
}
