import 'package:flutter/material.dart';

import 'package:transparent_image/transparent_image.dart';

class GridCalcItem extends StatelessWidget {
  const GridCalcItem({
    super.key,
    required this.nombre,
    required this.imagenLink,
    required this.onTapAction,
    this.textSize = 20,
  });

  final String nombre;
  final String imagenLink;
  final void Function() onTapAction;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTapAction,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(imagenLink),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Theme.of(context).colorScheme.background.withAlpha(150),
                child: Text(
                  nombre,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: textSize),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
