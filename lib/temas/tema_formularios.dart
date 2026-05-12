import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaFormularios {
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    labelStyle: TextStyle(color: Colors.grey),
    prefixIconColor: ColoresApp.primario,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: ColoresApp.primario),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: ColoresApp.primario, width: 4),
    ),

  );
}