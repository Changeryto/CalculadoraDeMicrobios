import 'package:flutter/material.dart';

class SliderWithBox extends StatelessWidget {
  const SliderWithBox({
    super.key,
    this.decimals = 0,
    required this.value,
    required this.max,
    required this.divisions,
    required this.label,
    required this.onChanged,
    required this.boxColor,
    required this.numberColor,
  });

  final int decimals;
  final double value;
  final double max;
  final int divisions;
  final String label;
  final void Function(double selection) onChanged;
  final Color boxColor;
  final Color numberColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Text(
            value.toStringAsFixed(decimals),
            style: TextStyle(
              fontSize: 25,
              color: numberColor,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            inactiveColor: numberColor.withAlpha(70),
            activeColor: numberColor.withGreen(80),
            thumbColor: numberColor.withBlue(80),
            value: value,
            max: max,
            divisions: divisions,
            label: label,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
