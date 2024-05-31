import 'package:calculadora_de_microbios/models/q_dixon_2tail_table.dart';
import 'package:calculadora_de_microbios/models/confianza.dart';

double oneDixonTest(List<double> listaInicial, {required Confianza confianza}) {
  if (listaInicial.length < 3) {
    return double.nan;
  }
  listaInicial.sort();
  final qTabla = obtenerValorQTabla(listaInicial, confianza: confianza);

  //final intervalo = listaInicial.reduce(max) - listaInicial.reduce(min);
  final intervalo = listaInicial.last - listaInicial.first;
  final distanciaIzquierda = (listaInicial[1] - listaInicial.first).abs();
  final distanciaDerecha =
      (listaInicial.last - listaInicial[listaInicial.length - 2]).abs();
  if (distanciaIzquierda > distanciaDerecha) {
    // Lógica que se ejecuta si el rechazo es por la izquierda
    final qCalculada = distanciaIzquierda / intervalo;
    if (qCalculada > qTabla) {
      return listaInicial.first;
    } else {
      return double.nan;
    }
  } else {
    // Lógica que se ejecuta si el rechazo es por la derecha
    final qCalculada = distanciaDerecha / intervalo;
    if (qCalculada > qTabla) {
      return listaInicial.last;
    } else {
      return double.nan;
    }
  }
}

double obtenerValorQTabla(List<double> listaInicial,
    {required Confianza confianza}) {
  listaInicial.sort();

  return q2TailDixonTable[confianza.name]![listaInicial.length - 3];
}

bool isLeftFarthestValue(List<double> listaInicial) {
  if (listaInicial.length < 3) {
    throw const FormatException('Expected at least 1 section');
  }
  listaInicial.sort();
  final distanciaIzquierda = (listaInicial[1] - listaInicial.first).abs();
  final distanciaDerecha =
      (listaInicial.last - listaInicial[listaInicial.length - 2]).abs();
  if (distanciaIzquierda > distanciaDerecha) {
    return true;
  } else {
    return false;
  }
}

bool isRightFarthestValue(List<double> listaInicial) {
  if (listaInicial.length < 3) {
    throw const FormatException('Expected at least 1 section');
  }
  listaInicial.sort();
  final distanciaIzquierda = (listaInicial[1] - listaInicial.first).abs();
  final distanciaDerecha =
      (listaInicial.last - listaInicial[listaInicial.length - 2]).abs();
  if (distanciaIzquierda > distanciaDerecha) {
    return false;
  } else {
    return true;
  }
}
