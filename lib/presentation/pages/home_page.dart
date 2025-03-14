import 'package:app_loja/presentation/viewmodels/produto_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";
  int _selectedIndex = 0; // Indice de pagina selecionada

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carregarProdutos();
    });
  }

  Future<void> _carregarProdutos() async {
    final viewModel = Provider.of<ProdutoViewmodel>(context, listen: false);
    try {
      await viewModel.carregarProdutos();
    } catch (error) {
      // Trate o erro de forma apropiada
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
