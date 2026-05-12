import 'package:flutter/material.dart';
import '../../model/pedido_comida_model.dart';
import '../../temas/index.dart';

class NotaItemPedido extends StatelessWidget {
  final int indice;
  final ItemPedido item;

  const NotaItemPedido({
    super.key,
    required this.indice,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColoresApp.primario.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$indice. ${item.producto}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            item.tipoCombo,
            style: TextStyle(
              fontSize: 12,
              color: ColoresApp.textoOscuro.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${item.cantidad}x \$${item.precioUnitario.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                '\$${item.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
