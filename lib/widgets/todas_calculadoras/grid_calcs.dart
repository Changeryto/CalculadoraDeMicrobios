import 'package:calculadora_de_microbios/screens/base_seca.dart';
import 'package:calculadora_de_microbios/screens/camara_neubauer.dart';
import 'package:calculadora_de_microbios/screens/intervalo_conf_t.dart';
import 'package:calculadora_de_microbios/screens/nmp_nom_coliformes.dart';
import 'package:calculadora_de_microbios/screens/rechazo.dart';
import 'package:calculadora_de_microbios/screens/ufc_clasico.dart';
import 'package:calculadora_de_microbios/widgets/todas_calculadoras/grid_calc_item.dart';
import 'package:flutter/material.dart';

// GridCalcs crea un grid con distintos widgets de GridCalcItem cada uno
class GridCalcs extends StatelessWidget {
  const GridCalcs({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;

    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 10 / 11,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: [
        GridCalcItem(
            nombre: 'UFC/mL método clásico',
            imagenLink: 'assets/calcs/ufc.jpg',
            onTapAction: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const UfcClasicoScreen()));
            }),
        GridCalcItem(
          nombre: 'NMP Coliformes (NOM)',
          imagenLink: 'assets/calcs/nmp_coliformes.jpg',
          onTapAction: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const NmpNomColiformesScreen()));
          },
        ),
        GridCalcItem(
          nombre: 'Células en base seca',
          imagenLink: 'assets/calcs/base_seca.jpg',
          onTapAction: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const BaseSecaScreen()));
          },
        ),
        GridCalcItem(
          nombre: 'Cámara de Neubauer',
          imagenLink: 'assets/calcs/neubauer.jpg',
          onTapAction: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const CamaraNeubauer()),
            );
          },
        ),
        GridCalcItem(
          nombre: 'Rechazo (Q de Dixon)',
          imagenLink: 'assets/calcs/rechazo.jpg',
          onTapAction: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const RechazoScreen()));
          },
        ),
        GridCalcItem(
          nombre: 'Intervalo de confianza (t Student)',
          imagenLink: 'assets/calcs/t_test.png',
          onTapAction: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const IntervaloConfianzaTScreen()));
          },
        ),
      ],
    );
  }
}
