import 'package:flutter/cupertino.dart';

class ArrowClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.width);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}