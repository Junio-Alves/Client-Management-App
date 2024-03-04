import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_estudo/pages/cliente_List_page.dart';
import 'package:sqflite_estudo/pages/dashboard_page.dart';
import 'package:sqflite_estudo/pages/edit_cliente.dart';
import 'package:sqflite_estudo/pages/tab_page.dart';
import 'package:sqflite_estudo/pages/new_cliente.dart';
import 'package:sqflite_estudo/pages/new_product.dart';
import 'package:sqflite_estudo/provider/appBarProvider.dart';
import 'package:sqflite_estudo/provider/cliente_provider.dart';
import 'package:sqflite_estudo/utils/app_routes.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClienteProvider()),
        ChangeNotifierProvider(create: (context) => AppBarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoute.home: (contexto) => const TabPage(),
          AppRoute.clientListPage: (contexto) => const ClienteListPage(),
          AppRoute.newClient: (contexto) => const NovoCliente(),
          AppRoute.editClient: (contexto) => const EditCliente(),
          AppRoute.dashboard: (contexto) => const DashBoard(),
          AppRoute.clientPage: (contexto) => const DashBoard(),
          AppRoute.newProduct: (contexto) => const NewProduct(),
        },
      ),
    );
  }
}
