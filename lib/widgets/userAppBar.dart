import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/page/cliente_page.dart';
import 'package:sqflite_estudo/page/edit_cliente.dart';
import 'package:sqflite_estudo/provider/appBarProvider.dart';

Widget userAppBar(BuildContext context) {
  final DB db = DB.intance;
  final appBarprovider = Provider.of<AppBarProvider>(context, listen: false);
  return AppBar(
    title: Text(appbarcliente!.nome),
    leading: IconButton(
        onPressed: () {
          appBarprovider.setFalse();
        },
        icon: const Icon(Icons.arrow_back)),
    actions: [
      IconButton(
          onPressed: () {
            db.deleteCliente(appbarcliente!);
            appBarprovider.setFalse();
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
