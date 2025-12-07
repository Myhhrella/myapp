import 'package:flutter/material.dart';
import 'package:myapp/dominio/usuario.dart';
import 'package:myapp/db/usuario_dao.dart';

class UserProvider extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  Future<void> registrarUsuario(Usuario usuario) async {
    await UsuarioDao().inserirUsuario(usuario);
    _usuario = usuario;
    notifyListeners();
  }

  Future<void> login(String email, String senha) async {
    _usuario = await UsuarioDao().buscarUsuarioPorEmailEsenha(email, senha);
    notifyListeners();
  }

  Future<void> carregarUsuario() async {
    _usuario = await UsuarioDao().buscarUsuario();
    notifyListeners();
  }

  Future<void> atualizarUsuario(Usuario usuario) async {
    await UsuarioDao().atualizarUsuario(usuario);
    _usuario = usuario;
    notifyListeners();
  }
}
