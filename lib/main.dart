import 'package:calculadora_de_microbios/screens/todas_calculadoras.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Se definen los esquemas de colores globales Y los temas claro y oscuro.
final kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromRGBO(107, 22, 64, 1));

final kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(107, 22, 64, 1),
    brightness: Brightness.dark);

final tema = ThemeData(
  colorScheme: kColorScheme,
);

// final temaDark = ThemeData.dark();

// Se define el tema oscuro
final temaDark = ThemeData(
  colorScheme: kDarkColorScheme,
);

// Está definiendo que debe usarse modo retrato obligatorio
void main() {
  // Para definir las orientaciones permitidas
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (fn) {
      runApp(const App());
    },
  );
}

// Llama a la pantalla Scaffold TodasCalculadorasScreen
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: tema,
      darkTheme: temaDark,
      themeMode: ThemeMode.system,
      home: const TodasCalculadorasScreen(),
    );
  }
}
//"calculadora_de_microbios.primera.esperanza"