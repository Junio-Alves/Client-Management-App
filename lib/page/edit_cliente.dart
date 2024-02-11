import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/provider/cliente_provider.dart';
import 'package:sqflite_estudo/widgets/userAppBar.dart';

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

  @override
  void initState() {
    super.initState();
    _nome.text = widget.cliente.nome;
    _idade.text = widget.cliente.idade.toString();
  }

  @override
  Widget build(BuildContext context) {
    final clienteprovider =
        Provider.of<ClienteProvider>(context, listen: false);
    String appBartitle = widget.cliente.nome;
    return Scaffold(
      appBar: AppBar(
        title: Text(appBartitle),
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
              const Divider(),
              ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      Cliente updatedCliente = Cliente(
                          nome: _nome.text,
                          idade: int.tryParse(_idade.text) ?? 0);

                      await db.updateCliente(
                          updatedCliente, widget.cliente.id!);
                      setState(() {
                        appBartitle = updatedCliente.nome;
                        appbarcliente = updatedCliente;
                      });
                    }
                    //Atualiza o nome na appBar
                    //Atualiza a lista de clientes na homepage
                    clienteprovider.getClientes();
                  },
                  child: const Text("Salvar"))
            ],
          ),
        ),
      ),
    );
  }
}
