import 'package:calculadora_de_microbios/screens/acerca_de.dart';
import 'package:calculadora_de_microbios/screens/ayuda.dart';
import 'package:calculadora_de_microbios/screens/base_seca.dart';
import 'package:calculadora_de_microbios/screens/camara_neubauer.dart';
import 'package:calculadora_de_microbios/screens/intervalo_conf_t.dart';
import 'package:calculadora_de_microbios/screens/nmp_nom_coliformes.dart';
import 'package:calculadora_de_microbios/screens/rechazo.dart';
import 'package:calculadora_de_microbios/screens/todas_calculadoras.dart';
import 'package:calculadora_de_microbios/screens/ufc_clasico.dart';
import 'package:flutter/material.dart';

class CalcsDrawer extends StatelessWidget {
  const CalcsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Image.asset(
                'assets/brand/big_logo_calc.png',
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                size: 30,
              ),
              title: const Text(
                'Inicio',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil<void>(
                  //context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const TodasCalculadorasScreen()),
                  ModalRoute.withName('/'),
                );
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.keyboard_double_arrow_left,
                size: 30,
              ),
              title: const Text(
                'Anterior',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.blur_circular,
                size: 30,
              ),
              title: const Text(
                'UFC/mL Clásico',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const UfcClasicoScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.view_week_rounded,
                size: 30,
              ),
              title: const Text(
                'NMP coliformes',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const NmpNomColiformesScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.water,
                size: 30,
              ),
              title: const Text(
                'Células Base Seca',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const BaseSecaScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.width_normal_rounded,
                size: 30,
              ),
              title: const Text(
                'Cámara Neubauer',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const CamaraNeubauer()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.candlestick_chart,
                size: 30,
              ),
              title: const Text(
                'Prueba de rechazo',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const RechazoScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bar_chart,
                size: 30,
              ),
              title: const Text(
                'Intervalo confianza',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const IntervaloConfianzaTScreen()));
              },
            ),
            const Divider(
              thickness: 2,
            ),
            ListTile(
              leading: const Icon(
                Icons.help,
                size: 30,
              ),
              title: const Text(
                'Ayuda/Referencias',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const AyudaScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.contact_page,
                size: 30,
              ),
              title: const Text(
                'Acerca de',
                style: TextStyle(fontSize: 24),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => const AcercaDeScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
