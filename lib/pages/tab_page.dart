import 'package:flutter/material.dart';
import 'package:sqflite_estudo/pages/cliente_List_page.dart';
import 'package:sqflite_estudo/pages/dashboard_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
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
          DashBoard(),
          ClienteListPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginalAtual,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: "Home",
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline_outlined,
              color: Colors.black,
            ),
            label: "Cliente",
            backgroundColor: Colors.black,
          ),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.white,
      ),
    );
  }
}
