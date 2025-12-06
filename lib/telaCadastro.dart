import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/dominio/usuario.dart';
import 'package:myapp/telaLogin.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/userProvider.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final numeroController = TextEditingController();
  final senhaController = TextEditingController();

  final List<String> seeds = [
    'joao',
    'maria',
    'lucas',
    'ana',
    'pedro',
    'bia',
    'rafa',
    'luna',
  ];
  String? avatarSelecionado;

  @override
  void initState() {
    super.initState();
    avatarSelecionado = gerarUrlAvatar(seeds.first);
  }

  String gerarUrlAvatar(String seed) {
    return 'https://api.dicebear.com/9.x/dylan/svg?seed=$seed';
  }

  Future<List<String>> carregarAvatares() async {
    return seeds.map((s) => gerarUrlAvatar(s)).toList();
  }

  void cadastrar() async {
    if (nomeController.text.isEmpty ||
        emailController.text.isEmpty ||
        cpfController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos obrigatórios')),
      );
      return;
    }

    Usuario novoUsuario = Usuario(
      nome: nomeController.text,
      cpf: cpfController.text,
      email: emailController.text,
      numero: numeroController.text,
      senha: senhaController.text,
      imagem: avatarSelecionado ?? '',
    );

    await Provider.of<UserProvider>(
      context,
      listen: false,
    ).registrarUsuario(novoUsuario);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: numeroController,
              decoration: const InputDecoration(labelText: 'Número'),
            ),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Escolha seu avatar:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<String>>(
              future: carregarAvatares(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());
                final avatares = snapshot.data!;
                return SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: avatares.length,
                    itemBuilder: (context, index) {
                      final url = avatares[index];
                      final selecionado = avatarSelecionado == url;
                      return GestureDetector(
                        onTap: () => setState(() => avatarSelecionado = url),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selecionado
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: SvgPicture.network(
                              url,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholderBuilder: (context) => const SizedBox(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cadastrar,
              child: const Text('Cadastrar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text('Já tem conta? Faça login'),
            ),
          ],
        ),
      ),
    );
  }
}
