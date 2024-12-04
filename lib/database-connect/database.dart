import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contato.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;

  // Check inicialização banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar
  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'lista_contatos.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Criação tabela Contatos
  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE Contatos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,  
        Nome TEXT,
        Email TEXT,
        Telefone TEXT
      );
    """);
  }

  // Create
  static Future<int> insertContato(Contato contato) async {
  final db = await instance.database;
  return await db.insert('Contatos', contato.toMap());
  }

  // Read
  static Future<List<Contato>> getContatos() async {
  final db = await instance.database;
  final List<Map<String, Object?>> maps = await db.query('Contatos');
    return List.generate(maps.length, (i) {
    return Contato.fromMap(maps[i]);
    });
  }

  // Update
  static Future<int> updateContato(Contato contato) async {
    final db = await instance.database;
    return await db.update(
      'Contatos',
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  // Delete
  static Future<int> deleteContato(int id) async {
    final db = await instance.database;
    return await db.delete(
      'Contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

