import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XylophoneButton extends StatelessWidget {
  const XylophoneButton({super.key, required this.color, required this.onPressed});
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child:  InkWell(
      onTap: onPressed,
      child: Container(
        height: 200,
        width: double.infinity,
        color: color,
      ),
    )
    );
  }
}
