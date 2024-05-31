import 'package:calculadora_de_microbios/func_utilities/dispertion.dart';
import 'package:calculadora_de_microbios/widgets/drawers/calcs_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:calculadora_de_microbios/models/confianza.dart';
import 'package:calculadora_de_microbios/func_utilities/string_to_double_list.dart';
import 'package:calculadora_de_microbios/func_utilities/fast_alert.dart';

class IntervaloConfianzaTScreen extends StatefulWidget {
  const IntervaloConfianzaTScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntervaloConfianzaTScreenState();
  }
}

class _IntervaloConfianzaTScreenState extends State<IntervaloConfianzaTScreen> {
  // Manejadores
  final _valoresAPrueba = TextEditingController();
  Confianza _tipoConfianza = Confianza.p95;
  String _respuesta = '\\bar{x} \\ \\pm ( \\bar{x} - \\mu )';
  String _ecuacion =
      '( \\bar{x} - \\mu ) = t_{tabla} \\times \\frac{S}{\\sqrt{n}}';
  String _menor = '\\bar{x} - ( \\bar{x} - \\mu )';
  String _mayor = '\\bar{x} + ( \\bar{x} - \\mu )';

  // Tras presionar CALCULAR
  _onCalcular() {
    bool permitirCalculo = true;
    dynamic posiblesValores = tryStringToDoubleList(_valoresAPrueba.text);

    //Comprobar si los valores fueron introducidos correctamente
    if (posiblesValores == null) {
      permitirCalculo = false;
      fastAlert(
        context,
        titulo: const Text('Valores introducidos incorrectamente'),
        mensaje: const Text(
            'Por favor introduce únicamente al menos 2 valores separados por ",".\nEjemplo: "12,13,-14" o "12, 13, -14".'),
      );
    } else if (posiblesValores.length < 2) {
      permitirCalculo = false;
      fastAlert(
        context,
        titulo: const Text('Menos de 2 valores introducidos'),
        mensaje: const Text(
            'Introduce al menos 2 valores, los mínimos necesarios para una prueba de rechazo.'),
      );
    } else if (posiblesValores.length > 30) {
      permitirCalculo = false;
      fastAlert(
        context,
        titulo: const Text('Más de 30 valores introducidos'),
        mensaje: const Text(
            'Introduce máximo 30 valores, los máximos contemplados en la referencia utilizada.'),
      );
    }

    // Si se permite el cálculo
    if (permitirCalculo) {
      double media = mean(posiblesValores);
      double desvEst = standardDeviation(posiblesValores);
      double gapConfianza = confidenceGap(posiblesValores, _tipoConfianza);
      double tDeTabla = tFromTable(posiblesValores.length, _tipoConfianza);
      setState(() {
        _menor = (media - gapConfianza).toStringAsFixed(4);
        _mayor = (media + gapConfianza).toStringAsFixed(4);
        _ecuacion =
            '( \\bar{x} - \\mu ) = $tDeTabla \\times \\frac{ ${desvEst.toStringAsFixed(4)} }{\\sqrt{ ${posiblesValores.length} }}';
        _respuesta =
            '${media.toStringAsFixed(4)} \\ \\pm ${gapConfianza.toStringAsFixed(4)}';
      });
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: const CalcsDrawer(),
        appBar: AppBar(
          title: const Text('Intervalo de confianza (t)'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Porcentaje de confianza (2 colas):'),
                    DropdownButton(
                      value: _tipoConfianza,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      items: [
                        ...Confianza.values.map(
                          (prc) => DropdownMenuItem(
                            value: prc,
                            child:
                                Text('${prc.name.toString().substring(1, 3)}%'),
                            //child: Text(prc.name.toUpperCase()),
                          ),
                        ),
                      ],
                      onChanged: (confianza) {
                        setState(
                          () {
                            _tipoConfianza = confianza!;
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Valores a usar separados por ","'),
                TextField(
                  controller: _valoresAPrueba,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('De 2 a 30 valores separados por ","'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: _onCalcular,
                  child: const Text('CALCULAR'),
                ),
                const SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Math.tex(
                          _respuesta,
                          textStyle: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 16),
                        Math.tex(
                          '=',
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 16),
                        Math.tex(
                          '[\\ $_menor \\ , \\ $_mayor \\ ]',
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text('Ecuación utilizada:'),
                const SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.all(8),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Math.tex(
                      _ecuacion,
                      textStyle: TextStyle(
                        fontSize: 20,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
