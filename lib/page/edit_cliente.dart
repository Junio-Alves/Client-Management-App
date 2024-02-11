import 'package:flutter/material.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/page/cliente_page.dart';

class EditCliente extends StatefulWidget {
  final Cliente cliente;
  const EditCliente({super.key, required this.cliente});

  @override
  State<EditCliente> createState() => _EditClienteState();
}

class _EditClienteState extends State<EditCliente> {
  final _nome = TextEditingController();
  final _idade = TextEditingController();
  final DB db = DB.intance;
  final _formkey = GlobalKey<FormState>();
  late Cliente updatedCliente;

  @override
  void initState() {
    super.initState();
    _nome.text = widget.cliente.nome;
    _idade.text = widget.cliente.idade.toString();
  }

  @override
  Widget build(BuildContext context) {
    updatecliente() {
      if (mounted) {
        context
            .findAncestorStateOfType<ClientePageState>()!
            .appBarCliente(updatedCliente);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cliente.nome),
      ),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nome,
                    decoration: const InputDecoration(labelText: "Nome"),
                    validator: (nome) {
                      if (nome!.isEmpty) return "Digite um nome!";
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _idade,
                    decoration: const InputDecoration(labelText: "Idade"),
                    validator: (idade) {
                      if (idade!.isEmpty) return "Digite um nome!";
                      return null;
                    },
                  ),
                  Divider(),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          updatedCliente = Cliente(
                              nome: _nome.text,
                              idade: int.tryParse(_idade.text) ?? 0);
                          await db.updateCliente(
                              updatedCliente, widget.cliente.id!);
                          _nome.clear();
                          _idade.clear();
                          setState(() {
                            widget.cliente.nome = updatedCliente.nome;
                            widget.cliente.idade = updatedCliente.idade;
                          });
                        }
                        updatecliente;
                      },
                      child: const Text("Salvar"))
                ],
              ))),
    );
  }
}
