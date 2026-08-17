import 'package:flutter/material.dart';

class DripWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size){
    final path = Path();
    path.lineTo(0, size.height * 0.72);
    path.cubicTo(
      size.width * 0.12, size.height * 0.72,
      size.width * 0.12, size.height * 1.0,
      size.width * 0.22, size.height * 1.0,
    );
    path.cubicTo(
      size.width * 0.30, size.height * 1.0,
      size.width * 0.30, size.height * 0.72,
      size.width * 0.40, size.height * 0.72,
    );
    path.cubicTo(
      size.width * 0.50, size.height * 0.72,
      size.width * 0.50, size.height * 0.94,
      size.width * 0.60, size.height * 0.94,
    );
    path.cubicTo(
      size.width * 0.68, size.height * 0.94,
      size.width * 0.68, size.height * 0.72,
      size.width * 0.78, size.height * 0.72,
    );

    path.lineTo(size.width, size.height * 0.72);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
  
}