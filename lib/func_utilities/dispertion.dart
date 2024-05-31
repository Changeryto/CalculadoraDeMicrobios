import 'dart:math';

import 'package:calculadora_de_microbios/models/confianza.dart';
import 'package:calculadora_de_microbios/models/t_2tail_table.dart';
//import 'package:calculadora_de_microbios/models/t_2tail_table.dart';

double standardDeviation(List<double> conjunto) {
  return sqrt(variance(conjunto));
}

double variance(List<double> conjunto) {
  double meanCal = mean(conjunto);

  double sumatoria = 0;
  for (final valor in conjunto) {
    sumatoria += pow((valor - meanCal), 2);
  }

  return ((1 / (conjunto.length - 1)) * sumatoria);
}

double mean(List<double> conjunto) {
  double mean = 0;
  for (final valor in conjunto) {
    mean += valor;
  }
  mean /= conjunto.length;
  return mean;
}

double tFromTable(int n, Confianza confianza) {
  return t2TailTable[confianza]![n - 2];
}

double confidenceGap(
  List<double> conjunto,
  Confianza confianza,
) {
  double tTabla = tFromTable(conjunto.length, confianza);
  double gap = tTabla * (standardDeviation(conjunto) / sqrt(conjunto.length));
  return gap.abs();
}
