import 'package:flutter/material.dart';
import '../../model/pedido_comida_model.dart';
import '../moleculas/resumen_nota_venta_comida.dart';

class VistaNotaVentaComida extends StatelessWidget {
  const VistaNotaVentaComida({super.key});

  @override
  Widget build(BuildContext context) {
    final pedido = ModalRoute.of(context)!.settings.arguments as PedidoComidaModelo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nota de venta'),
      ),
      body: ResumenNotaVentaComida(pedido: pedido),
    );
  }
}

