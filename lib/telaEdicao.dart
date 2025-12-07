import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/dominio/usuario.dart';
import 'package:myapp/provider/userProvider.dart';

class TelaEdicao extends StatefulWidget {
  const TelaEdicao({super.key});

  @override
  State<TelaEdicao> createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nomeController;
  late TextEditingController cpfController;
  late TextEditingController emailController;
  late TextEditingController numeroController;
  late TextEditingController senhaController;

  Usuario? usuario;

  @override
  void initState() {
    super.initState();

    // lê o usuário atual do provider (sem escutar mudanças)
    final userProvider = context.read<UserProvider>();
    usuario = userProvider.usuario;

    nomeController = TextEditingController(text: usuario?.nome ?? '');
    cpfController = TextEditingController(text: usuario?.cpf ?? '');
    emailController = TextEditingController(text: usuario?.email ?? '');
    numeroController = TextEditingController(text: usuario?.numero ?? '');
    senhaController = TextEditingController(text: usuario?.senha ?? '');
  }

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    emailController.dispose();
    numeroController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum usuário carregado para edição')),
      );
      return;
    }

    final usuarioAtualizado = Usuario(
      id: usuario!.id, // mantém o mesmo id
      nome: nomeController.text.trim(),
      cpf: cpfController.text.trim(),
      email: emailController.text.trim(),
      numero: numeroController.text.trim(),
      senha: senhaController.text.trim(),
      imagem: usuario!.imagem, // mantém o mesmo avatar
    );

    await context.read<UserProvider>().atualizarUsuario(usuarioAtualizado);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados atualizados com sucesso!')),
    );

    Navigator.pop(context); // volta para a tela de usuário
  }

  @override
  Widget build(BuildContext context) {
    if (usuario == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o CPF' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o email' : null,
              ),
              TextFormField(
                controller: numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe o número' : null,
              ),
              TextFormField(
                controller: senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                value == null || value.isEmpty ? 'Informe a senha' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
