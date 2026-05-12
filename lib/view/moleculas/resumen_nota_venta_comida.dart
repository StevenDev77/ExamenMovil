import 'package:flutter/material.dart';
import '../../model/pedido_comida_model.dart';
import '../../../temas/index.dart';

class ResumenNotaVentaComida extends StatelessWidget {
  final PedidoComidaModelo pedido;

  const ResumenNotaVentaComida({
    super.key,
    required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Encabezado
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColoresApp.primario,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    '🧾',
                    style: TextStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'NOTA DE VENTA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Contenedor principal de la factura
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColoresApp.primario, width: 2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: const Color(0xFFFFF8E1),
              ),
              child: Column(
                children: [
                  // Información de empresa, cliente y fecha
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Empresa de comida rápida',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xFF212121),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cliente: ${pedido.nombreCliente}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF212121),
                              ),
                            ),
                            Text(
                              'Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF212121),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Separador
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: 1.5,
                      color: ColoresApp.primario,
                    ),
                  ),
                  // Detalles del pedido
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DETALLES DEL PEDIDO',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const Divider(
                            height: 12, thickness: 1.5, color: Color(0xFFD32F2F)),
                        ...pedido.items.asMap().entries.map((entry) {
                          final idx = entry.key + 1;
                          final item = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$idx. ${item.producto}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Text(
                                  '   ${item.tipoCombo}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '   ${item.cantidad}x \$${item.precioUnitario.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      '\$${item.subtotal.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  // Separador
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Container(
                      height: 1.5,
                      color: ColoresApp.primario,
                    ),
                  ),
                  // Totales
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal:',
                                style: TextStyle(fontSize: 14)),
                            Text(
                              '\$${pedido.subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('IVA (15%):', style: TextStyle(fontSize: 14)),
                            Text(
                              '\$${pedido.iva.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        const Divider(height: 14, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'TOTAL A PAGAR:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              '\$${pedido.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFFD32F2F),
                              ),
                            ),
                          ],
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

