import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';
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
    final appBarprovider = Provider.of<AppBarProvider>(context, listen: false);
    return Card(
      margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
      elevation: 2,
      child: InkWell(
        onLongPress: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              const SizedBox(
                height: 30,
                child: Icon(
                  Icons.person,
                ),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.cliente.nome,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Idade: ${widget.cliente.idade}",
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
