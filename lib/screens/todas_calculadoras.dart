import 'package:calculadora_de_microbios/widgets/drawers/start_drawer.dart';
import 'package:calculadora_de_microbios/widgets/todas_calculadoras/grid_calcs.dart';
import 'package:flutter/material.dart';

class TodasCalculadorasScreen extends StatelessWidget {
  const TodasCalculadorasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de microbiología'),
      ),
      // Estoy creando un cuerpo con GridCalcs
      body: const GridCalcs(),
      drawer: const StartDrawer(),
    );
  }
}
