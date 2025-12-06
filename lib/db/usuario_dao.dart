import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/db/db_helper.dart';
import 'package:myapp/dominio/usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDao {
  final String baseUrl = 'https://my-json-server.typicode.com/Myhhrella/Minha-API-fake/users';

  Future<Usuario?> buscarUsuarioPorEmailEsenha(String email, String senha) async {
    final response = await http.get(Uri.parse('$baseUrl?email=$email&senha=$senha'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final usuario = Usuario.fromJson(data.first);

        // evita duplicar no banco
        Database db = await DBHelper().initDB();
        var result = await db.query('Usuario', where: 'id = ?', whereArgs: [usuario.id]);
        if (result.isEmpty) {
          await inserirUsuario(usuario);
        }

        return usuario;
      }
    }
    return null;
  }

  Future<Usuario?> buscarUsuario() async {
    Database db = await DBHelper().initDB();
    var result = await db.query('Usuario', limit: 1);
    if (result.isNotEmpty) {
      return Usuario.fromJson(result.first);
    }
    return null;
  }

  Future<void> inserirUsuario(Usuario usuario) async {
    Database db = await DBHelper().initDB();
    await db.insert('Usuario', usuario.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    Database db = await DBHelper().initDB();
    await db.update(
      'Usuario',
      usuario.toJson(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }
}
