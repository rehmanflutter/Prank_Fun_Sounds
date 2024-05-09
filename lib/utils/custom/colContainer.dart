import 'package:flutter/material.dart';

class ColContainer extends StatelessWidget {
  final double? hight;
  final double wigth;
  final double? cir;
  final bool? boarder;
  final Widget? child;
  final Color? borderCol;
  final Color? Col;
  ColContainer({
    this.hight,
    required this.wigth,
    this.cir = 0,
    this.boarder = false,
    this.child,
    this.borderCol = Colors.white,
    this.Col = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: wigth,
      decoration: BoxDecoration(
        color: Col,
        borderRadius: BorderRadius.circular(cir!),
        border:
            boarder == true ? Border.all(color: borderCol!, width: 1) : null,
      ),
      child: child,
    );
  }
}

class ImageContainer extends StatelessWidget {
  final double? hight;
  final double wigth;
  final double? cir;
  final String image;
  ImageContainer(
      {this.hight, required this.wigth, this.cir = 0, required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: wigth,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill)),
    );
  }
}
