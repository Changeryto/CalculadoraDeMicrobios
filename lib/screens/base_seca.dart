import 'package:calculadora_de_microbios/widgets/drawers/calcs_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:calculadora_de_microbios/func_utilities/sci_notation.dart';

enum TipoCelulas { cientifico, completo }

class BaseSecaScreen extends StatefulWidget {
  const BaseSecaScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BaseSecaScreenState();
  }
}

class _BaseSecaScreenState extends State<BaseSecaScreen> {
  //Controladores de los inputs
  final _celulasHumedo = TextEditingController();
  final _coeficienteCelulasHumedo = TextEditingController();
  final _exponenteCelulasHumedo = TextEditingController();
  final _porcentajeHumedad = TextEditingController();
  TipoCelulas _tipoCelulas = TipoCelulas.cientifico;

  // Variables que modifican los widgets LaTeX
  String _respuesta = 'cels/g\\ BS';
  //String ecuacion = ' \\frac{cels/g\\ BH}{1 - Humedad% / 100% }';
  String _ecuacion = '\\frac{cels/g\\ BH}{1 - \\frac{Humedad\\%}{100\\%}}';

  // Lógica que se ejecuta al presionar CALCULAR
  void _onCalcular() {
    bool permitirCalculo = true;
    if (_tipoCelulas == TipoCelulas.completo) {
      // Comprobando si la concentración fué introducida correctamente
      if (double.tryParse(_celulasHumedo.text) == null ||
          double.tryParse(_celulasHumedo.text)! < 0) {
        permitirCalculo = false;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Células/g introducidas incorrectamente'),
            content: const Text(
                'Por favor introduce un número positivo mayor o igual a 0 células/g.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Aceptar',
                ),
              )
            ],
          ),
        );
      }
    } else if (_tipoCelulas == TipoCelulas.cientifico) {
      // Comprobando si el coeficiente fue introducido correctamente
      if (double.tryParse(_coeficienteCelulasHumedo.text) == null ||
          double.tryParse(_coeficienteCelulasHumedo.text)! < 0) {
        permitirCalculo = false;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Coeficiente introducido incorrectamente'),
            content: const Text(
                'Por favor introduce un número positivo mayor o igual a 0.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Aceptar',
                ),
              )
            ],
          ),
        );
      }
      // Comprobando si el exponente fue introducido correctamente
      if (double.tryParse(_exponenteCelulasHumedo.text) == null ||
          double.tryParse(_exponenteCelulasHumedo.text)! < 0) {
        permitirCalculo = false;
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Exponente introducido incorrectamente'),
            content: const Text(
                'Por favor introduce un número positivo mayor o igual a 0.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Aceptar',
                ),
              )
            ],
          ),
        );
      }
    }
    // Comprobando si el porcentaje de humedad está correcto
    if (double.tryParse(_porcentajeHumedad.text) == null ||
        double.tryParse(_porcentajeHumedad.text)! > 100 ||
        double.tryParse(_porcentajeHumedad.text)! < 0) {
      permitirCalculo = false;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title:
              const Text('Porcentaje de humedad introducido incorrectamente'),
          content: const Text(
              'Por favor introduce un porcentaje mayor que 0 y menor que 100.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Aceptar',
              ),
            )
          ],
        ),
      );
    }

    // Lógica que se ejecuta si el cálculo es permitido
    if (permitirCalculo) {
      // Generando el cálculo
      final double celsHumedas;
      if (_tipoCelulas == TipoCelulas.completo) {
        celsHumedas = double.parse(_celulasHumedo.text);
      } else {
        // if (_tipoCelulas == TipoCelulas.cientifico)
        celsHumedas = double.parse(_coeficienteCelulasHumedo.text) *
            pow(10, double.parse(_exponenteCelulasHumedo.text));
      }
      final humedad = double.parse(_porcentajeHumedad.text);
      final celsBS = celsHumedas / (1 - (humedad / 100));

      // Lógica que escribe las ecuaciones LaTeX
      setState(() {
        _respuesta = '${toSciNotation(celsBS)}\\ cels/g\\ BS';
        _ecuacion =
            '\\frac{ ${toSciNotation(celsHumedas)} \\ cels/g\\ BH}{1 - \\frac{$humedad\\%}{100\\%}}';
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
          title: const Text('Células/g en base seca'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Células en el gramo de muestra húmeda.',
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      items: [
                        ...TipoCelulas.values.map(
                          (tipo) => DropdownMenuItem(
                            value: tipo,
                            child: Text(tipo.name.toUpperCase()),
                          ),
                        ),
                      ],
                      onChanged: (tipo) {
                        setState(() {
                          _tipoCelulas = tipo!;
                        });
                      },
                      value: _tipoCelulas,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('¿Qué elegir?'),
                            content: const Text(
                                'CIENTIFICO:\nSi tienes una concentración celular expresada en notación científica \n(Ejemplo: 1.5 ×10^ 2). \n\nCOMPLETO:\nSi tienes una concentración celular en un número completo \n(Ejemplo: 250.5).'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Aceptar')),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.help_outline),
                    ),
                  ],
                ),
                if (_tipoCelulas == TipoCelulas.completo)
                  TextField(
                    controller: _celulasHumedo,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Células/g'),
                      suffix: Text('células/g'),
                    ),
                  )
                else if (_tipoCelulas == TipoCelulas.cientifico)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _coeficienteCelulasHumedo,
                          decoration: const InputDecoration(
                            label: Text('Coeficiente'),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '× 10 ^',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _exponenteCelulasHumedo,
                          decoration: const InputDecoration(
                            label: Text('Exponente'),
                          ),
                        ),
                      ),
                      const Text('cels/g'),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Porcentaje de humedad de la muestra.'),
                TextField(
                  controller: _porcentajeHumedad,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Humedad de la muestra'),
                    suffix: Text('%'),
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
                  height: 8,
                ),
                Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Math.tex(
                      _respuesta,
                      textStyle: const TextStyle(fontSize: 22),
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
                        fontSize: 25,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
