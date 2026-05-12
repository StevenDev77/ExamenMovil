import 'package:flutter/material.dart';
import '../../temas/index.dart';

class NotaFilaResumen extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final bool esTotal;

  const NotaFilaResumen({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.esTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final estiloEtiqueta = TextStyle(
      fontSize: esTotal ? 16 : 14,
      fontWeight: esTotal ? FontWeight.w700 : FontWeight.w500,
      color: ColoresApp.textoOscuro,
    );

    final estiloValor = TextStyle(
      fontSize: esTotal ? 19 : 14,
      fontWeight: FontWeight.w800,
      color: esTotal ? ColoresApp.primario : ColoresApp.textoOscuro,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(etiqueta, style: estiloEtiqueta),
        Text(valor, style: estiloValor),
      ],
    );
  }
}
