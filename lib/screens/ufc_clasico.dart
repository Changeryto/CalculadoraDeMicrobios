import 'package:calculadora_de_microbios/widgets/drawers/calcs_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:calculadora_de_microbios/func_utilities/sci_notation.dart';
import 'package:calculadora_de_microbios/models/dilucion.dart';
// Tipos que puede recibir el tipo de dilución
//enum Dilucion { decimal, factor, cientifico }

// Tipos que puede recibir el tipo de volumen
enum TipoVolumen { mililitros, microlitros }

class UfcClasicoScreen extends StatefulWidget {
  const UfcClasicoScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _UfcClasicoScreenState();
  }
}

class _UfcClasicoScreenState extends State<UfcClasicoScreen> {
  // Controladores de los inputs
  final _coloniasController = TextEditingController();
  final _dilucionController = TextEditingController();
  final _alicuotaController = TextEditingController();
  Dilucion _tipoDilucionController = Dilucion.factor;
  TipoVolumen _tipoVolumenController = TipoVolumen.mililitros;

  // Variable bool que será true si pasa todas las comprobaciones de los inputs, de lo contrario será false-
  bool _permitirCalculo = true;

  // Variable del resultado
  String respuesta = 'UFC/mL';

  // Variable de texto de la ecuación
  String ecuacion =
      '\\bar{x}\\ Colonias \\times \\frac{1}{Dilución} \\times \\frac{1}{Alícuota}';

