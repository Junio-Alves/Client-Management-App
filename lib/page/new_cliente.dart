import 'package:flutter/material.dart';
import '../helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

class NovoCliente extends StatelessWidget {
  const NovoCliente({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final nome = TextEditingController();
    final idade = TextEditingController();
    final DB db = DB.intance;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Cliente"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nome,
                    decoration: const InputDecoration(labelText: "Nome"),
                    validator: (nome) {
                      if (nome!.isEmpty) return "Digite um nome!";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: idade,
                    decoration: const InputDecoration(labelText: "Idade"),
                    validator: (idade) {
                      if (idade!.isEmpty) return "Digite uma idade!";
                      return null;
                    },
                  ),
                  const Divider(),
                  ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          Cliente novoCliente = Cliente(
                              nome: nome.text,
                              idade: int.tryParse(idade.text) ?? 0);
                          await db.insertCliente(novoCliente);
                          nome.clear();
                          idade.clear();
                        }
                      },
                      child: const Text("Salvar"))
                ],
              ))),
    );
  }
}
