import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

class ClientePage extends StatefulWidget {
  final Cliente cliente;
  const ClientePage({super.key, required this.cliente});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  @override
  Widget build(BuildContext context) {
    File imageFile = File(widget.cliente.imagePath);
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Client"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(imageFile),
                    radius: 100,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.cliente.nomeCompleto,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dados Pessoais:",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Data de Nascimento: ${widget.cliente.dataNasc}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Celular: ${widget.cliente.celular}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Email: ${widget.cliente.email}",
                style: const TextStyle(fontSize: 20),
              ),
              const Text(
                "Endereço:",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "CEP: ${widget.cliente.cep}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Logradouro ${widget.cliente.logradouro}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Nº: ${widget.cliente.numero}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Cidade: ${widget.cliente.cidade}",
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                "Observações ${widget.cliente.observacao}",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}