  // Método que se efecuta al seleccionar CALCULAR
  void _onCalcular() {
    List<String> listaColonias = _coloniasController.text.trim().split(',');
    // Comprobando si todos los valores fueron introducidos correctamente
    // Comprobando si las colonias fueron introducidas correctamente
    _permitirCalculo = true;
    for (String colonia in listaColonias) {
      if (double.tryParse(colonia.trim()) == null) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Colonias introducidas incorrectamente'),
            content: const Text(
                'Por favor introduce, al menos un solo valor (Ejemplo: 20), o valores separados sólo por comas (Ejemplo: 20,22,23).'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        _permitirCalculo = false;
      }
    }
    // Comprobando si la dilución fue introducida correctamente
    if (_tipoDilucionController == Dilucion.decimal) {
      if (double.tryParse(_dilucionController.text) == null ||
          double.tryParse(_dilucionController.text)! > 1 ||
          double.tryParse(_dilucionController.text)! <= 0) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title:
                const Text('Dilución en decimales introducida incorrectamente'),
            content: const Text(
                'Por favor introduce la dilución propiamente, debe estar en decimales y ser un valor mayor que 0, y menor o igual que 1.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        _permitirCalculo = false;
      }
    } else if (_tipoDilucionController == Dilucion.factor) {
      if (double.tryParse(_dilucionController.text) == null ||
          double.tryParse(_dilucionController.text)! < 1) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
                'Dilución con Factor de Dilución introducida incorrectamente'),
            content: const Text(
                'Por favor introduce la dilución propiamente, el factor de dilución debe ser igual o mayor a 1.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        _permitirCalculo = false;
      }
    } else if (_tipoDilucionController == Dilucion.cientifico) {
      if (double.tryParse(_dilucionController.text) == null ||
          double.tryParse(_dilucionController.text)! < 0) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
                'Dilución en notación científica introducida incorrectamente'),
            content: const Text(
                'Por favor introduce la dilución propiamente, no repitas el signo "-" ya colocado ni números menores a 0.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        _permitirCalculo = false;
      }
    }
    if (double.tryParse(_alicuotaController.text) == null ||
        double.tryParse(_alicuotaController.text)! <= 0) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
              'Alícuota de transferencia introducida incorrectamente'),
          content: const Text(
              'Por favor introduce la alícuota de transferencia propiamente, debe ser un número mayor que 0.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      _permitirCalculo = false;
    }

    // Lógica que se ejecuta si se permite el cálculo (_permitirCalculo)
    if (_permitirCalculo) {
      // Ecuación que calcula
      double promedioColonias = 0;
      double dilucion = 1;
      double alicuotaML = 1;
      // Obtener el promedio de las colonias
      for (final colonias in listaColonias) {
        promedioColonias += double.parse(colonias);
      }
      promedioColonias /= listaColonias.length;
      promedioColonias = double.parse(promedioColonias.toStringAsFixed(4));
      // Obtener la dilución
      if (_tipoDilucionController == Dilucion.factor) {
        dilucion = 1 / double.parse(_dilucionController.text);
      } else if (_tipoDilucionController == Dilucion.decimal) {
        dilucion = double.parse(_dilucionController.text);
      } else if (_tipoDilucionController == Dilucion.cientifico) {
        dilucion = (pow(10, -double.parse(_dilucionController.text)) as double);
      }
      // Obtener el volumen endouble promedioColonias = 0;
      if (_tipoVolumenController == TipoVolumen.mililitros) {
        alicuotaML = double.parse(_alicuotaController.text);
      } else if (_tipoVolumenController == TipoVolumen.microlitros) {
        alicuotaML = double.parse(_alicuotaController.text) / 1000;
      }
      final ufcMl = promedioColonias * (1 / dilucion) * (1 / alicuotaML);

      // Advertencia que se dispara si el promedio de colonias no está en rangos aceptables
      if (promedioColonias > 300 || promedioColonias < 25) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Aviso'),
            content: const Text(
                'El número de colonias (o su promedio) está fuera de los intervalos 25-250 y 30-300, considere utilizar otra dilución.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }

      // Actualización de las cartas LaTeX
      setState(() {
        respuesta = '${toSciNotation(ufcMl)}  \\ UFC/mL';
        if (_tipoDilucionController == Dilucion.decimal) {
          ecuacion =
              '$promedioColonias \\ UFC \\times \\frac{1}{$dilucion} \\times \\frac{1}{$alicuotaML \\ mL}';
        } else if (_tipoDilucionController == Dilucion.factor) {
          ecuacion =
              '$promedioColonias \\ UFC \\times ${_dilucionController.text} \\times \\frac{1}{$alicuotaML \\ mL}';
        } else if (_tipoDilucionController == Dilucion.cientifico) {
          ecuacion =
              '$promedioColonias \\ UFC \\times \\ \\frac{1}{1 \\times 10 \\ \\bar{ }  ^{\\ ${_dilucionController.text} }} \\times \\frac{1}{$alicuotaML \\ mL}';
        }
      });
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  // Estado inicial
  @override
  void initState() {
    super.initState();
    _alicuotaController.text = '0.1';
  }

  // Scaffold que se regresa
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        drawer: const CalcsDrawer(),
        appBar: AppBar(
          title: const Text('UFC/mL método clásico'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text(
                  'Colonias contadas (separar repeticiones por ",").',
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: _coloniasController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Colonias (repeticiones separadas por ",")')),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Dilución inoculada en la o las placas de Petri.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('¿Qué elegir?'),
                              content: const Text(
                                  'FACTOR:\nSi tienes un factor de dilución o una dilución expresada en Partes de muestra:Partes totales (Ejemplo: "1:100").\n\nDECIMAL:\nSi tienes una dilución expresada en decimales (Ejemplo: "0.01").\n\nCIENTIFICO:\nSi tienes una dilución expresada en notación científica (Ejemplo: "1×10^ -2")'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.help_outline))
                  ],
                ),
                Row(
                  children: [
                    if (_tipoDilucionController == Dilucion.decimal)
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _dilucionController,
                          decoration: const InputDecoration(
                            label: Text('Dilución (decimales)'),
                          ),
                        ),
                      )
                    else if (_tipoDilucionController == Dilucion.factor)
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _dilucionController,
                          decoration: const InputDecoration(
                            label: Text('Dilución con factor de dilución'),
                            prefix: Text('1:'),
                          ),
                        ),
                      )
                    else if (_tipoDilucionController == Dilucion.cientifico)
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _dilucionController,
                          decoration: const InputDecoration(
                            label: Text('Dilución en notación científica'),
                            prefix: Text('1×10^ -'),
                          ),
                        ),
                      ),
                    Center(
                      //width: 140,
                      child: DropdownButton(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        onChanged: (valor) {
                          setState(() {
                            _tipoDilucionController = valor!;
                          });
                        },
                        value: _tipoDilucionController,
                        items: [
                          ...Dilucion.values.map(
                            (dilucion) => DropdownMenuItem(
                              value: dilucion,
                              child: Text(
                                dilucion.name.toUpperCase(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Alícuota de transferencia.'),
                Row(
                  children: [
                    if (_tipoVolumenController == TipoVolumen.mililitros)
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _alicuotaController,
                          decoration: const InputDecoration(
                            label: Text('Volúmen en mL'),
                            suffix: Text(' mL'),
                          ),
                        ),
                      )
                    else if (_tipoVolumenController == TipoVolumen.microlitros)
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _alicuotaController,
                          decoration: const InputDecoration(
                            label: Text('Volúmen en μL'),
                            suffix: Text(' μL'),
                          ),
                        ),
                      ),
                    Center(
                      child: DropdownButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        onChanged: (valor) {
                          setState(() {
                            _tipoVolumenController = valor!;
                          });
                        },
                        value: _tipoVolumenController,
                        items: [
                          ...TipoVolumen.values.map(
                            (tipo) => DropdownMenuItem(
                              value: tipo,
                              child: Text(
                                tipo.name.toUpperCase(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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
                      respuesta,
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
                      ecuacion,
                      textStyle: TextStyle(
                        fontSize: 18,
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
