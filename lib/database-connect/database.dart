import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contato.dart';

class DB {
  DB._();
  static final DB instance = DB._();

  static Database? _database;

  // Ensure database is initialized
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), 'lista_contatos.db');
    // Debug: Verificando o caminho do banco
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the 'Contatos' table
  _onCreate(Database db, int version) async {
    await db.execute(_contatos);
    // Debug: Verificando a criação da tabela
  }

  String get _contatos => """ 
  CREATE TABLE Contatos (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,  
    Nome TEXT NOT NULL,
    Email TEXT,
    Telefone TEXT
  );
  """;

  // Create
  static Future<int> insertContato(Contato contato) async {
    final db = await instance.database;
    int result = await db.insert('Contatos', contato.toMap());
    // Debug: Verificando a inserção
    return result;
  }

  // Read
  static Future<List<Contato>> getContatos() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('Contatos');
    // Debug: Verificando os dados lidos
    return List.generate(maps.length, (i) {
      return Contato.fromMap(maps[i]);
    });
  }

  // Update
  static Future<int> updateContato(Contato contato) async {
    final db = await instance.database;
    int result = await db.update(
      'Contatos',
      contato.toMap(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
    // Debug: Verificando a atualização
    return result;
  }

  // Delete
  static Future<int> deleteContato(int id) async {
    final db = await instance.database;
    int result = await db.delete(
      'Contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
    // Debug: Verificando a exclusão
    return result;
  }
}
