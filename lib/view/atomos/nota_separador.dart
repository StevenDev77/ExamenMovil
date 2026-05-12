import 'package:flutter/material.dart';
import '../../temas/index.dart';

class NotaSeparador extends StatelessWidget {
  const NotaSeparador({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.4,
      color: ColoresApp.primario.withValues(alpha: 0.75),
    );
  }
}
