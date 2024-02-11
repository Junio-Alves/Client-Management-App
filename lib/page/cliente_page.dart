import 'package:flutter/material.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/page/edit_cliente.dart';
import '../widgets/clienteCard.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => ClientePageState();
}

bool showNewAppBar = false;
Cliente? appbarcliente;

class ClientePageState extends State<ClientePage> {
  final DB db = DB.intance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showNewAppBar ? newAppBar(context) : defaultAppBar(),
      body: FutureBuilder<List<Cliente>>(
          future: db.getCliente(),
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
              List<Cliente>? clientes = snapshot.data;
              return ListView.builder(
                  itemCount: clientes?.length ?? 0,
                  itemBuilder: (context, index) {
                    Cliente cliente = clientes![index];
                    return ClienteCard(cliente: cliente);
                  });
            }
          }),
    );
  }

  appBarCliente(Cliente? appBarCliente) {
    setState(() {
      appbarcliente!.nome = appBarCliente!.nome;
      appbarcliente!.idade = appbarcliente!.idade;
    });
  }

  acctiveNewAppBar() {
    setState(() {
      showNewAppBar = true;
    });
  }

  newAppBar(context) {
    return AppBar(
      title: Text(appbarcliente!.nome),
      leading: IconButton(
          onPressed: () {
            setState(() {
              showNewAppBar = false;
            });
          },
          icon: Icon(Icons.arrow_back)),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                db.deleteCliente(appbarcliente!);
                showNewAppBar = false;
              });
            },
            icon: const Icon(Icons.delete)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditCliente(cliente: appbarcliente!)));
            },
            icon: const Icon(Icons.edit))
      ],
    );
  }

  defaultAppBar() {
    return AppBar(
      title: Text("Cliente"),
    );
  }
}
