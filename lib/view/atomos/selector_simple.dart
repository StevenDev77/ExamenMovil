import 'package:flutter/material.dart';

class SelectorSimple extends StatelessWidget {
  final String etiqueta;
  final String valorSeleccionado;
  final List<String> opciones;
  final ValueChanged<String?> alCambiar;

  const SelectorSimple({
    super.key,
    required this.etiqueta,
    required this.valorSeleccionado,
    required this.opciones,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: valorSeleccionado.isEmpty ? null : valorSeleccionado,
      decoration: InputDecoration(labelText: etiqueta),
      items: opciones
          .map(
            (opcion) => DropdownMenuItem(
              value: opcion,
              child: Text(opcion),
            ),
          )
          .toList(),
      onChanged: alCambiar,
    );
  }
}
