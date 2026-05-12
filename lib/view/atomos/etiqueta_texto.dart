import 'package:flutter/material.dart';

class EtiquetaTexto extends StatelessWidget {
  final String texto;
  final TextAlign alineacion;
  final TextStyle? estilo;

  const EtiquetaTexto({
    super.key,
    required this.texto,
    this.alineacion = TextAlign.start,
    this.estilo,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: alineacion,
      style: estilo ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
