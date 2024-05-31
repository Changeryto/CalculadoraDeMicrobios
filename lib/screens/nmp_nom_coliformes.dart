import 'package:calculadora_de_microbios/models/nmp_nom_coliformes/nmp_pg_table.dart';
import 'package:calculadora_de_microbios/widgets/drawers/calcs_drawer.dart';
import 'package:calculadora_de_microbios/widgets/slider_with_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class NmpNomColiformesScreen extends StatefulWidget {
  const NmpNomColiformesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UfcNomColiformesScreenState();
  }
}

class _UfcNomColiformesScreenState extends State<NmpNomColiformesScreen> {
  //Manjeadores
  double _mayorDilTubos = 0;
  double _mediaDilTubos = 0;
  double _menorDilTubos = 0;
  double _tubosPorDil = 3;
  WeigthNMPTable _tipoDilucionesNMP = WeigthNMPTable.nmp10gTable;

  // TeX
  String _respuesta = '';
  String _limInferior = '';
  String _limSuperior = '';
  String _resumen = '';
  bool _obtenido = false;

  // Al presionar Obtener
  _onCambiarTubos() {
    if (_tubosPorDil == 3) {
      _tubosPorDil = 5;
    } else if (_tubosPorDil == 5) {
      _tubosPorDil = 3;
      if (_mayorDilTubos > 3) {
        _mayorDilTubos = 3;
      }
      if (_mediaDilTubos > 3) {
        _mediaDilTubos = 3;
      }
      if (_menorDilTubos > 3) {
        _menorDilTubos = 3;
      }
    }
    setState(
      () {
        _tubosPorDil;
      },
    );
    _onObtener();
  }

  _onObtener() {
    final String tresCifras =
        '${_mayorDilTubos.toStringAsFixed(0)}-${_mediaDilTubos.toStringAsFixed(0)}-${_menorDilTubos.toStringAsFixed(0)}';

    final Map tablaNecesaria;

    switch (_tipoDilucionesNMP) {
      case WeigthNMPTable.nmp10gTable:
        tablaNecesaria = nmp10gTable;

      case WeigthNMPTable.nmp1gTable:
        tablaNecesaria = nmp1gTable;

      case WeigthNMPTable.nmp100mgTable:
        tablaNecesaria = nmp100mgTable;

      case WeigthNMPTable.nmp10mgTable:
        tablaNecesaria = nmp10mgTable;

      default:
        tablaNecesaria = nmp100mgTable;
    }

    // Si las tres cifras son aceptables
    if (tablaNecesaria[_tubosPorDil.toStringAsFixed(0)]!
        .keys
        .contains(tresCifras)) {
      final consultaEnTabla =
          tablaNecesaria[_tubosPorDil.toStringAsFixed(0)]![tresCifras]!;
      setState(
        () {
          _respuesta = '${consultaEnTabla[0]}\\ NMP/mL\\ (NMP/g)';
          _limInferior = '${consultaEnTabla[1]}\\ NMP/mL\\ (NMP/g)';
          _limSuperior = '${consultaEnTabla[2]}\\ NMP/mL\\ (NMP/g)';

          _obtenido = true;
        },
      );
      /*ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(
              'Tubos positivos: $tresCifras de ${_tubosPorDil.toStringAsFixed(0)} tubos. \nDiluciones: ${nmpNombreDiluciones[_tipoDilucionesNMP]}.')));*/
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      setState(() {
        _respuesta = 'No\\ disponible';
        _limInferior = 'No\\ disponible';
        _limSuperior = 'No\\ disponible';
        _resumen =
            'Se recomienda descartar el ensayo para $tresCifras con ${_tubosPorDil.toStringAsFixed(0)} tubos inoculados para las diluciones: ${nmpNombreDiluciones[_tipoDilucionesNMP]}.';
        _obtenido = false;
      });
      /*fastAlert(
        context,
        titulo: const Text('Combinación no aceptable'),
        mensaje: Text(
          'La combinación de tubos $tresCifras no es aceptable para las diluciones ${nmpNombreDiluciones[_tipoDilucionesNMP]} con ${_tubosPorDil.toStringAsFixed(0)} tubos inoculados por dilucón, y debería descartar este ensayo por norma.',
          textAlign: TextAlign.justify,
        ),
      );*/
    }
  }

