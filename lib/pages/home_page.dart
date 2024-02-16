import 'package:flutter/material.dart';
import 'package:sqflite_estudo/pages/cliente_List_page.dart';
import 'package:sqflite_estudo/pages/new_cliente.dart';

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

  setPaginaAtual(index) {
    setState(() {
      paginalAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [
          ClienteListPage(),
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
