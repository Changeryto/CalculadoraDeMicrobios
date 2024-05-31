/*List<double> stringToDoubleList(String stringPorConvertir,
    {String separator = ','}){

    }
*/
dynamic tryStringToDoubleList(String stringPorConvertir,
    {String separator = ','}) {
  final lista = stringPorConvertir.split(separator);
  List<double> listaConvertida = [];
  for (final valor in lista) {
    if (double.tryParse(valor) == null) {
      return null;
    } else {
      listaConvertida.add(double.parse(valor));
    }
  }
  return listaConvertida;
}
