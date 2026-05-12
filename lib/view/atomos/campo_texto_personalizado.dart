import 'package:flutter/material.dart';

class CampoTextoPersonalizado extends StatelessWidget {
  final String etiqueta;
  final IconData icono;
  final TextEditingController controlador;
  final bool ocultarTexto;
  final bool tecladoNumerico;

  const CampoTextoPersonalizado({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.controlador,
    this.ocultarTexto = false,
    this.tecladoNumerico = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      obscureText: ocultarTexto,
      keyboardType: tecladoNumerico ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Icon(icono),
      ),
    );
  }
}
