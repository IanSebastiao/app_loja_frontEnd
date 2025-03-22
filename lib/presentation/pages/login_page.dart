import 'package:app_loja/presentation/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  login() async {
    final viewModel = Provider.of<UserViewmodel>(context, listen: false);
    final username = usernameController.text;
    final senha =
        senhaController.text; // Corrigido para pegar o texto do campo de senha

    if (username.isEmpty || senha.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Por favor, preencha todos os campos")),
        );
      }
      return;
    }

    try {
      bool sucesso = await viewModel.login(username, senha);
      if (mounted && sucesso) {
        Navigator.pushReplacementNamed(context, "/");
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erro ao fazer login. Verifique as credenciais."),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao fazer login: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: login,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Entrar'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/esqueci-senha");
              },
              child: Text('Esqueci a senha'),
            ),
          ],
        ),
      ),
    );
  }
}
