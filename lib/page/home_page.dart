import 'package:flutter/material.dart';
import 'package:sqflite_estudo/page/cliente_page.dart';
import 'package:sqflite_estudo/page/new_cliente.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginalAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginalAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: const [
          ClientePage(),
          NovoCliente(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginalAtual,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_outlined), label: "Cliente"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Novo Cliente"),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.grey,
      ),
    );
  }
}