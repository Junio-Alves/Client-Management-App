import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

//tentativa falha de usar o provider, junio do futuro irá resolver
class DB extends ChangeNotifier {
  DB._();
  static final DB intance = DB._();
  static Database? _database;

  final List<Cliente> _clientes = [];
  List<Cliente> get cliente => _clientes;

  get database async {
    if (_database != null) return _database;
    return await _initDatabase();
  }

  _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "cripto.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int versao) async {
    await db.execute(_cliente);
  }

  String get _cliente => '''
    CREATE TABLE cliente(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      idade INT
    )
  ''';

  insertCliente(Cliente cliente) async {
    try {
      final Database db = await database;
      await db.insert("cliente", cliente.toMap());
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<List<Cliente>> getCliente() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("cliente");
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  updateCliente(Cliente cliente, int id) async {
    final Database db = await database;
    db.update(
      "cliente",
      {'nome': cliente.nome, 'idade': cliente.idade},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  deleteCliente(Cliente cliente) async {
    final Database db = await database;
    db.delete(
      "cliente",
      where: "id = ?",
      whereArgs: [cliente.id],
    );
  }
}
