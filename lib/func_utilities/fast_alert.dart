import 'package:flutter/material.dart';
/*
class FastAlert extends StatelessWidget {
  FastAlert({
    super.key,
    required this.title,
    required this.messege
  });

  @override
  Future<dynamic> build(BuildContext context) {
    return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Células/g introducidas incorrectamente'),
            content: const Text(
                'Por favor introduce un número positivo mayor o igual a 0 células/g.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Aceptar',
                ),
              )
            ],
          ),
        );
  }
}
*/

void fastAlert(
  context, {
  required Text titulo,
  required Text mensaje,
}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: titulo,
      content: mensaje,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text(
            'Aceptar',
          ),
        )
      ],
    ),
  );
}
