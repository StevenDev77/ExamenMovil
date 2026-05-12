import 'package:flutter/material.dart';
import 'temas/index.dart';
import 'view/paginas/vista_comida_rapida.dart';
import 'view/paginas/vista_nota_venta_comida.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comida Rápida MVC',
      theme: TemaGeneral.claro,
      initialRoute: '/comida',
      routes: {
        '/comida': (context) => const VistaComidaRapida(),
        '/notaVentaComida': (context) => const VistaNotaVentaComida(),
      },
    );
  }
}
