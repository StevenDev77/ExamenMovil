import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_botones.dart';
import 'tipografia.dart';
import 'tema_appbar.dart';
import 'tema_formularios.dart';

class TemaGeneral {
  static ThemeData claro = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: ColoresApp.primario,
      secondary: ColoresApp.secundario,
      surface: ColoresApp.fondo,
      onPrimary: ColoresApp.textoClaro,
      onSecondary: ColoresApp.textoClaro,
    ),
    textTheme: Tipografia.tema,
    appBarTheme: TemaAppbar.tema,
    elevatedButtonTheme: TemaBotones.botonPrincipal,
    outlinedButtonTheme: TemaBotones.botonSecundario,
    inputDecorationTheme: TemaFormularios.campoTexto,
    scaffoldBackgroundColor: ColoresApp.fondo
  );
  
}