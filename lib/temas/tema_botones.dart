import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaBotones {
  static final botonPrincipal = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColoresApp.primario,
        foregroundColor: ColoresApp.textoClaro,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      )
  );

  // Boton secundario
static final botonSecundario = OutlinedButtonThemeData(
style: OutlinedButton.styleFrom(
  foregroundColor: ColoresApp.secundario,
  side: BorderSide(color: ColoresApp.primario),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

)

);

}