import 'package:app_loja/data/repository/repository.dart';
import 'package:app_loja/data/repository/user_repository.dart';
import 'package:app_loja/presentation/pages/homepage.dart';
import 'package:app_loja/presentation/pages/login_page.dart';
import 'package:app_loja/presentation/viewmodel/user_viewmodel.dart';
import 'package:app_loja/presentation/viewmodel/viewmodel.dart';
import 'package:app_loja/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProdutoViewModel(ProdutoRepository(ApiServices())),
        ),
        ChangeNotifierProvider(
          create: (_) => UserViewmodel(UserRepository(ApiServices())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja API',
      theme: ThemeData(primaryColor: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/': (context) => const Homepage(),
        '/login': (context) => const LoginPage(),
        // '/carrinho': (context) => const CarrinhoPage(),
      },
    );
  }
}
