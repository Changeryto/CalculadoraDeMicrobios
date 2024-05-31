import 'package:calculadora_de_microbios/func_utilities/dispertion.dart';
import 'package:calculadora_de_microbios/func_utilities/fast_alert.dart';
import 'package:calculadora_de_microbios/func_utilities/sci_notation.dart';
import 'package:calculadora_de_microbios/func_utilities/string_to_double_list.dart';
import 'package:calculadora_de_microbios/models/dilucion.dart';
import 'package:calculadora_de_microbios/widgets/drawers/calcs_drawer.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum AreaNeubauer { leucocitos, eritrocitos }

class CamaraNeubauer extends StatefulWidget {
  const CamaraNeubauer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CamaraNeubauerState();
  }
}

class _CamaraNeubauerState extends State<CamaraNeubauer> {
  // Manejadores
  final _valoresAPruebaController = TextEditingController();
  final _profundidadController = TextEditingController();
  final _areaMinimaController = TextEditingController();
  final _dilucionController = TextEditingController();
  AreaNeubauer _areaConteoController = AreaNeubauer.leucocitos;
  Dilucion _tipoDilucionController = Dilucion.factor;

  // Variable que cambia según el area
  int _maxConteoCelular = 8;
  // TeX
  String _respuesta = 'cels/mL';
  String _respuesta2 = 'cels/mm^{3}';
  String _ecuacion =
      '\\bar{x} \\times \\frac{1}{Dilución} \\times \\frac{1}{Lado\\ del\\ cuadrante^{2} \\times Profundidad} \\times \\frac{1000\\ mm^{3}}{1\\ cm^{3}} \\times \\frac{cm^{3}}{mL}';
  String _ecuacion2 =
      '\\bar{x} \\times \\frac{1}{Dilución} \\times \\frac{1}{Lado\\ del\\ cuadrante^{2} \\times Profundidad}';
  /*
  String _ecuacion =
      '\\bar{x} \\times \\frac{1}{0. 01} \\times \\frac{1}{(1\\ mm)^{2} \\times 0.1\\ mm} \\times \\frac{1000\\ mm^{3}}{1\\ cm^{3}} \\times \\frac{cm^{3}}{mL}';
      */

