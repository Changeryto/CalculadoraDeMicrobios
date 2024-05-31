import 'package:calculadora_de_microbios/screens/acerca_de.dart';
import 'package:calculadora_de_microbios/screens/ayuda.dart';
import 'package:flutter/material.dart';

class StartDrawer extends StatelessWidget {
  const StartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const AcercaDeScreen()));
            },
          )
        ],
      ),
    );
  }
}