  @override
  void initState() {
    super.initState();
    _onObtener();
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
          title: const Text('NMP coliformes según NOM'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tubos inoculados por dilución:'),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          _tubosPorDil == 3
                              ? Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withAlpha(180)
                              : Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer
                                  .withAlpha(180),
                        ),
                        iconColor: MaterialStatePropertyAll(
                          _tubosPorDil == 3
                              ? Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer
                                  .withAlpha(200)
                              : Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer
                                  .withAlpha(200),
                        ),
                      ),
                      onPressed: _onCambiarTubos,
                      icon: const Icon(Icons.view_week_rounded),
                      label: Text(
                        _tubosPorDil.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.7),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Diluciones inoculadas:'),
                    DropdownButton(
                      value: _tipoDilucionesNMP,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      items: [
                        ...WeigthNMPTable.values.map(
                          (tipo) => DropdownMenuItem(
                            value: tipo,
                            alignment: Alignment.centerRight,
                            child: Text(nmpNombreDiluciones[tipo]!),
                          ),
                        ),
                      ],
                      onChanged: (tipo) {
                        setState(
                          () {
                            _tipoDilucionesNMP = tipo!;
                          },
                        );
                        _onObtener();
                      },
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 40, bottom: 18),
                      child: Text('g o mL / tubo'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Tubos positivos con ${nmpNombreDiluciones[_tipoDilucionesNMP]!.split(' - ')[0]} g o mL',
                ),
                SliderWithBox(
                  value: _mayorDilTubos,
                  max: _tubosPorDil,
                  divisions: _tubosPorDil.toInt(),
                  label: _mayorDilTubos.toStringAsFixed(0),
                  boxColor: _tubosPorDil == 3
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.tertiaryContainer,
                  numberColor: _tubosPorDil == 3
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onTertiaryContainer,
                  onChanged: (selection) {
                    setState(
                      () {
                        _mayorDilTubos = selection;
                        _onObtener();
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                    'Tubos positivos con ${nmpNombreDiluciones[_tipoDilucionesNMP]!.split(' - ')[1]} g o mL'),
                SliderWithBox(
                  value: _mediaDilTubos,
                  max: _tubosPorDil,
                  divisions: _tubosPorDil.toInt(),
                  label: _mediaDilTubos.toStringAsFixed(0),
                  boxColor: _tubosPorDil == 3
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.tertiaryContainer,
                  numberColor: _tubosPorDil == 3
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onTertiaryContainer,
                  onChanged: (selection) {
                    setState(
                      () {
                        _mediaDilTubos = selection;
                        _onObtener();
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                    'Tubos positivos con ${nmpNombreDiluciones[_tipoDilucionesNMP]!.split(' - ')[2]} g o mL'),
                SliderWithBox(
                  value: _menorDilTubos,
                  max: _tubosPorDil,
                  divisions: _tubosPorDil.toInt(),
                  label: _menorDilTubos.toStringAsFixed(0),
                  boxColor: _tubosPorDil == 3
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.tertiaryContainer,
                  numberColor: _tubosPorDil == 3
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onTertiaryContainer,
                  onChanged: (selection) {
                    setState(
                      () {
                        _menorDilTubos = selection;
                        _onObtener();
                      },
                    );
                  },
                ),
                const SizedBox(height: 8),
                /*ElevatedButton(
                  onPressed: _onObtener,
                  child: const Text('OBTENER'),
                ),
                const SizedBox(height: 8),*/
                const Text('Índice de Número Más Probable:'),
                Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Math.tex(
                      _respuesta,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('95% Límite de confianza inferior:'),
                Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Math.tex(
                      _limInferior,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const Text('95% Límite de confianza superior:'),
                Card(
                  elevation: 2,
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Math.tex(
                      _limSuperior,
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (!_obtenido) Text(_resumen),
                /*const SizedBox(
                  height: 60,
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
