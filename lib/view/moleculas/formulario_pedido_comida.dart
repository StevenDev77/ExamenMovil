import 'package:flutter/material.dart';
import '../atomos/campo_texto_personalizado.dart';
import '../atomos/selector_simple.dart';

class FormularioPedidoComida extends StatelessWidget {
  final TextEditingController cantidadCtrl;
  final String productoSeleccionado;
  final String comboSeleccionado;
  final List<String> productos;
  final List<String> combos;
  final ValueChanged<String?> onCambiarProducto;
  final ValueChanged<String?> onCambiarCombo;
  final VoidCallback onAgregarProducto;

  const FormularioPedidoComida({
    super.key,
    required this.cantidadCtrl,
    required this.productoSeleccionado,
    required this.comboSeleccionado,
    required this.productos,
    required this.combos,
    required this.onCambiarProducto,
    required this.onCambiarCombo,
    required this.onAgregarProducto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectorSimple(
              etiqueta: 'Producto',
              valorSeleccionado: productoSeleccionado,
              opciones: productos,
              alCambiar: onCambiarProducto,
            ),
            const SizedBox(height: 14),
            SelectorSimple(
              etiqueta: 'Tipo de combo',
              valorSeleccionado: comboSeleccionado,
              opciones: combos,
              alCambiar: onCambiarCombo,
            ),
            const SizedBox(height: 14),
            CampoTextoPersonalizado(
              etiqueta: 'Cantidad',
              icono: Icons.confirmation_number,
              controlador: cantidadCtrl,
              tecladoNumerico: true,
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onAgregarProducto,
              icon: const Icon(Icons.add),
              label: const Text('Agregar producto'),
            ),
          ],
        ),
      ),
    );
  }
}

