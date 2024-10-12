import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final double height;
  final Function() onTap;
  final String label;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;

  const Button({
    Key? key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.label,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor, // Cor da borda
            width: 2, // Largura da borda
          ),
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor, // Cor de fundo
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor, // Cor do texto
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
