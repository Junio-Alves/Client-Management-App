import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/provider/appBarProvider.dart';
import 'package:sqflite_estudo/provider/cliente_provider.dart';
import 'package:sqflite_estudo/widgets/userAppBar.dart';
import '../widgets/clienteCard.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => ClientePageState();
}

class ClientePageState extends State<ClientePage> {
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
                  return ListView.builder(
                      itemCount: providerClientes.cliente.length,
                      itemBuilder: (context, index) {
                        Cliente cliente = providerClientes.cliente[index];
                        return ClienteCard(cliente: cliente);
                      });
                },
              );
            }
          }),
    );
  }

  appBarCliente(Cliente? appBarCliente) {
    appbarcliente!.nome = appBarCliente!.nome;
    appbarcliente!.idade = appbarcliente!.idade;
  }

  defaultAppBar() {
    return AppBar(
      title: const Text("Cliente"),
    );
  }
}
