import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_estudo/models/cliente_model.dart';

//tentativa falha de usar o provider, junio do futuro irá resolver
class DB {
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
      nomeCompleto TEXT,
      dataNasc TEXT,
      celular TEXT,
      email TEXT,
      cep INTEGER,
      logradouro TEXT,
      numero INTEGER,
      cidade TEXT,
      observacao TEXT,
      imagePath TEXT
    )
  ''';

  //////////////////////////////////////////////////////////////////

  //insert
  insertCliente(Cliente cliente) async {
    try {
      final Database db = await database;
      await db.insert("cliente", cliente.toMap());
    } catch (ex) {
      log(ex.toString());
      return;
    }
  }

  //getClientes
  Future<List<Cliente>> getCliente() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("cliente");
    return List.generate(maps.length, (i) {
      return Cliente.fromMap(maps[i]);
    });
  }

  //update
  updateCliente(Cliente cliente, int id) async {
    final Database db = await database;
    db.update(
      "cliente",
      {
        "nomeCompleto": cliente.nomeCompleto,
        "dataNasc": cliente.dataNasc,
        "celular": cliente.celular,
        "email": cliente.email,
        "cep": cliente.cep,
        "logradouro": cliente.logradouro,
        "numero": cliente.numero,
        "cidade": cliente.cidade,
        "observacao": cliente.observacao,
        "imagePath": cliente.imagePath,
      },
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //delete
  deleteCliente(Cliente cliente) async {
    final Database db = await database;
    db.delete(
      "cliente",
      where: "id = ?",
      whereArgs: [cliente.id],
    );
  }
}
