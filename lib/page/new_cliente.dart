import 'package:flutter/material.dart';
import '../helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

class NovoCliente extends StatelessWidget {
  const NovoCliente({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final nomeCompleto = TextEditingController();
    final dataNasc = TextEditingController();
    final celular = TextEditingController();
    final email = TextEditingController();
    final cep = TextEditingController();
    final logradouro = TextEditingController();
    final numero = TextEditingController();
    final cidade = TextEditingController();
    final observacao = TextEditingController();
    final DB db = DB.intance;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  child: SizedBox(
                    height: 150,
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        focusColor: Colors.transparent,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey),
                        ),
                      ),
                    ),
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
                  controller: nomeCompleto,
                  labelText: "nome",
                  errorText: "Digite um nome!",
                ),
                textForm(
                  controller: dataNasc,
                  labelText: "Data de Nascimento",
                  errorText: "Digite uma data de nascimento:",
                ),
                textForm(
                  controller: celular,
                  labelText: "Celular",
                  errorText: "Digite um numero de celular!",
                ),
                textForm(
                  controller: email,
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
                  controller: cep,
                  labelText: "CEP",
                  errorText: "Digite um Cep",
                ),
                textForm(
                  controller: logradouro,
                  labelText: "Logradouro",
                  errorText: "Digite um logradouro",
                ),
                textForm(
                  controller: numero,
                  labelText: "N°",
                  errorText: "Digite o numero da casa",
                ),
                textForm(
                    controller: cidade,
                    labelText: "Cidade",
                    errorText: "Digite uma cidade!"),
                textForm(
                  controller: observacao,
                  labelText: "Observação",
                  errorText: "Digite uma observação",
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            Cliente novoCliente = Cliente(
                              nomeCompleto: nomeCompleto.text,
                              dataNasc: dataNasc.text,
                              celular: celular.text,
                              email: email.text,
                              cep: int.tryParse(cep.text) ?? 0,
                              logradouro: logradouro.text,
                              numero: int.tryParse(numero.text) ?? 0,
                              cidade: cidade.text,
                              observacao: observacao.text,
                            );
                            await db.insertCliente(novoCliente);
                            nomeCompleto.clear();
                            dataNasc.clear();
                            celular.clear();
                            email.clear();
                            cep.clear();
                            logradouro.clear();
                            numero.clear();
                            cidade.clear();
                            observacao.clear();
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
}
