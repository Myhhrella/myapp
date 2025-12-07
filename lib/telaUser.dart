import 'package:flutter/material.dart';
import 'package:myapp/telaEdicao.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:myapp/dominio/usuario.dart';
import 'package:myapp/provider/userProvider.dart';
import 'package:myapp/telaLogin.dart';
import 'package:myapp/db/shared_prefs.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UserProvider>(context).usuario;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 86, 196, 90),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Perfil do Usuário'),
        ),
        body: usuario == null
            ? const Center(child: CircularProgressIndicator())
            : buildBody(context, usuario),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TelaEdicao()),
            );
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.edit),
        ),

      ),
    );
  }

  Widget buildBody(BuildContext context, Usuario usuario) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            color: const Color.fromARGB(255, 124, 185, 126),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: usuario.imagem.trim().isNotEmpty
                    ? SvgPicture.network(
                        usuario.imagem,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        placeholderBuilder: (context) =>
                            const Icon(Icons.person, size: 120),
                      )
                    : const Icon(Icons.person, size: 120),
              ),
            ),
          ),
          const SizedBox(height: 24),
          buildCard('Nome', usuario.nome, usuario.imagem),
          buildCard('CPF', usuario.cpf, usuario.imagem),
          buildCard('E-mail', usuario.email, usuario.imagem),
          buildCard('Número', usuario.numero, usuario.imagem),
          cardGerenciamento('Gerenciamento da conta', usuario.imagem),
          cardGerenciamento('Configurações', usuario.imagem),

          GestureDetector(
            onTap: () async {
              await SharedPrefs().setUserStatus(false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            child: cardGerenciamento(
              'Sair',
              usuario.imagem,
              icon: Icons.logout,
              iconColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String titulo, String valor, String imagem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade200),
        image: imagem.trim().isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imagem),
                fit: BoxFit.cover,
                opacity: 0.1,
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                valor,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardGerenciamento(String titulo, String imagem,
      {IconData icon = Icons.chevron_right, Color iconColor = Colors.black54}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade200),
        image: imagem.trim().isNotEmpty
            ? DecorationImage(
                image: NetworkImage(imagem),
                fit: BoxFit.cover,
                opacity: 0.05,
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Icon(icon, size: 28, color: iconColor),
          ],
        ),
      ),
    );
  }
}
