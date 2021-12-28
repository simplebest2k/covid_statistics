import 'package:flutter/cupertino.dart';

enum ArrowDirection { UP, MIDDLE, DOWN }

class ArrowClipPath extends CustomClipper<Path> {
  ArrowDirection direction;

  ArrowClipPath({required this.direction});

  @override
  Path getClip(Size size) {
    var path = Path();

    if (direction == ArrowDirection.UP) {
      path.moveTo(0, size.width);
      path.lineTo(size.width * 0.5, 0);
      path.lineTo(size.width, size.height);
    } else if (direction == ArrowDirection.DOWN) {
      path.moveTo(0, 0);
      path.lineTo(size.width * 0.5, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, size.height * 0.3);
      path.lineTo(size.width, size.height * 0.3);
      path.lineTo(size.width, size.height * 0.7);
      path.lineTo(0, size.height * 0.7);
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}