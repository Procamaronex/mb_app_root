import 'package:flutter/material.dart';
import 'package:mb_app_root/utils/app_theme.dart';

import '../utils/app_colors.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom(
      {super.key,
      required this.label,
      required this.isEnabled,
      required this.onPressed,
      required this.icon,
      required this.color,
      required this.fontColor});

  final String label;
  final bool isEnabled;
  final VoidCallback onPressed;
  final icon;
  final color;
  final fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed:  isEnabled ? onPressed : null,
        icon: Icon(
          icon,
          color: fontColor,
        ),
        label: Text(
          label,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: fontColor),
        ),
      ),
    );
  }
}
