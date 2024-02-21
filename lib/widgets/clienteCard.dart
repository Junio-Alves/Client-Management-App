import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
import 'package:sqflite_estudo/pages/cliente_page.dart';
import 'package:sqflite_estudo/widgets/userAppBar.dart';
import '../provider/appBarProvider.dart';

class ClienteCard extends StatefulWidget {
  final Cliente cliente;
  const ClienteCard({super.key, required this.cliente});

  @override
  State<ClienteCard> createState() => _ClienteCardState();
}

class _ClienteCardState extends State<ClienteCard> {
  final DB db = DB.intance;
  @override
  Widget build(BuildContext context) {
    File imageFile = File(widget.cliente.imagePath);
    final appBarprovider = Provider.of<AppBarProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ClientePage(
                cliente: widget.cliente,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: FileImage(imageFile),
                radius: 50,
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cliente.nomeCompleto,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Numero: ${widget.cliente.celular}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )),
              IconButton(
                  onPressed: () {
                    appBarprovider.setTrue();
                    appbarcliente = widget.cliente;
                  },
                  icon: const Icon(Icons.more_vert)),
            ],
          ),
        ),
      ),
    );
  }
}
