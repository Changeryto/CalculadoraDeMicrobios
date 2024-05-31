import 'package:calculadora_de_microbios/func_utilities/fast_alert.dart';
import 'package:calculadora_de_microbios/func_utilities/one_dixon_test.dart';
import 'package:calculadora_de_microbios/widgets/drawers/calcs_drawer.dart';
import 'package:flutter/material.dart';
import 'package:calculadora_de_microbios/func_utilities/string_to_double_list.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:calculadora_de_microbios/models/confianza.dart';

//enum Confianza { p80, p90, p95, p96, p98, p99 }

class RechazoScreen extends StatefulWidget {
  const RechazoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RechazoScreenState();
  }
}

class _RechazoScreenState extends State<RechazoScreen> {
  // Controladores
  final _valoresAPrueba = TextEditingController();
  Confianza _tipoConfianza = Confianza.p95;

  // Variables que modifican los Widgets LaTeX
  String _rechazador = 'Valores\\ rechazados:';
  final List<String> _rechazos = [];
  List<String> _ecuaciones = [
    '\\frac{|Valor\\ sospechozo - Valor\\ contiguo|}{Valor\\ mayor - Valor\\ menor} > Q_{Tabla}'
  ];

  void _onCalcular() {
    bool permitirCalculo = true;
    dynamic posiblesValores = tryStringToDoubleList(_valoresAPrueba.text);

    if (posiblesValores == null) {
      permitirCalculo = false;
      fastAlert(
        context,
        titulo: const Text('Valores introducidos incorrectamente'),
        mensaje: const Text(
            'Por favor introduce únicamente los valores separados por ",".\nEjemplo: "12,13,14" o "12, 13, 14".'),
      );
    } else if (posiblesValores.length < 3) {
      permitirCalculo = false;
      fastAlert(
        context,
        titulo: const Text('Menos de 3 valores introducidos'),
        mensaje: const Text(
            'Introduce al menos 3 valores, los mínimos necesarios para una prueba de rechazo.'),
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
    // Lógica que se ejecuta si se permite el cálculo
    if (permitirCalculo) {
      _rechazos.clear();
      _ecuaciones.clear();
      posiblesValores.sort();
      List<double> listaRealValores = List.of(posiblesValores);
      List<double> valoresRechazados = [];
      // Bucle que se rompe hasta que dejan de haber rechazos
      while (true) {
        if (oneDixonTest(listaRealValores, confianza: _tipoConfianza).isNaN) {
          break;
        } else {
          final esteRechazo =
              oneDixonTest(listaRealValores, confianza: _tipoConfianza);
          valoresRechazados.add(esteRechazo);

          // ToDo: Añadir las adiciones de ecuaciones aquí
          //double valorSospechozo = esteRechazo;
          double valorContiguo;
          if (isRightFarthestValue(listaRealValores)) {
            valorContiguo = listaRealValores[listaRealValores.length - 2];
          } else {
            valorContiguo = listaRealValores[1];
          }
          _ecuaciones.add(
              '\\frac{|$esteRechazo - $valorContiguo|}{${listaRealValores.last} - ${listaRealValores.first}} > ${obtenerValorQTabla(listaRealValores, confianza: _tipoConfianza)}');
          // Final de añadir ecuación
          listaRealValores.remove(esteRechazo);
        }
      }

      if (valoresRechazados.isEmpty) {
        double valorSospechozo;
        double valorContiguo;
        double valorMayor;
        double valorMenor;
        setState(() {
          _rechazos;
          _rechazador = 'Ningún\\ valor\\ rechazado.';
          if (isRightFarthestValue(posiblesValores)) {
            valorSospechozo = posiblesValores.last;
            valorContiguo = posiblesValores[posiblesValores.length - 2];
          } else {
            valorSospechozo = posiblesValores.first;
            valorContiguo = posiblesValores[1];
          }
          valorMayor = posiblesValores.last;
          valorMenor = posiblesValores.first;
          _ecuaciones = [
            '\\frac{|$valorSospechozo - $valorContiguo|}{$valorMayor - $valorMenor} < ${obtenerValorQTabla(posiblesValores, confianza: _tipoConfianza)}'
          ];
        });
      } else {
        for (final valor in valoresRechazados) {
          _rechazos.add(valor.toString());
        }
        setState(
          () {
            _rechazador = 'Valores\\ rechazados:';
            _rechazos;
            _ecuaciones;
          },
        );
      }
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          drawer: const CalcsDrawer(),
          appBar: AppBar(
            title: const Text('Prueba de rechazo'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Porcentaje de confianza:'),
                      DropdownButton(
                        value: _tipoConfianza,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        items: [
                          ...Confianza.values.map(
                            (prc) => DropdownMenuItem(
                              value: prc,
                              child: Text(
                                  '${prc.name.toString().substring(1, 3)}%'),
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
                  const Text('Valores a prueba separados por ","'),
                  TextField(
                    controller: _valoresAPrueba,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('De 3 a 30 valores separados por ","'),
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
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Math.tex(
                            _rechazador,
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          for (final valor in _rechazos)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Math.tex(
                                valor,
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                    elevation: 2,
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Math.tex(
                            'Ecuaciones\\ utilizadas:',
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          for (final ecuacion in _ecuaciones)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 8.0),
                              child: Math.tex(
                                ecuacion,
                                textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
