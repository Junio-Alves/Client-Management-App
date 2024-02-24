import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/pages/new_cliente.dart';
import 'package:sqflite_estudo/provider/appBarProvider.dart';
import 'package:sqflite_estudo/provider/cliente_provider.dart';
import 'package:sqflite_estudo/widgets/userAppBar.dart';
import '../widgets/clienteCard.dart';

class ClienteListPage extends StatefulWidget {
  const ClienteListPage({super.key});

  @override
  State<ClienteListPage> createState() => ClienteListPageState();
}

class ClienteListPageState extends State<ClienteListPage> {
  final DB db = DB.intance;

  @override
  Widget build(BuildContext context) {
    final clienteprovider =
        Provider.of<ClienteProvider>(context, listen: false);
    final appBarprovider = Provider.of<AppBarProvider>(context);
    return Scaffold(
      appBar:
          appBarprovider.showNewAppBar ? userAppBar(context) : defaultAppBar(),
      body: FutureBuilder(
          future: clienteprovider.getClientes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: {$snapshot.error}"),
              );
            } else {
              return Consumer<ClienteProvider>(
                builder:
                    (BuildContext context, providerClientes, Widget? child) {
                  return providerClientes.cliente.isEmpty
                      ? const Center(
                          child: Text(
                            "Nenhum Cliente cadastrado!",
                            style: TextStyle(fontSize: 25),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: providerClientes.cliente.length,
                                  itemBuilder: (context, index) {
                                    Cliente cliente =
                                        providerClientes.cliente[index];
                                    return ClienteCard(cliente: cliente);
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: SizedBox(
                                height: 70,
                                width: 200,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const NovoCliente(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Adicionar cliente",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        );
                },
              );
            }
          }),
    );
  }

  appBarCliente(Cliente? appBarCliente) {
    appbarcliente!.nomeCompleto = appBarCliente!.nomeCompleto;
  }

  defaultAppBar() {
    return AppBar(
      title: const Text(
        "Clientes",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      backgroundColor: Colors.redAccent,
      centerTitle: true,
    );
  }
}
