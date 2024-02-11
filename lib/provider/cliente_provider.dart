import 'package:flutter/foundation.dart';
import 'package:sqflite_estudo/helpers/db.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

class ClienteProvider extends ChangeNotifier {
  List<Cliente> _clientes = [];
  List<Cliente> get cliente => _clientes;

  Future<void> getClientes() async {
    final DB db = DB.intance;
    _clientes = await db.getCliente();
    notifyListeners();
  }
}
