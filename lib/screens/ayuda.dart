import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class AyudaScreen extends StatelessWidget {
  const AyudaScreen({super.key});

  final double _textSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda y referencas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                'Historial',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Este programa almacena temporalmente el estado del uso de una herramienta, puedes acceder a una herramienta nueva desde el menú lateral, y después volver a la pantalla anterior con el cálculo aún realizado con los gestos de tu teléfono o con la opción "Anterior" en el mismo menú, el historial se borrará al volver al Inicio.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/calcs/ufc.jpg'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withAlpha(150),
                      child: Text(
                        'UFC/mL Método Clásico',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: _textSize),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Calcula las unidades formadoras de colonias (UFC) en 1 mL o g (según el estado de agregación de la muestra inicial) obtenidas tras una extensión en placa con asa acodada de cualquier dilución, esté expresada con factor de dilución, en notación científica, o decimal, esta herramienta puede automáticamente calcular calcular los promedios de los valores introducidos.\n\nReferencia:\nK. S. Bender., D. H. Buckley., Madigan, M. T., Martinko, J. M., & Stahl, D. S. (2015). Crecimiento y control microbiano. In Brock. Biologia de los microorganismos (14th ed., pp. 162–163). Pearson Education. ',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/calcs/nmp_coliformes.jpg'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withAlpha(150),
                      child: Text(
                        'NMP Coliformes NOM',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: _textSize),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Consulta el Número Más Probable (NMP) de microorganismos en 1 mL o g (según la muestra) en la "NORMA Oficial Mexicana NOM-112-SSA1-1994, Bienes y servicios. Determinación de bacterias coliformes. Técnica del número más probable.", a partir de los controles deslizables, el selector de diluciones, y el botón de "número de tubos" para establecer los parámetros de consulta, el resultado se actualiza en cada cambio.\n\nReferencia:\nSecretaría de Salud (SSA). (1994). NOM-112-SSA1-1994, Bienes y servicios. Determinación de bacterias coliformes. Técnica del número más probable. Ciudad de México: SSA.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/calcs/base_seca.jpg'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withAlpha(150),
                      child: Text(
                        'Células en base seca',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: _textSize),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Calcula el número de microorganismos en 1 g de muestra seca o deshidratada a partir del número de microorganismos en 1 g de muestra húmeda conociendo el porcentaje de humedad.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/calcs/neubauer.jpg'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withAlpha(150),
                      child: Text(
                        'Cámara de Neubauer',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: _textSize),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Calcula el número de células en 1 mL y en 1 mm³ de muestra a partir de cualquier disolución observada en la cámara de Neubauer, tanto en el área de conteo de leucocitos como en el área de conteo de eritrocitos, puede personalizarse tanto la profundidad como el área mínima, sin embargo se asume que el área mínima mantiene la misma proporcionalidad con el resto de la cámara sin importar cuál sea esta.\n\nReferencia:\nUniversidad Nacional Autónoma de México. (2018). Anexo 2: Cámara de Neubauer. Blog del Manual del Laboratorio. https://blogceta.zaragoza.unam.mx/manualbct2/anexo-2-camara-de-neubauer/ ',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/calcs/rechazo.jpg'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withAlpha(150),
                      child: Text(
                        'Prueba de rachazo (Q de Dixon)',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: _textSize),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Efectúa recursivamente la prueba de rechazo Q de Dixon de 2 colas, a distintos porcentajes de confianza según la elección del usuario, muestra los valores rechazados en orden y las ecuaciones que llevaron a considerar el rechazo, los valores Q crítica fueron obtenidos del artículo de Rorabacher, D.B.(1991).\n\nReferencias:\nRorabacher, D.B. (1991). Statistical treatment for rejection of deviant values: critical values of Dixon\'s "Q" parameter and related subrange ratios at the 95% confidence level. Analytical Chemistry, 63, 139-146.\n\nSkoog, D., West, D., Crouch, S., & Holler, F. (2010). Fundamentos de química analítica (8th ed., pp. 145-170). Mexico: Cengage Learning.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/calcs/t_test.png'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withAlpha(150),
                      child: Text(
                        'Intervalo de confianza (T de Student)',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: _textSize),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'Calcula el intervalo de confianza a dos colas del conjunto de valores otorgados, a distintos porcentajes de confianza según la elección del usuario, los valores de t fueron obtenidos de R Core Team (2023).\n\nReferencia:\nR Core Team (2023). _R: A Language and Environment for Statistical Computing_. R Foundation for Statistical Computing, Vienna, Austria. <https://www.R-project.org/>.\n\nSkoog, D., West, D., Crouch, S., & Holler, F. (2010). Fundamentos de química analítica (8th ed., pp. 145-170). Mexico: Cengage Learning.',
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
