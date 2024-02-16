import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

class NovoCliente extends StatefulWidget {
  const NovoCliente({super.key});

  @override
  State<NovoCliente> createState() => _NovoClienteState();
}

File? imageFile;

class _NovoClienteState extends State<NovoCliente> {
  //Controllers
  final _formkey = GlobalKey<FormState>();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.grey[200],
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: imageFile != null
                                  ? FileImage(imageFile!)
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: IconButton(
                                onPressed: () {
                                  popUpImage(context);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            Cliente novoCliente = Cliente(
                              nomeCompleto: _nomeCompleto.text,
                              dataNasc: _dataNasc.text,
                              celular: _celular.text,
                              email: _email.text,
                              cep: int.tryParse(_cep.text) ?? 0,
                              logradouro: _logradouro.text,
                              numero: int.tryParse(_numero.text) ?? 0,
                              cidade: _cidade.text,
                              observacao: _observacao.text,
                              imagePath: imageFile != null
                                  ? imageFile!.path
                                  : "assets/profile/user.png",
                            );
                            await db.insertCliente(novoCliente);
                            _nomeCompleto.clear();
                            _dataNasc.clear();
                            _celular.clear();
                            _email.clear();
                            _cep.clear();
                            _logradouro.clear();
                            _numero.clear();
                            _cidade.clear();
                            _observacao.clear();
                            setState(() {
                              imageFile = null;
                            });
                          }
                        },
                        child: const Text("Salvar")),
                  ],
                )
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

  void popUpImage(BuildContext context) {
    final imagePicker = ImagePicker();

    pick(ImageSource source) async {
      final pickedFile = await imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Selecionar foto"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    pick(ImageSource.camera);
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt_outlined),
                    Text("Camera"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    pick(ImageSource.gallery);
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.image),
                    Text("Galeria"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    imageFile = null;
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.delete),
                    Text("Remover"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
