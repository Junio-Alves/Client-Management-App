import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/provider/cliente_provider.dart';
import 'package:sqflite_estudo/widgets/userAppBar.dart';

class EditCliente extends StatefulWidget {
  const EditCliente({super.key});

  @override
  State<EditCliente> createState() => _EditClienteState();
}

class _EditClienteState extends State<EditCliente> {
  final formkey = GlobalKey<FormState>();
  final _nomeCompleto = TextEditingController();
  final _dataNasc = TextEditingController();
  final _celular = TextEditingController();
  final _email = TextEditingController();
  final _cep = TextEditingController();
  final _logradouro = TextEditingController();
  final _numero = TextEditingController();
  final _cidade = TextEditingController();
  final _observacao = TextEditingController();
  final DB db = DB.intance;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    final cliente = ModalRoute.of(context)!.settings.arguments as Cliente;
    super.initState();
    _nomeCompleto.text = cliente.nomeCompleto;
    _dataNasc.text = cliente.dataNasc;
    _celular.text = cliente.celular;
    _email.text = cliente.email;
    _cep.text = cliente.cep.toString();
    _logradouro.text = cliente.logradouro;
    _numero.text = cliente.numero.toString();
    _cidade.text = cliente.cidade;
    _observacao.text = cliente.observacao;
  }

  @override
  Widget build(BuildContext context) {
    final cliente = ModalRoute.of(context)!.settings.arguments as Cliente;
    final clienteprovider =
        Provider.of<ClienteProvider>(context, listen: false);
    String appBartitle = cliente.nomeCompleto;
    File imageFile = File(cliente.imagePath);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBartitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey[200],
                      child: CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: FileImage(imageFile)),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Informações Pessoais:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                textForm(
                  controller: _nomeCompleto,
                  labelText: "nome",
                  errorText: "Digite um nome!",
                ),
                textForm(
                  controller: _dataNasc,
                  labelText: "Data de Nascimento",
                  errorText: "Digite uma data de nascimento:",
                ),
                textForm(
                  controller: _celular,
                  labelText: "Celular",
                  errorText: "Digite um numero de celular!",
                ),
                textForm(
                  controller: _email,
                  labelText: "Email",
                  errorText: "Digite um email valido:",
                ),
                const Text(
                  "Endereço:",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                textForm(
                  controller: _cep,
                  labelText: "CEP",
                  errorText: "Digite um Cep",
                ),
                textForm(
                  controller: _logradouro,
                  labelText: "Logradouro",
                  errorText: "Digite um logradouro",
                ),
                textForm(
                  controller: _numero,
                  labelText: "N°",
                  errorText: "Digite o numero da casa",
                ),
                textForm(
                    controller: _cidade,
                    labelText: "Cidade",
                    errorText: "Digite uma cidade!"),
                textForm(
                  controller: _observacao,
                  labelText: "Observação",
                  errorText: "Digite uma observação",
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        Cliente updatedCliente = Cliente(
                          nomeCompleto: _nomeCompleto.text,
                          dataNasc: _dataNasc.text,
                          celular: _celular.text,
                          email: _email.text,
                          cep: int.tryParse(_cep.text) ?? 0,
                          logradouro: _logradouro.text,
                          numero: int.tryParse(_numero.text) ?? 0,
                          cidade: _cidade.text,
                          observacao: _observacao.text,
                          imagePath: imageFile.path,
                        );

                        await db.updateCliente(updatedCliente, cliente.id!);
                        setState(() {
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
      ),
    );
  }

  Widget textForm({
    required TextEditingController controller,
    required String labelText,
    required String errorText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        validator: (validator) {
          if (validator!.isEmpty) return errorText;
          return null;
        },
      ),
    );
  }
}
