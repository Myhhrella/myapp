import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'DadosUsersAppV';

    String dbPath = join(path, dbName);
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );

    print(dbPath);
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Usuario (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      cpf TEXT NOT NULL,
      email TEXT NOT NULL,
      numero TEXT NOT NULL,
      senha TEXT NOT NULL,
      imagem TEXT
    ); ''');
    /*
    await db.execute('''
    INSERT INTO Usuario (nome, cpf, email, numero, senha, imagem)
    VALUES ('Nome de usuario',
            '000.000.000-00',
            'email@email.com',
            '(00) 0000-0000',
            'senha123',
            'https://static.vecteezy.com/system/resources/previews/018/765/757/original/user-profile-icon-in-flat-style-member-avatar-illustration-on-isolated-background-human-permission-sign-business-concept-vector.jpg');
    ''');*/
  }
}
