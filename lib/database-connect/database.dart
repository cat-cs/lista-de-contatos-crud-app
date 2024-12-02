import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
DB._();
static final DB instance = DB._();

static Database? _database;

get database async {
  if (_database != null) return _database;
  return await _initDatabase();
  }
_initDatabase() async{
return await openDatabase(
  join (await getDatabasesPath(), 'lista_contatos.db'),
  version: 1,
  onCreate: _onCreate,);}

_onCreate(db, version) async{
  await db.execute(_contatos);
}

String get _contatos => """ 
CREATE TABLE Contatos 
(id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,  
 Nome VARCHAR(50)  NOT NULL),
 Email VARCHAR(100),
 Telefone BIGINT;""";
}