import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samwise/app/controllers/home_controller.dart';
import 'package:samwise/app/data/client_model.dart';
import 'package:samwise/app/data/database_service.dart';
import 'package:get/get.dart';

class AddClientView extends StatefulWidget {
  const AddClientView({super.key});

  @override
  State<AddClientView> createState() => _AddClientViewState();
}

class _AddClientViewState extends State<AddClientView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pointsController = TextEditingController(
    text: '0',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Por favor, insira o nome do cliente'
                            : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Por favor, insira o e-mail do cliente'
                            : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Por favor, insira o telefone do cliente'
                            : null,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Por favor, insira o Endereço do cliente'
                            : null,
              ),
              TextFormField(
                controller: pointsController,
                decoration: const InputDecoration(labelText: 'Pontos'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Apenas números serão aceitos
                ],
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Por favor, insira o valor dos pontos'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addClient,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addClient() async {
    if (_formKey.currentState!.validate()) {
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
        address: '',
        points: points,
      );
      final databaseService = DatabaseService();
      await databaseService.insertClient(client);

      Get.find<HomeController>().loadClients();
      Get.back();
    }
  }
}
