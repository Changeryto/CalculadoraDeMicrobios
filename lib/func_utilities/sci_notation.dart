String toSciNotation(double number,
    {int decPlaces = 4, bool expEntero = true}) {
  final lista = number.toStringAsExponential().split('e+');
  final coeficiente =
      double.parse(double.parse(lista[0]).toStringAsFixed(decPlaces));

  if (expEntero) {
    final exponente = lista[1];
    return '$coeficiente \\times 10 ^{$exponente}';
  } else {
    final exponente =
        double.parse(double.parse(lista[1]).toStringAsFixed(decPlaces));
    return '$coeficiente \\times 10 ^{$exponente}';
  }
}