  _helpNeubauerValues() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Valores en la cámara de Neubauer',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Aceptar'))
        ],
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Profundidad: '),
              const SizedBox(height: 20),
              Image.asset(
                'assets/neubauer/profundidad.png',
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(height: 30),
              const Text('Área mínima: '),
              const SizedBox(height: 20),
              Image.asset(
                'assets/neubauer/area_minima.png',
                color: Theme.of(context).colorScheme.onBackground,
              )
            ],
          ),
        ),
      ),
    );
  }

  _helpNeubauerAreas() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Áreas en la cámara de Neubauer',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Aceptar'))
        ],
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Área de conteo de leucocitos: '),
              const SizedBox(height: 20),
              Image.asset(
                'assets/neubauer/conteo_leucocitos.png',
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(height: 30),
              const Text('Área de conteo de eritrocitos: '),
              const SizedBox(height: 20),
              Image.asset(
                'assets/neubauer/conteo_eritrocitos.png',
                color: Theme.of(context).colorScheme.onBackground,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onCalcular() {
    bool permitirCalculo = true;
    final valores = tryStringToDoubleList(_valoresAPruebaController.text);
    final profundidad = double.tryParse(_profundidadController.text);
    final areaMinima = double.tryParse(_areaMinimaController.text);

    if (valores == null || valores.length > _maxConteoCelular) {
      fastAlert(
        context,
        titulo: const Text('Células contadas introducidas incorrectamente'),
        mensaje: Text(
            'Por favor introduce de 1 a $_maxConteoCelular valores separados por ",".\nEjemplo: "12,13,14" o "12, 13, 14".'),
      );
      permitirCalculo = false;
    }
    if (profundidad == null || profundidad.isNegative) {
      fastAlert(
        context,
        titulo: const Text('Profundidad introducida incorrectamente'),
        mensaje: const Text(
            'Por favor introduce únicamente un número positivo como profundidad de la cámara'),
      );
      permitirCalculo = false;
    }
    if (areaMinima == null || areaMinima.isNegative) {
      fastAlert(
        context,
        titulo: const Text('Área mínima introducida incorrectamente'),
        mensaje: const Text(
            'Por favor introduce un número positivo como área mínima de la cámara'),
      );
      permitirCalculo = false;
    }

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
        permitirCalculo = false;
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
        permitirCalculo = false;
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
        permitirCalculo = false;
      }
    }

    // Lógica que se ejecuta si se permite el cálculo
    if (permitirCalculo) {
      final double respuesta;
      final double ladoCuadrante;
      final String promedioTeX;
      String valoresEnSuma = '';
      final String dilucionTeX;
      final num dilucion;

      if (valores.length > 1) {
        for (final valor in valores) {
          valoresEnSuma = '$valoresEnSuma+ $valor';
        }
        promedioTeX =
            '\\frac{ ${valoresEnSuma.substring(1)} }{ ${valores.length} }';
      } else {
        promedioTeX = valores[0].toString();
      }

      switch (_tipoDilucionController) {
        case Dilucion.cientifico:
          dilucion = pow(10, -double.parse(_dilucionController.text));
          dilucionTeX =
              '\\frac{1}{ 1 \\times 10 \\ \\bar{ }\\ ^{${_dilucionController.text}} }';
          break;
        case Dilucion.decimal:
          dilucion = double.parse(_dilucionController.text);
          dilucionTeX = '\\frac{1}{ ${_dilucionController.text} }';
          break;
        default:
          dilucion = (1 / double.parse(_dilucionController.text));
          dilucionTeX = _dilucionController.text;
      }

      switch (_areaConteoController) {
        case AreaNeubauer.eritrocitos:
          ladoCuadrante = sqrt(double.parse(_areaMinimaController.text)) * 4;
          break;
        default:
          ladoCuadrante = sqrt(double.parse(_areaMinimaController.text)) * 20;
      }

      respuesta = mean(valores) *
          (1 / dilucion) *
          (1 /
              (pow(ladoCuadrante, 2) *
                  double.parse(_profundidadController.text))) *
          1000;

      setState(
        () {
          _respuesta = '${toSciNotation(respuesta)} \\ cels/mL';
          _respuesta2 = '${toSciNotation(respuesta / 1000)} \\ cels/mm^{3}';
          _ecuacion =
              '$promedioTeX \\times $dilucionTeX \\times \\frac{1}{( $ladoCuadrante mm)^{2} \\times ${_profundidadController.text}\\ mm} \\times \\frac{1000\\ mm^{3}}{1\\ cm^{3}} \\times \\frac{cm^{3}}{mL}';
          _ecuacion2 =
              '$promedioTeX \\times $dilucionTeX \\times \\frac{1}{( $ladoCuadrante mm)^{2} \\times ${_profundidadController.text}\\ mm}';
        },
      );
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void initState() {
    _profundidadController.text = '0.1';
    _areaMinimaController.text = '0.0025';
    super.initState();
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
          title: const Text('Cámara de Neubauer'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Área de conteo celular'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: _areaConteoController,
                      items: [
                        ...AreaNeubauer.values.map(
                          (area) => DropdownMenuItem(
                            value: area,
                            child: Text('Área de conteo de ${area.name}'),
                          ),
                        ),
                      ],
                      onChanged: (area) {
                        if (area == AreaNeubauer.leucocitos) {
                          _maxConteoCelular = 8;
                        } else {
                          _maxConteoCelular = 10;
                        }
                        setState(
                          () {
                            _maxConteoCelular;
                            _areaConteoController = area!;
                          },
                        );
                      },
                    ),
                    IconButton(
                      onPressed: _helpNeubauerAreas,
                      icon: const Icon(Icons.help_outline),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Células'),
                    Text(
                      ' por cuadrante ',
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                    Text('(o media) separadas por ","'),
                  ],
                ),
                TextField(
                  controller: _valoresAPruebaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                        'De 1 a $_maxConteoCelular valores separados por ","'),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Dilución observada en la cámara de Neubauer.',
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
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Text('Profundidad:'),
                            ),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: _profundidadController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  suffix: Text('mm'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 12),
                              child: Text('Área mínima:'),
                            ),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: _areaMinimaController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  suffix: Text('mm²'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      iconSize: 50,
                      icon: const Icon(Icons.help_outline),
                      onPressed: _helpNeubauerValues,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                    child: Column(
                      children: [
                        Math.tex(
                          _respuesta,
                          textStyle: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Math.tex(
                          _respuesta2,
                          textStyle: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new),
                    Text('Ecuación utilizada (deslizable)'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.all(8),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Math.tex(
                            _ecuacion,
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Math.tex(
                            _ecuacion2,
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ),
                        ],
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


// Referencia: http://bvs.minsa.gob.pe/local/INS/845_MS-INS-NT40.pdf