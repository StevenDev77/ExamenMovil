import 'package:flutter/material.dart';
import '../atomos/campo_texto_personalizado.dart';
import '../atomos/boton_personalizado.dart';

class FormularioLogin extends StatelessWidget {
  final TextEditingController usuarioCtrl;
  final TextEditingController contrasenaCtrl;
  final VoidCallback alEnviar;

  const FormularioLogin({
    super.key,
    required this.usuarioCtrl,
    required this.contrasenaCtrl,
    required this.alEnviar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.account_circle, size: 100, color: Colors.white),
        const SizedBox(height: 10),
        const Text(
          'Iniciar Sesión',
          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        CampoTextoPersonalizado(
          etiqueta: 'Usuario',
          icono: Icons.person,
          controlador: usuarioCtrl,
        ),
        const SizedBox(height: 16),
        CampoTextoPersonalizado(
          etiqueta: 'Contraseña',
          icono: Icons.lock,
          controlador: contrasenaCtrl,
          ocultarTexto: true,
        ),
        const SizedBox(height: 20),
        BotonPersonalizado(
          texto: 'Ingresar',
          alPresionar: alEnviar,
        ),
      ],
    );
  }
}
