import 'package:flutter/material.dart';
import '../../model/pedido_comida_model.dart';
import '../../temas/index.dart';
import '../atomos/nota_fila_resumen.dart';
import '../atomos/nota_item_pedido.dart';
import '../atomos/nota_separador.dart';

class ResumenNotaVentaComida extends StatelessWidget {
  final PedidoComidaModelo pedido;

  const ResumenNotaVentaComida({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    final fechaActual = DateTime.now();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFF1D8), Color(0xFFFFF8E1), Color(0xFFFFFFFF)],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColoresApp.primario, width: 1.8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 14,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Encabezado
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: ColoresApp.primario,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          '🧾',
                          style: TextStyle(fontSize: 32),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'NOTA DE VENTA',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Empresa de comida rapida',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: ColoresApp.textoOscuro,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Cliente: ${pedido.nombreCliente}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: ColoresApp.textoOscuro,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Fecha: ${fechaActual.day}/${fechaActual.month}/${fechaActual.year}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: ColoresApp.textoOscuro,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: NotaSeparador(),
                  ),
                  // Detalles del pedido
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DETALLES DEL PEDIDO',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const Divider(height: 12, thickness: 1.5, color: Color(0xFFD32F2F)),
                        ...pedido.items.asMap().entries.map((entry) {
                          final idx = entry.key + 1;
                          final item = entry.value;

                          return NotaItemPedido(indice: idx, item: item);
                        }),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: NotaSeparador(),
                  ),
                  // Totales
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        NotaFilaResumen(
                          etiqueta: 'Subtotal:',
                          valor: '\$${pedido.subtotal.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 10),
                        NotaFilaResumen(
                          etiqueta: 'IVA (15%):',
                          valor: '\$${pedido.iva.toStringAsFixed(2)}',
                        ),
                        const Divider(height: 14, thickness: 1),
                        NotaFilaResumen(
                          etiqueta: 'TOTAL A PAGAR:',
                          valor: '\$${pedido.total.toStringAsFixed(2)}',
                          esTotal: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Volver al pedido'),
            ),
          ],
        ),
      ),
    );
  }
}

