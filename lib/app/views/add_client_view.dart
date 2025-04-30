import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samwise/app/controllers/add_client_page_controller.dart';
import 'package:get/get.dart';

class AddClientView extends GetView<AddClientPageController> {
  @override
  Widget build(BuildContext context) {
    final _c = controller;

    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Cliente')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
        child: Align(
          alignment: Alignment.topCenter,
          // Centraliza o Card no centro da tela
          child: Card(
            elevation: 5, // Adiciona uma sombra para destacar o card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Bordas arredondadas
            ),
            child: Container(
              width: 400, // Largura fixa para o card (ajustável)
              height:
                  context.height * 0.6, // Altura fixa para o card (ajustável)
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _c.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _c.nameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Por favor, insira o nome do cliente'
                                  : null,
                    ),
                    TextFormField(
                      controller: _c.emailController,
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Por favor, insira o e-mail do cliente'
                                  : null,
                    ),
                    TextFormField(
                      controller: _c.phoneController,
                      decoration: const InputDecoration(labelText: 'Telefone'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Por favor, insira o telefone do cliente'
                                  : null,
                    ),
                    TextFormField(
                      controller: _c.addressController,
                      decoration: const InputDecoration(labelText: 'Endereço'),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Por favor, insira o Endereço do cliente'
                                  : null,
                    ),
                    TextFormField(
                      controller: _c.pointsController,
                      decoration: const InputDecoration(labelText: 'Pontos'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter
                            .digitsOnly, // Apenas números
                      ],
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Por favor, insira o valor dos pontos'
                                  : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _c.addClient,
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
